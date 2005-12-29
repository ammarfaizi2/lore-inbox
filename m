Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVL2MBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVL2MBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 07:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVL2MBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 07:01:53 -0500
Received: from smtp-4.smtp.ucla.edu ([169.232.46.138]:29829 "EHLO
	smtp-4.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1750743AbVL2MBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 07:01:52 -0500
Date: Thu, 29 Dec 2005 04:01:50 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Willy Tarreau <willy@w.ods.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <20051229100848.GA24309@alpha.home.local>
Message-ID: <Pine.LNX.4.64.0512290331330.13624@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <20051229051238.GU15993@alpha.home.local> <Pine.LNX.4.64.0512282322280.13624@potato.cts.ucla.edu>
 <20051229100848.GA24309@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Willy Tarreau wrote:
> On Thu, Dec 29, 2005 at 01:33:47AM -0800, Chris Stromsoe wrote:
>>
>> The machine is a dual P4 Xeon with hyperthreading on.  It can probably 
>> get by with only one cpu enabled.  If/when it goes down again, I'll 
>> boot with nosmp.  For what it's worth, I ran a Dell memory tester ("MP 
>> Memory") which claims to test all of the CPUs for a few hours and 
>> didn't come up with anything.  The machine feeds usenet and is seeing a 
>> lot more io than cpu.  (There are two Adaptec controllers, 4 channels, 
>> aic79xx, 5 drives on one channel, 3 unused, spool is on a 4 disk raid5, 
>> jfs formatted.)
>
> OK, I've found two old similar reports from people running news servers  :
>  http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/0807.html
>  http://seclists.org/lists/linux-kernel/2004/Jan/5699.html
>
> both were using an SMP server with an AIC7xxx adapter, and kernels 
> varying from 2.4.18 to 2.4.24. One of them used XFS and not JFS, so we 
> will exclude any potential JFS-related cause for now.

I am also building with highmem/4Gb support, which one of the reports 
mentioned.  I did not have any pmd messages while running 2.4.26 or 
2.4.27, built with the same set of options (make oldconfig dep clean 
bzimage .... )


> If you feel brave, you can try to switch the AIC7xxx driver to Justin 
> Gibbs' more recent version, but which has not evolved during last year, 
> but which I have running reliably on production servers :
>
>   http://people.freebsd.org/~gibbs/linux/
>
> I also have it rediffed for recent kernels if you prefer :
>
> http://w.ods.org/kernel/2.4-wt/2.4.32-wt2/patches-2.4.32-wt2/pool/aic79xx-20040522-linux-2.4.30-pre3.rediff

I've pulled the patch and saved it.  I don't want to change more than one 
thing at a time.  I'll try the alternate driver if booting with nosmp 
doesn't help.

> Out of curiosity, it would be interesting to disable swap if you have it 
> enabled.

I'm running with 4G of swap, but usually don't dip more than 30M or 40M 
into it.  I'll add disabling swap to the list of things to check.



-Chris
