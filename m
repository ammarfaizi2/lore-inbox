Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284866AbRLMTIU>; Thu, 13 Dec 2001 14:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284887AbRLMTIK>; Thu, 13 Dec 2001 14:08:10 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:10993 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S284866AbRLMTIC>; Thu, 13 Dec 2001 14:08:02 -0500
Date: Thu, 13 Dec 2001 19:07:50 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Joy Almacen <joy@empexis.com>
Cc: wa@almesberger.net, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: pivot_root and initrd kernel panic woes
Message-ID: <20011213190750.A4460@redhat.com>
In-Reply-To: <3C165586.457A26F0@empexis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C165586.457A26F0@empexis.com>; from joy@empexis.com on Tue, Dec 11, 2001 at 01:50:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 11, 2001 at 01:50:46PM -0500, Joy Almacen wrote:

> After which I added this line  my  /etc/lilo.conf file:
> 
> image=/boot/vmlinuz-2.4.9-12smp
>         label=2.4.9smp
>         append="initrd=/boot/initrd-2.4.9-12smp.img root=/dev/ram0
> init=/linuxrc rw"

That's your problem.  You need to specify your real root device in the
"root=" section; for example, mine looks like

image=/boot/vmlinuz-2.4.9-13
	label=linux
	initrd=/boot/initrd-2.4.9-13.img
	read-only
	root=/dev/md1

The initrd magic happens before the real root gets loaded: you don't
need to point root to /dev/ram0 to get a ramdisk.

Cheers, 
 Stephen
