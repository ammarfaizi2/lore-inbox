Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUAAVhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUAAVd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:33:56 -0500
Received: from mail3.speakeasy.net ([216.254.0.203]:22422 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S265484AbUAAVbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:31:44 -0500
Message-ID: <3FF491BD.5060806@speakeasy.net>
Date: Thu, 01 Jan 2004 13:31:41 -0800
From: John Gardiner Myers <jgmyers@speakeasy.net>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [rfc/patch] wake_up_info() draft ...
References: <fa.nd6oiha.q2gq9k@ifi.uio.no>
In-Reply-To: <fa.nd6oiha.q2gq9k@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor issues:

I don't know why dup_wait_info() returns a value--it is always ignored.  
If duping can fail, the situation is not particularly recoverable.

I don't like that the dup method is responsible for copying the dup and 
dtor members of struct __wait_info.  It would be simpler for the common 
code in dup_wait_info() to always copy the dup and dtor function pointers:

void * (*dup)(void *);

static inline void dup_wait_info(wait_info_t *s, wait_info_t *d)
{
	close_wait_info(d);
	*d = *s;
	if (s->dup)
		d->data = s->dup(s->data);
}

I prefer the style where assignment functions, such as dup_wait_info(), 
place the destination argument to the left of the source, to mimic the 
assignment operator and functions such as strcpy().

remove_wait_queue_info() could be optimized slightly by transferring 
ownership of the wait queue info data instead of duping it.


