Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbQKJRYE>; Fri, 10 Nov 2000 12:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131034AbQKJRXz>; Fri, 10 Nov 2000 12:23:55 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:31251 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130892AbQKJRXn>;
	Fri, 10 Nov 2000 12:23:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: georgn@somanetworks.com
cc: "Corisen" <csyap@starnet.gov.sg>, linux-kernel@vger.kernel.org,
        "Richard E. Gooch" <rgooch@atnf.csiro.au>
Subject: Re: compiling 2.4.0-test10 kernel 
In-Reply-To: Your message of "Fri, 10 Nov 2000 11:23:29 CDT."
             <14860.8449.485106.841805@somanetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Nov 2000 04:23:35 +1100
Message-ID: <7531.973877015@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000 11:23:29 -0500 (EST), 
"Georg Nikodym" <georgn@somanetworks.com> wrote:
> C> i've manged to successfully compile 2.4.0-test10 kernel. however,
> C> upon startup there are some failed/error messages:
> C> 1. finding module dependencies: depmod *** Unresolved symbols in
> C> /lib/modules/2.4.0-test10/kernel/arch/i386/kernel/apm.o
>
>There are two things you can do about this:
>
> 1. Disable module versioning.
> 2. Copy the System.map file that's made during the kernel build to
>    /boot/System.map-2.4.0-test10.

System.map has nothing, repeat nothing to do with depmod at startup.
Yes, you can run depmod reading from a System.map but that only makes
sense before you boot the new kernel.  Once you have booted your
new kernel, depmod -a reads from kernel memory, not System.map.

>those that know more is what is the correct way to build a module such
>that it'll insmod in the face of module versioning.  Is this something
>for the FAQ?

Current Makefiles sometimes break with module versioning, the design is
inherently wrong but rewriting the entire Makefile system just before
the release of Linux 2.4 is not an option.  This should be in the FAQ,
Richard, please add.

Q.  Why do I get unresolved symbols like foo__ver_foo in modules?

A.  If /proc/ksyms or the output from depmod -ae contains symbols like
    "foo__ver_foo" then you have been bitten by the broken Makefile
    code for symbol versioning.  The only safe way to recover is save
    your config, delete everything, restore the config and recompile.

     mv .config ..
     make mrproper
     mv ../.config .
     make oldconfig
     make dep clean bzImage modules
     install, boot

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
