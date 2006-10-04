Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWJDUXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWJDUXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWJDUXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:23:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:25793 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751052AbWJDUXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:23:23 -0400
Date: Wed, 4 Oct 2006 16:22:44 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061004202244.GA3629@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45233B58.1050208@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 09:40:56PM -0700, H. Peter Anvin wrote:
> Vivek Goyal wrote:
> >
> >Hi Andrew,
> >
> >Right now I don't have access to my test machine.  Tomorrow morning,
> >very first thing I am going to try it out with your config file.
> >
> >This patch just adds and ELF header to bzImage which is not even used
> >by grub.
> >
> 
> Oh yes, it will be.  See below.
> 
> >So without this patch you are able to boot the kernel on your laptop?
> 
> Danger, Will Robinson.  GRUB, Etherboot, and a whole bunch of other boot 
> loaders will recognize an ELF binary and load it as such.  They will 
> typically load it as an executable (not a relocatable object) -- I doubt 
> many of them check that appropriate part of the ELF header -- so unless 
> your kernel can be safely loaded *AND RUN* in that mode this is not 
> going to work.
> 
> The entrypoint is going to be a major headache, since the standard 
> kernel is entered in real mode, whereas an ELF file will typically be 
> entered in protected mode, quite possibly using the C calling convention 
> to pass the command line as (argc, argv).  God only knows how they're 
> going to deal with an initrd.
> 
> It may very well be that the ELF magic number has to be obfuscated.
>

Eric/Peter,

How about just extending bzImage format to include some info in real mode
kernel header. Say protocol version 2.05. I think if we just include two
more fields, is kernel relocatable and equivalent of ELF memsz, then probably
this information should be enough for kexec bzImage loader to load and run
a relocatable kernel from a different address.

Thanks
Vivek
