Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131332AbQKJSZ5>; Fri, 10 Nov 2000 13:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131451AbQKJSZr>; Fri, 10 Nov 2000 13:25:47 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:55672 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S131450AbQKJSZg>; Fri, 10 Nov 2000 13:25:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14860.15798.651952.347977@somanetworks.com>
Date: Fri, 10 Nov 2000 13:25:58 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling 2.4.0-test10 kernel 
In-Reply-To: <7531.973877015@ocs3.ocs-net>
In-Reply-To: <14860.8449.485106.841805@somanetworks.com>
	<7531.973877015@ocs3.ocs-net>
X-Mailer: VM 6.75 under 21.2  (beta35) "Nike" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "KO" == Keith Owens <kaos@ocs.com.au> writes:

 KO> On Fri, 10 Nov 2000 11:23:29 -0500 (EST), "Georg Nikodym"
 KO> <georgn@somanetworks.com> wrote:
 C> i've manged to successfully compile 2.4.0-test10 kernel. however,
 C> upon startup there are some failed/error messages:
 C> 1. finding module dependencies: depmod *** Unresolved symbols in
 C> /lib/modules/2.4.0-test10/kernel/arch/i386/kernel/apm.o
 >>
 >> There are two things you can do about this:
 >>
 >> 1. Disable module versioning.
 >> 2. Copy the System.map file that's made during the kernel build to
 >> /boot/System.map-2.4.0-test10.

 KO> System.map has nothing, repeat nothing to do with depmod at
 KO> startup.  Yes, you can run depmod reading from a System.map but
 KO> that only makes sense before you boot the new kernel.  Once you
 KO> have booted your new kernel, depmod -a reads from kernel memory,
 KO> not System.map.

OK.  Makes sense.  My first kicks at building and running a kernel had
these problems (with module loading) until I added the copying of
System.map to my installation procedure.  I was led to this by
messages in /var/log/messages...  Thanks for the additional pointers.

 KO> Q.  Why do I get unresolved symbols like foo__ver_foo in modules?

 KO> A.  If /proc/ksyms or the output from depmod -ae contains symbols
 KO>     like
 KO> "foo__ver_foo" then you have been bitten by the broken Makefile
 KO> code for symbol versioning.  The only safe way to recover is save
 KO> your config, delete everything, restore the config and recompile.

 KO> mv .config ..  make mrproper mv ../.config .  make oldconfig make
 KO> dep clean bzImage modules install, boot

OK, but I guess my question wasn't very clear.  I have a kernel tree,
I add a printk to maestro.c and make modules.  I cannot load the
module until I rebuild and reinstall everything.  Is there a way to
avoid this headache, or, stated differently:  What's the prescribed
way to be able to load, unload, build, test modules?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
