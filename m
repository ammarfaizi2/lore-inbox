Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVEKDCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVEKDCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 23:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVEKDCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 23:02:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:15841 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261888AbVEKDCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 23:02:08 -0400
Date: Wed, 11 May 2005 08:32:01 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: coywolf@gmail.com
Cc: fastboot@lists.osdl.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>, petkov@uni-muenster.de,
       rddunlap@osdl.org, Ralf.Hildebrandt@charite.de
Subject: Re: [Fastboot] Fw: Re: kexec?
Message-ID: <20050511030201.GA3799@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050510193225.53192aad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510193225.53192aad.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 07:32:25PM -0700, Andrew Morton wrote:
> 
> We have some kexec/kdump testers over on
> linux-kernel.  Results: not good.
> 
> 
> 
> Begin forwarded message:
> 
> Date: Tue, 10 May 2005 21:11:31 +0800
> From: Coywolf Qi Hunt <coywolf@gmail.com>
> To: Borislav Petkov <petkov@uni-muenster.de>
> Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>, linux-kernel@vger.kernel.org
> Subject: Re: kexec?
> 
> 
> On 5/10/05, Borislav Petkov <petkov@uni-muenster.de> wrote:
> > I've been doing some kexec tests (as described in Documentation/kdump.txt) too
> > but can't get to load the image and get similar error messages. Let me know
> > if you need more info about the hardware. The first_kernel was booted with
> > "crashkernel=64M@16M" and the 16M value was configured into the second during
> > kconfig in "Physical address where the kernel is loaded" as 0x1000000.
> > 
> > [root@zmei]: kexec -p vmlinux --args-linux --append="root=/dev/hda1 maxcpus=1
> > init 1"
> 
>  kexec-tools-1.101 loads for me, but if cmdline is used, it hangs up
> after "Starting new kernel"

maxcpus=1 is the culprit. Even through bios/grub kernel does not boot with 
option maxcpus=1. It is a known issue with got notieced 2.6.12-rc2-mm1 onwards. 
So build second kernel as uniprocessor kernel and don't specify maxcpus=1 and 
test it out. It should work.

Thanks
Vivek
