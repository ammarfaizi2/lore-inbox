Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270439AbUJUBFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270439AbUJUBFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270617AbUJUBFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:05:07 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:45309 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S270439AbUJUBDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:03:25 -0400
Message-ID: <41770AC6.7090604@nortelnetworks.com>
Date: Wed, 20 Oct 2004 19:03:02 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <MDEHLPKNGKAHNMBLJOLKOEIDPCAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOEIDPCAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

> 	Perhaps I missed the details, but under your proposal, how do you predict
> at 'select' time what mode the socket will be in at 'recvmsg' time?!

Well, if you've got a blocking socket, and do a nonblocking read with 
MSG_DONTWAIT, everything works fine.  You lose a bit of performance, but it works.

The problem case is if you create a socket, set O_NONBLOCK, do select, clear 
O_NONBLOCK, then do a recvmsg().

I suspect it's not a very common thing to do, so my proposal would still help 
the vast majority of existing apps.

Chris
