Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWHNTnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWHNTnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWHNTnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:43:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33474 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751331AbWHNTns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:43:48 -0400
Date: Mon, 14 Aug 2006 15:42:53 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060814194252.GC2519@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060809200642.GD7861@redhat.com> <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com> <20060810131323.GB9888@in.ibm.com> <m18xlw34j1.fsf@ebiederm.dsl.xmission.com> <20060810181825.GD14732@in.ibm.com> <m1irl01hex.fsf@ebiederm.dsl.xmission.com> <20060814165150.GA2519@in.ibm.com> <44E0AD1D.1040408@zytor.com> <20060814181118.GB2519@in.ibm.com> <44E0CFD0.3060506@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E0CFD0.3060506@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 12:32:32PM -0700, H. Peter Anvin wrote:
> Vivek Goyal wrote:
> >On Mon, Aug 14, 2006 at 10:04:29AM -0700, H. Peter Anvin wrote:
> >>Vivek Goyal wrote:
> >>>On Thu, Aug 10, 2006 at 02:09:58PM -0600, Eric W. Biederman wrote:
> >>>>>I just reserved memory at non 2MB aligned location 65MB@15MB so that
> >>>>>kernel is loaded at 16MB and other smaller segments below the 
> >>>>>compressed
> >>>>>image, then I can successfully booted into the kdump kernel.
> >>>>:)
> >>>>
> >>>>>So basically kexec on panic path seems to be clean except stomping 
> >>>>>issue.
> >>>>>May be bzImage program header should reflect right "MemSize" which
> >>>>>takes into account extra memory space calculations.
> >>>>Yes.  That sounds like the right thing to do.  
> >>>>
> >>>>I remember trying to compute a good memsize when I created the bzImage
> >>>>header but it is completely possible I missed some part of the
> >>>>calculation or assumed that the kernels .bss section would always be
> >>>>larger than what I needed for decompression.
> >>>>
> >>Could someone please describe the intended semantics of this MemSize 
> >>header, *and* its intended usage?
> >>
> >
> >Now and ELF header(attached to bzImage) is being used to describe
> >the kernel executable. One program header of PT_LOAD type is being
> >created. The "p_filesz" field of program header is basically 
> >describing the vmlinux file size and "p_memsz" is giving how
> >much memory will be consumed by kernel image at load time.
> >
> >Ideally "p_memsz" should be "p_memsz" summation of all the program
> >headers of vmlinux file but I guess in this case we are stretching the
> >ELF specification a little bit and also taking into the account the
> >additional memory which will be used by decompressor and decompression
> >logic by the time execution is transferred to the actual kernel.
> >
> 
> What about once the kernel is booted?
> 

Sorry did not understand the question. Few more lines will help.

Thanks
Vivek 
