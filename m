Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289629AbSBEQaw>; Tue, 5 Feb 2002 11:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289645AbSBEQam>; Tue, 5 Feb 2002 11:30:42 -0500
Received: from dns.logatique.fr ([213.41.101.1]:41981 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S289629AbSBEQaf>; Tue, 5 Feb 2002 11:30:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: Keith Owens <kaos@ocs.com.au>, David Relson <relson@osagesoftware.com>
Subject: Re: How to check the kernel compile options ?
Date: Tue, 5 Feb 2002 17:30:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <23219.1012856956@ocs3.intra.ocs.com.au>
In-Reply-To: <23219.1012856956@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020205162801.F16A523CBB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I like this. Which bring me to the latest FAQ : when will that be integrated? 

Has linus ever stated why kbuil/cml2 haven't been integrated yet ? They're 
almost orthogonal to the IO changes. And, anyway, the compilation of 2.5.x 
seems _already_ broken.

Thomas


On Monday 04 February 2002 22:09, Keith Owens wrote:
> On Mon, 04 Feb 2002 13:34:40 -0500,
>
> David Relson <relson@osagesoftware.com> wrote:
> >At 01:22 PM 2/4/02, you wrote:
> >>I have had in my /sbin/installkernel a clause to save .config as
> >>config-<foo> when I install vmlinuz-<foo>; I believe anyone not doing
> >>that[1] is, quite frankly, a moron.
> >
> >Why not a simple patch for "make install" to do this?
>
> Simple?  From kbuild 2.5 which does exactly this ...
>
> mainmenu_name "ix86 Installation"
>
> choice 'Format to compile kernel in' \
> 	"vmlinux	CONFIG_VMLINUX \
> 	 vmlinuz	CONFIG_VMLINUZ \
> 	 bzImage	CONFIG_BZIMAGE \
> 	 zImage		CONFIG_ZIMAGE" bzImage
>
> bool 'Use a prefix on install paths' CONFIG_INSTALL_PREFIX
> if [ "$CONFIG_INSTALL_PREFIX" = "y" ]; then
>   string '  Prefix for install paths' CONFIG_INSTALL_PREFIX_NAME ""
> fi
> string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME
> "/lib/modules/KERNELRELEASE/KERNELBASENAME" bool 'Install System.map'
> CONFIG_INSTALL_SYSTEM_MAP
> if [ "$CONFIG_INSTALL_SYSTEM_MAP" = "y" ]; then
>   string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME
> "/lib/modules/KERNELRELEASE/System.map" fi
> bool 'Install .config' CONFIG_INSTALL_CONFIG
> if [ "$CONFIG_INSTALL_CONFIG" = "y" ]; then
>   string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME
> "/lib/modules/KERNELRELEASE/.config" fi
> if [ "$CONFIG_VMLINUX" != "y" ]; then
>   bool '  Install vmlinux for debugging' CONFIG_INSTALL_VMLINUX
>   if [ "$CONFIG_INSTALL_VMLINUX" = "y" ]; then
>     string '    Where to install vmlinux' CONFIG_INSTALL_VMLINUX_NAME
> "/lib/modules/KERNELRELEASE/vmlinux" fi
> fi
> bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
> if [ "$CONFIG_INSTALL_SCRIPT" = "y" ]; then
>   string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAME
> "" fi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
