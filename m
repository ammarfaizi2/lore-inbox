Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRKXX6f>; Sat, 24 Nov 2001 18:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280531AbRKXX6Z>; Sat, 24 Nov 2001 18:58:25 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:24593 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280537AbRKXX6M>;
	Sat, 24 Nov 2001 18:58:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org, kaih@khms.westfalen.de
Subject: Re: is 2.4.15 really available at www.kernel.org? 
In-Reply-To: Your message of "Sat, 24 Nov 2001 14:56:18 BST."
             <200111241356.fAODuIb30257@ns.caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Nov 2001 10:57:59 +1100
Message-ID: <9705.1006646279@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2001 14:56:18 +0100, 
Christoph Hellwig <hch@ns.caldera.de> wrote:
>In article <2450.1006608941@ocs3.intra.ocs.com.au> you wrote:
>> kbuild 2.5 has standard support for running user specific install
>> scripts after installing the bootable kernel and modules.  That is, the
>> "update my bootloader" phase can be automated and will propagate from
>> one .config to the next when you make oldconfig.
>
>Never 2.4 kernels already try to excecute ~/bin/installkernel in the
>'make install' pass on i386.

I know.  kbuild 2.5 goes further and gives the user a choice about
(a) whether to run a script on install and (b) what the script name is,
instead of hard coding it.

>Together with the above "~/bin/installkernel" option I put my kernels always
>into /lib/modules/<version>/vmlinux so I can find them easily (IMHO this
>should be default in 2.5)

Architecture dependent.  In kbuild 2.5 for most architectures the
default location for the kernel, System.map and .config is in
/lib/modules.

string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/lib/modules/KERNELRELEASE/vmlinuz"
bool 'Install System.map' CONFIG_INSTALL_SYSTEM_MAP
if [ "$CONFIG_INSTALL_SYSTEM_MAP" = "y" ]; then
  string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME "/lib/modules/KERNELRELEASE/System.map"
fi
bool 'Install .config' CONFIG_INSTALL_CONFIG
if [ "$CONFIG_INSTALL_CONFIG" = "y" ]; then
  string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME "/lib/modules/KERNELRELEASE/.config"
fi

Users with special requirements (old BIOS, small /lib etc.) can
configure their install to put the kernel where they like.  At least
one architecture (ia64) mandates that bootable images live in a
separate partition, the firmware on ia64 requires this, so the default
for vmlinuz is different.

string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/boot/efi/vmlinuz-KERNELRELEASE"

>so even lilo-using people could write simple
>scripts to add all kernels present in /lib/modules/ to their config.
>This does of course make the path '/lib/modules/' grossly misnamed, maybe
>we could change it into /kernel in 2.5 :)

I was tempted, but the number of things that would break ... shudder.

