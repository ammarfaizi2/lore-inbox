Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbUKTBpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbUKTBpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUKTBnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:43:21 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:58504 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263077AbUKTBXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:23:04 -0500
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Akinobu Mita <amgta@yacht.ocn.ne.jp>, hari@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       varap@us.ibm.com
In-Reply-To: <20041119153052.21b387ca.akpm@osdl.org>
References: <419CACE2.7060408@in.ibm.com>
	 <200411200256.36218.amgta@yacht.ocn.ne.jp>
	 <20041119153052.21b387ca.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1100912759.4987.207.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Nov 2004 17:05:59 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well. I tried to use kdump.

I think documentation needs update. Documentation says

..

4) Load the second kernel to be booted using
                                                                                
   kexec -p <second-kernel> --args-linux --append="root=<root-dev> dump
   init 1 memmap=exactmap memmap=640k@0 memmap=32M@16M"

But kexec doesn't seem to like option "-p".
Even when I removed "-p", its complaining about "--args-linux"

# ./kexec  --args-linux --append="root=/dev/sda2 dump init 1
memmap=exactmap memmap=640k@0 memmap=32M@16M"  /boot/kexec2

./kexec: unrecognized option `--args-linux'
kexec 1.98 released 15 September 2004
Usage: kexec [OPTION]... [kernel]
Directly reboot into a new kernel
 
 -h, --help        Print this help.
 -v, --version     Print the version of kexec.
 -f, --force       Force an immediate kexec, don't call shutdown.
 -x, --no-ifdown   Don't bring down network interfaces.
                   (if used, must be last option specified)
 -l, --load        Load the new kernel into the current kernel.
 -u, --unload      Unload the current kexec target kernel.
 -e, --exec        Execute a currently loaded kernel.
 -t, --type=TYPE   Specify the new kernel is of this type.
 
Supported kernel file types and options:
elf32-x86
    --command-line=STRING Set the kernel command line to STRING
    --append=STRING       Set the kernel command line to STRING
    --initrd=FILE         Use FILE as the kernel's initial ramdisk.
    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.
    --args-linux          Pass linux kernel style options
    --args-elf            Pass elf boot notes
bzImage
-d, --debug               Enable debugging to help spot a failure.
    --real-mode           Use the kernels real mode entry point.
    --command-line=STRING Set the kernel command line to STRING.
    --append=STRING       Set the kernel command line to STRING.
    --initrd=FILE         Use FILE as the kernel's initial ramdisk.
    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.
 
Cannot load /boot/kexec2


Thanks,
Badari

On Fri, 2004-11-19 at 15:30, Andrew Morton wrote:
> Akinobu Mita <amgta@yacht.ocn.ne.jp> wrote:
> >
> > On Thursday 18 November 2004 23:08, Hariprasad Nellitheertha wrote:
> > 
> > > There was a buggy (and unnecessary) reserve_bootmem call in the kdump
> > > call which was causing hangs during early on some SMP machines. The
> > > attached patch removes that.
> > 
> > Thanks! I also had the same problem.
> 
> So..  How is the crashdump code working now?  I haven't heard from anyone
> who is using it and I haven't gotten onto testing it myself.
> 
> Do we have any feeling for its success rate on various machines, and on its
> ease of use?
> 
> 

