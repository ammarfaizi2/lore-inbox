Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVABVsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVABVsL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 16:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVABVsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 16:48:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:44439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261151AbVABVsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 16:48:06 -0500
Message-ID: <41D86A8E.9090400@osdl.org>
Date: Sun, 02 Jan 2005 13:41:34 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Nelson <james4765@cwazy.co.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Coywolf Qi Hunt <coywolf@gmail.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk loglevel policy?
References: <Pine.LNX.4.61.0412310259230.4725@dragon.hygekrogen.localhost>	 <2cd57c9004123018203b7e38ef@mail.gmail.com> <1104675855.15004.56.camel@localhost.localdomain> <41D84503.2040808@cwazy.co.uk>
In-Reply-To: <41D84503.2040808@cwazy.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Nelson wrote:
> Alan Cox wrote:
> 
>> On Gwe, 2004-12-31 at 02:20, Coywolf Qi Hunt wrote:
>>
>>> Hi all,
>>> Recently, I've seen a lot of add loglevel to printk patches. grep 
>>> 'printk("' -r | wc shows me 2433. There are probably 2433 printk
>>> need to patch, is it?  What's this printk loglevel policy, all these
>>
>>
>>
>> You would need to work out which were at the start of a newline - most
>> of them are probably just fine and valid
>>
> 
> That reminds me of a question I've had inthe back of my head.  When you 
> have a SMP system wouldn't it be possible to have:
> 
> CPU 1 (running func1)    CPU 2 (running func2)
>  |             |
>  printk ("foo...");     |
>  |            printk ("bleh\n");
>  printk ("finished\n);     |
>             printk ("readout from bleh\n";
> 
> Is that possible?  Especially if the process on CPU 1 slept on a 
> semaphore or something similar?
> 
> Or does printk() do some tracking that I didn't see as to where in the 
> kernel the strings are coming from?

That kind of garbled output has been known to happen, but
the <console_sem> is supposed to prevent that (along with
zap_locks() in kernel/printk.c).

If it still happens, it needs to be fixed.
David Howells (RH) has posted patches that fix it.

-- 
~Randy
