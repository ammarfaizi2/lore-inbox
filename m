Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVH3Qg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVH3Qg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVH3QgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:36:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:52910 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932207AbVH3QgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:36:25 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Greg Felix <greg.felix@gmail.com>,
       Oliver Tennert <O.Tennert@science-computing.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0508300916432fc003@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <58cb370e0508300916432fc003@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 18:05:18 +0100
Message-Id: <1125421518.8276.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-30 at 18:16 +0200, Bartlomiej Zolnierkiewicz wrote:
> HPA shouldn't be disabled by default and new kernel parameter ("hdx=hpa")
> should be added for disabling HPA (yep, people with buggy BIOS-es will
> have to add this parameter to their kernel command line, sorry).

Thats large numbers of systems. Large numbers of disks as strapped for
32GB and other clipping arrangements. With a vendor hat on thats
unworkable because

a) It will stop thousands of people installing their systems
b) Many users will get horrible corruption when they update the kernel
and their box explodes as the fs tries to write to areas of disk that
have vanished mysteriously.

(and we know all about this because ancient kernels had options for
doing this in the compile that burned people)

So its a very bad idea indeed. A boot option for not disabling the hpa
is possibly sensible for a few users who want that, or simply getting
them to fix their buggy user space app would be even simpler.

The only way I can see to truely automate it for most cases would be to
snoop the partition table if its MSDOS format and see if the table
matches the HPA clipped disk or the non-HPA clipped disk. If it matches
the HPA clipped disk then you know not to fiddle. Otherwise its either a
new disk, clipped by the 32GB jumper, non-x86 disk etc in which case you
might as well disable any HPA.

Alan

