Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283387AbRLDXBG>; Tue, 4 Dec 2001 18:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283575AbRLDXA4>; Tue, 4 Dec 2001 18:00:56 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:36620 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283387AbRLDXAq>;
	Tue, 4 Dec 2001 18:00:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
In-Reply-To: Your message of "Tue, 04 Dec 2001 18:21:15 -0000."
             <E16BKBw-0002xO-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Dec 2001 10:00:32 +1100
Message-ID: <30228.1007506832@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001 18:21:15 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> make bzlilo modules modules_install: it would be a simble
>> make install: (and you configure with CML1/CML2 what install
>> means).
>
>How does it handle that when install means different things on each box of
>a set of them NFS sharing the kernel tree. This is a real world example

I made kbuild 2.5 install very flexible to cater for cases like this.
The answer depends on whether you want every compile to be the same
with different install steps on the target machines or each compile is
different.

In the different compile case you have a single source tree (mounted
read only if you like) and separate object trees for each compile run.
The .config lives in the object directory so is machine local.  The
object trees can be NFS mounted or can use local disk on each build
machine, as a bonus this avoids NFS writes and runs much faster.

If you want a common compile on one machine followed by different
installs on each machine then you have three choices.

(1) make install with an install prefix path (say /var/tmp) will
    install the kernel, modules, System.map and .config in a holding
    directory on the build machine, the other machines can then copy
    the install data to wherever they need it.  Whether the copy is
    done from the build machine to the target directories or on the
    target machine is an NFS implementation detail.

(2) make installable (the default target) on the build machine then run
    make install with overrides on the target machines.  All the
    install config variables are exposed for override on the install
    step.

(3) make installable on the build machine with .config specifying an
    install script name.  Then make install on each target system, the
    version of the install script is local to the target machine.

If none of those suit your environment, let me know what you are trying
to achieve and I will see about adding support to kbuild 2.5.

