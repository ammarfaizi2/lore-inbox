Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTIPJs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTIPJs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:48:27 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:60434 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S261821AbTIPJsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:48:22 -0400
Date: Tue, 16 Sep 2003 02:48:16 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: How to know current Kernel Configuration?
Message-ID: <20030916094816.GE30333@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <0e851eca491344bebdb7b1a70a1bc608.jeremyjin@nucleus.com> <3F66B671.1020805@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F66B671.1020805@longlandclan.hopto.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message is may contain confidential information.  Unauthorised disclosure will be prosecuted to the fullest extent of the law.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 05:06:25PM +1000, Stuart Longland wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> jeremyjin@nucleus.com wrote:
> 
> | And I want to keep most configuration settings because I think these
> settings should be pretty good,
> | how can I know the current configuration of the current kernel? I know
> make has a option "make oldconfig",
> | but seems like it is the old configuration of the last times "make",
> not the one of current running kernel.
> 
> Ahh, it's using the default configuration from the linux source, I'm not
> sure where it's stored, somewhere in arch/i386... as far as I know.

The 2.4 default config is in arch/$ARCH/defconfig

> However, Red Hat stores their version of the .config file in /boot as
> config-`uname -r`.  So copy this to your kernel source directory as
> .config, then try make oldconfig, etc...
> 
> A quick way of doing this... (assuming you are in the kernel source
> directory)
> 
> # cp /boot/config-`uname -r` .config

That gets really messy or unreliable fast if you have more
than one kernel.  And if you build your own you better have
more than one.

> 
> Then run...
> 
> # make oldconfig
> # make xconfig, menuconfig or config	- optional
> # make dep bzImage modules modules_install - usual build procedure.
> 
> | Is there any command to list all current running linux kernel
> configuration which is used to compile that version?
> Not in 2.4.x as far as I know, but there is a virtual file in /proc
> (/proc/ikconfig or something like that I think) that does this.

it is CONFIG_PROC_CONFIG
menuconfig: filesystems->/proc/config.gz
right below /proc filesystem support.

Came in really handy for me when i recently applied SuSE's
kernel update rpm and it overwrote the kernel tree including
.config.  Fortunately i had turned it on in an earlier
build.  If it wasn't enabled it won't do you any good.
Although understating the size a bit (mine are 4K-6KB) the
help text is to the point:

	The cost is around 1K-4K of running memory. Only say
	no if you really can't spare this. You can sneeze
	and lose more on memory than this.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
