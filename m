Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVACEnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVACEnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 23:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVACEnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 23:43:47 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:64478 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261290AbVACEnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 23:43:45 -0500
Message-ID: <41D8CD93.8000200@verizon.net>
Date: Sun, 02 Jan 2005 23:44:03 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Keith Owens <kaos@ocs.com.au>, Jim Nelson <james4765@cwazy.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Coywolf Qi Hunt <coywolf@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk loglevel policy?
References: <28707.1104722227@ocs3.ocs.com.au> <41D8C161.5000102@osdl.org>
In-Reply-To: <41D8C161.5000102@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [209.158.220.243] at Sun, 2 Jan 2005 22:43:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Keith Owens wrote:
> 
>> On Sun, 02 Jan 2005 13:41:34 -0800, "Randy.Dunlap" <rddunlap@osdl.org> 
>> wrote:
>>
>>> Jim Nelson wrote:
>>>
>>>> Or does printk() do some tracking that I didn't see as to where in 
>>>> the kernel the strings are coming from?
>>>
>>>
>>> That kind of garbled output has been known to happen, but
>>> the <console_sem> is supposed to prevent that (along with
>>> zap_locks() in kernel/printk.c).
>>
>>
>>
>> Using multiple calls to printk to print a single line has always been
>> subject to the possibility of interleaving on SMP.  We just live with
>> the risk.  Printing a complete line in a single call to printk is
>> protected by various locks.  Print a line in multiple calls is not
>> protected.  If it bothers you that much, build up the line in a local
>> buffer then call printk once.
> 
> 
> True, I was thinking about the single line case, which I
> have seen garbled/mixed in the past (on SMP).  Hopefully
> that one is fixed.
> 

Okay, that answered my question.  Is is frowned upon to use strncat/strcat in the 
kernel?  I have yet to see any use of them outside of the definition in 
lib/string.c.  It would seem to be faster (less potential contention for the 
printk locks).
