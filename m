Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTHBQqr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 12:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbTHBQqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 12:46:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:53745 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262290AbTHBQqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 12:46:46 -0400
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: More fun with menuconfig...
References: <200308020605.58423.rob@landley.net>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 02 Aug 2003 18:46:28 +0200
In-Reply-To: <200308020605.58423.rob@landley.net> (Rob Landley's message of
 "Sat, 2 Aug 2003 06:05:58 -0400")
Message-ID: <87ispgknx7.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> So I have a .config with CONFIG_ADVANCED_PARTION not set, and 
> CONFIG_MSDOS_PARTITION=y.  (I.E. the default from arch/i386/defconfig.)
>
> I fire up make menuconfig and expand the advanced partition menu (setting 
> CONFIG_ADVANCED_PARTITION to y).  MSDOS partition support is NOT set in the 
> newly opened menu, I.E. opening the menu has the side effect of deselecting 
> CONFIG_MSDOS_PARTITION.
>
> If I do nothing else, and save with the menu open, it's off.  (Saved as "not 
> set".)  If I fire it up again and close the menu, CONFIG_MSDOS_PARTITION 
> becomes Y again.
>
> What magic am I failing to understand here?  (This sort of seems intentional, 
> but it would make more sense for MSDOS partition support to default to on 
> when you first open the menu...)

Maybe it's this default definition in fs/partitions/Kconfig(101):

config MSDOS_PARTITION
        bool "PC BIOS (MSDOS partition tables) support" if PARTITION_ADVANCED
        default y if !PARTITION_ADVANCED && !AMIGA && !ATARI && !MAC && !SGI_IP22 && !ARM && !SGI_IP27

Regards, Olaf.
