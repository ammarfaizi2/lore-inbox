Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUIQFqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUIQFqP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUIQFqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:46:15 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:17792 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267651AbUIQFpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:45:53 -0400
Message-ID: <414A7A01.9080708@nortelnetworks.com>
Date: Thu, 16 Sep 2004 23:45:37 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
References: <16714.14118.212946.499226@wombat.chubb.wattle.id.au>
In-Reply-To: <16714.14118.212946.499226@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

> This depends on how expensive % is.  On IA64, something like this:
> 
>      add(char c) {
> 	     int i = p->head == p->len ? p->head++ : 0;
> 	     p->buf[i] = c;
>      }
> 
> is cheaper, as % generates a subroutine call to __modsi3.  It also is
> shorter =-- 12 bundles as opposed to 15.

I did a similar test once for ppc that found that an increment followed by a 
test (marked unlikely) was actually quicker in practice than modulo arithmetic. 
  The branch predictor got it right most of the time, so the test was almost free.

Chris
