Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUBSWZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267579AbUBSWXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:23:04 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:41370 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S267583AbUBSWWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:22:34 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Thu, 19 Feb 2004 19:22:30 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <20040219191636.GC10527@kroah.com>
Message-ID: <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org>
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Greg KH wrote:

>  - modify the rc.sysinit script to call the start_udev script as one of
>    the first things that it does, but after /proc and /sys are mounted.
>    I did this with the latest Fedora startup scripts with the patch at
>    the end of this file.
>
>  - make sure the /etc/udev/udev.conf file lists the udev_root as /dev.
>    It should contain the following line in order to work properly.
> 	udev_root="/dev/"
>
>  - reboot into a 2.6 kernel and watch udev create all of the initial
>    device nodes in /dev
>
>
> If anyone has any problems with this, please let me, and the
> linux-hotplug-devel@lists.sourceforge.net mailing list know.

Unless I'm missing something, it doesn't seem to work if you
don't have /dev/null before it gets mounted.

I got

Creating initial udev device nodes:
/etc/rc.d/start_udev: line 90: cannot redirect standard input from /dev/null: No such file or directory.

and it didn't boot.

My first rc.S lines have:

mount -vn -t proc proc /proc # Needed for LABEL= in /etc/fstab

mount -vn -t sysfs sysfs /sys

/etc/rc.d/start_udev

-- 
http://www.pervalidus.net/contact.html
