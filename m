Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284472AbSABVnE>; Wed, 2 Jan 2002 16:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284545AbSABVmy>; Wed, 2 Jan 2002 16:42:54 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:37129 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284542AbSABVmh>;
	Wed, 2 Jan 2002 16:42:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system.map 
In-Reply-To: Your message of "Wed, 02 Jan 2002 16:14:58 CDT."
             <3C337852.1050109@nyc.rr.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 08:42:27 +1100
Message-ID: <10512.1010007747@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jan 2002 16:14:58 -0500, 
John Weber <weber@nyc.rr.com> wrote:
>I wrote a little script that does the whole thing for me;
>I can think of a bunch of improvements (like writing a new
>/etc/lilo.conf file) that can be added with minimal effort:
>
>I'm curious to know what the standard approach to this is.
>What other scripts are out there?

It is a lot easier in kbuild 2.5, I added clean support for install
scripts.  kbuild 2.5 does most of the work, the install script can
concentrate on its own work instead of deducing the install information
itself.

Post-install script or command name
CONFIG_INSTALL_SCRIPT_NAME
  If you perform some extra work after installing the kernel and
  modules, specify the name of your script or command here.  It will be
  invoked after copying the kernel and modules to the target locations.
  The CONFIG_INSTALL_* variables will be in the environment of your
  script, as well as all variables exported by the top level Makefile,
  including KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
  USERVERSION, KBUILD_OBJTREE, KBUILD_SRCTREE_nnn.

  If your boot loader needs to be run to pick up the new kernel
  location, you can insert the loader command in this field.  The
  command or script must be executable.  LILO users might find this to
  be useful,
    KBUILD_SRCTREE_000/scripts/lilo_new_kernel
  It adds CONFIG_INSTALL_PREFIX_NAME/CONFIG_INSTALL_KERNEL_NAME to
  /etc/lilo.conf with a label of KERNELRELEASE (truncated to 15
  characters) then runs lilo.

  Any words in the path that start with an upper case letter and
  consist only of upper case letters, '_' and digits are replaced by
  the value of the corresponding variable.  This includes
  KERNELRELEASE, VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION,
  USERVERSION, KBUILD_SRCTREE_nnn.


