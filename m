Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWGaIJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWGaIJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWGaIJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:09:57 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:31404 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964832AbWGaIJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:09:56 -0400
Message-ID: <44CDBAF6.8050506@free.fr>
Date: Mon, 31 Jul 2006 10:10:30 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Andrew Morton <akpm@osdl.org>, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
References: <20060727015639.9c89db57.akpm@osdl.org> <44CCBBC7.3070801@free.fr> <20060731000359.GB23220@kroah.com> <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060731033757.GA13737@kroah.com>
In-Reply-To: <20060731033757.GA13737@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 31.07.2006 05:37, Greg KH a écrit :
> On Sun, Jul 30, 2006 at 10:27:06PM -0400, Andrew James Wade wrote:
>> On Sunday 30 July 2006 20:03, Greg KH wrote:
>>> Something's really broken with that version of udev then, because the
>>> 094 version I have running here works just fine with these symlinks.
>> Maybe, but some really odd things were happening in /sys with the
>> patch. I could still follow the bogus symlinks. More than that
>>
>> /sys/class/mem/mem$ cd ../../class
>> and
>> /sys/class/mem/mem$ cd ../..
>>
>> _both_ ended up with a $PWD of /sys/class.
> 
> Ick, ok, the problem is that my "virtual device" patch isn't in my
> "public" patch set that Andrew pulls from.  It will fix this issue up.
> I'll work on cleaning it up to be used by everyone tomorrow and move it
> to the tree that Andrew pulls from.  Then the next -mm release should
> have this issue fixed.
> 
> If you want to verify this, please apply the patch at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/device-virtual.patch
> and let me know if it solves your issue (note that the reference
> counting is not completly correct in that patch, that's why I haven't
> unleashed it on -mm yet.)

device-virtual.patch won't apply on top of 2.6.18-rc2-mm1:

linux-2.6-mm$ head -4 Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 18
EXTRAVERSION = -rc2-mm1

linux-2.6-mm$ quilt pop -a
Aucun patch retiré

linux-2.6-mm$ quilt push
Application de patches/device-virtual.patch
patching file drivers/base/Makefile
patching file drivers/base/base.h
Hunk #1 succeeded at 44 (offset 1 line).
patching file drivers/base/core.c
Hunk #1 succeeded at 434 (offset 60 lines).
Hunk #2 FAILED at 486.
Hunk #3 succeeded at 615 (offset 61 lines).
1 out of 3 hunks FAILED -- rejects in file drivers/base/core.c
patching file drivers/base/virtual.c
patching file include/linux/device.h
Hunk #1 succeeded at 356 (offset 5 lines).
Le patch patches/device-virtual.patch ne s'applique pas proprement
(forcez l'application avec -f)

-- 
laurent
