Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVABTBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVABTBK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 14:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVABTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 14:01:10 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:8868 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261300AbVABTBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 14:01:06 -0500
Message-ID: <41D84503.2040808@cwazy.co.uk>
Date: Sun, 02 Jan 2005 14:01:23 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Coywolf Qi Hunt <coywolf@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk loglevel policy?
References: <Pine.LNX.4.61.0412310259230.4725@dragon.hygekrogen.localhost>	 <2cd57c9004123018203b7e38ef@mail.gmail.com> <1104675855.15004.56.camel@localhost.localdomain>
In-Reply-To: <1104675855.15004.56.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Sun, 2 Jan 2005 13:01:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-12-31 at 02:20, Coywolf Qi Hunt wrote:
> 
>>Hi all, 
>>
>>Recently, I've seen a lot of add loglevel to printk patches. 
>>grep 'printk("' -r | wc shows me 2433. There are probably 2433 printk
>>need to patch, is it?  What's this printk loglevel policy, all these
> 
> 
> You would need to work out which were at the start of a newline - most
> of them are probably just fine and valid
> 

That reminds me of a question I've had inthe back of my head.  When you have a SMP 
system wouldn't it be possible to have:

CPU 1 (running func1)	CPU 2 (running func2)
  |			 |
  printk ("foo...");	 |
  |			printk ("bleh\n");
  printk ("finished\n);	 |
			printk ("readout from bleh\n";

Is that possible?  Especially if the process on CPU 1 slept on a semaphore or 
something similar?

Or does printk() do some tracking that I didn't see as to where in the kernel the 
strings are coming from?
