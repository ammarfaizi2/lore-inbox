Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289172AbSBDVJx>; Mon, 4 Feb 2002 16:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289228AbSBDVJp>; Mon, 4 Feb 2002 16:09:45 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:52998 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289172AbSBDVJ3>;
	Mon, 4 Feb 2002 16:09:29 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Relson <relson@osagesoftware.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: Your message of "Mon, 04 Feb 2002 13:34:40 CDT."
             <4.3.2.7.2.20020204133252.00c50f00@mail.osagesoftware.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Feb 2002 08:09:16 +1100
Message-ID: <23219.1012856956@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Feb 2002 13:34:40 -0500, 
David Relson <relson@osagesoftware.com> wrote:
>At 01:22 PM 2/4/02, you wrote:
>>I have had in my /sbin/installkernel a clause to save .config as
>>config-<foo> when I install vmlinuz-<foo>; I believe anyone not doing
>>that[1] is, quite frankly, a moron.
>
>Why not a simple patch for "make install" to do this?

Simple?  From kbuild 2.5 which does exactly this ...

mainmenu_name "ix86 Installation"

choice 'Format to compile kernel in' \
	"vmlinux	CONFIG_VMLINUX \
	 vmlinuz	CONFIG_VMLINUZ \
	 bzImage	CONFIG_BZIMAGE \
	 zImage		CONFIG_ZIMAGE" bzImage

bool 'Use a prefix on install paths' CONFIG_INSTALL_PREFIX
if [ "$CONFIG_INSTALL_PREFIX" = "y" ]; then
  string '  Prefix for install paths' CONFIG_INSTALL_PREFIX_NAME ""
fi
string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/lib/modules/KERNELRELEASE/KERNELBASENAME"
bool 'Install System.map' CONFIG_INSTALL_SYSTEM_MAP
if [ "$CONFIG_INSTALL_SYSTEM_MAP" = "y" ]; then
  string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME "/lib/modules/KERNELRELEASE/System.map"
fi
bool 'Install .config' CONFIG_INSTALL_CONFIG
if [ "$CONFIG_INSTALL_CONFIG" = "y" ]; then
  string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME "/lib/modules/KERNELRELEASE/.config"
fi
if [ "$CONFIG_VMLINUX" != "y" ]; then
  bool '  Install vmlinux for debugging' CONFIG_INSTALL_VMLINUX
  if [ "$CONFIG_INSTALL_VMLINUX" = "y" ]; then
    string '    Where to install vmlinux' CONFIG_INSTALL_VMLINUX_NAME "/lib/modules/KERNELRELEASE/vmlinux"
  fi
fi
bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
if [ "$CONFIG_INSTALL_SCRIPT" = "y" ]; then
  string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAME ""
fi

