Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVE0XlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVE0XlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 19:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVE0XlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 19:41:15 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:54995 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262662AbVE0XlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 19:41:01 -0400
Message-ID: <4297AE6F.9040707@davyandbeth.com>
Date: Fri, 27 May 2005 18:34:07 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: disowning a process
References: <42975945.7040208@davyandbeth.com>	 <1117217088.4957.24.camel@localhost.localdomain>	 <42976D3A.5020200@davyandbeth.com> <1117227438.5730.235.camel@localhost.localdomain>
In-Reply-To: <1117227438.5730.235.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Gwe, 2005-05-27 at 19:55, Davy Durham wrote:
>  
>
>>Cool.. I looked at the daemon function and I might be able to use it..
>>    
>>
>
>Using daemon() is generally wise - it is basically a double fork and
>then one exits so that the orphan child becomes owned by init. However
>it also knows about platform specific considerations like setpgrp v
>setsid, whether an ioctl must be done to disown the controlling tty etc
>which can be fairly OS generation specific.
>  
>

Well, when I tried using it in a program with some sleeps to test.. I 
noticed that the intermediate process that daemon creates is not cleaned 
up with a wait() call (so I see a defunct process in the ps listing).

If I manually do the double fork() then I can call waitpid() myself for 
the pid that I know it spawned.   But if I just call wait() after 
calling daemon, then I don't know if I just cleaned up the pid it 
spawned (do I?), or some other previously spawned one (for perhaps 
totally different reasons)..

For my specifics it may not be a problem, but I guess I'm just whining 
about the fact that daemon() doesn't clean it up itself (or can it?)

Thanks much,
    Davy

