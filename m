Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbUCRWWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUCRWWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:22:23 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:5763 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S263200AbUCRWWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:22:12 -0500
Date: Thu, 18 Mar 2004 22:20:07 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Justin Piszcz <jpiszcz@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
In-Reply-To: <Law10-F95ihL5C2Skqk00028182@hotmail.com>
Message-ID: <Pine.LNX.4.44.0403182215360.3732-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

The answer to your question is that some Intel CPUs (just like any other
hardware or software) contain bugs and, fortunately, their architecture is
flexible enough to provide a way to fix those bugs by means of loading the
microcode update on the fly, i.e. while the OS is running with no need
to reboot (in fact, rebooting or otherwise resetting the CPU causes the
update to be lost and requires to run the update again).

This is the advantage. There are no disadvantages. After the microcode 
update has been loaded into the CPUs, the microcode driver can be removed 
to save a tiny amount of memory that it takes:

# rmmod microcode

Yes, it does matter which Intel CPUs you have. The driver selects the 
appropriate chunk of microcode for every CPU present on the system and 
loads it accordingly. You may even have mixed CPUs (i.e. of different 
kind) in an SMP system and this is handled automatically.

Kind regards
Tigran

On Thu, 18 Mar 2004, Justin Piszcz wrote:

> The URL: http://www.urbanmyth.org/microcode/
> 
> The microcode_ctl utility is a companion to the IA32 microcode driver 
> written by Tigran Aivazian <tigran@veritas.com>. The utility has two uses:
> 
>     * it decodes and sends new microcode to the kernel driver to be uploaded 
> to Intel IA32 processors. (Pentium Pro, PII, PIII, Pentium 4, Celeron, Xeon 
> etc - all P6 and above, which does NOT include pentium classics)
>     * it signals the kernel driver to release any buffers it may hold
> 
> The microcode update is volatile and needs to be uploaded on each system 
> boot i.e. it doesn't reflash your cpu permanently, reboot and it reverts 
> back to the old microcode.
> 
> My question is, what are the advantages vs disadvantages in updating your 
> CPU's microcode?
> 
> Is it worth it?
> 
> Does it matter what type of Intel CPU you have?
> 
> Do some CPU's benefit more than others for microcode updates?
> 
> I know RedHat distributions usually do this by default, but others do not.
> 
> Can anyone explain reasons to or not to update the CPU microcode?
> 
> _________________________________________________________________
> FREE pop-up blocking with the new MSN Toolbar – get it now! 
> http://clk.atdmt.com/AVE/go/onm00200415ave/direct/01/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

