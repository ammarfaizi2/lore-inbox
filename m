Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270234AbTHHKIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHHKIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:08:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:61712 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270234AbTHHKIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:08:49 -0400
Date: Fri, 8 Aug 2003 12:03:45 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: Problem multiple bool/tristate prompts
In-Reply-To: <20030807235905.GO16091@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0308081135520.714-100000@serv>
References: <20030807235905.GO16091@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Aug 2003, Adrian Bunk wrote:

> config BLK_DEV_PS2
>         tristate "PS/2 ESDI hard disk support" if BROKEN_MODULAR
>         bool "PS/2 ESDI hard disk support" if !BROKEN_MODULAR
> 
> 
> Every "make *config" gives the warning
> 
>   drivers/block/Kconfig:45: prompt redefined
>   drivers/block/Kconfig:45:warning: type of 'BLK_DEV_PS2' redefined from 
>   'tristate' to 'boolean'
> 
> and the symbol is handled as tristate although BROKEN_MODULAR isn't
> defined.

A symbol can have only a single type and the warning is a bit misleading, 
the new type definition is simply ignored.
I'm not sure what you're trying makes really sense, but you have to use a 
separate symbol:

config BLK_DEV_PS2_B
	bool "PS/2 ESDI hard disk support" if !BROKEN_MODULAR

config BLK_DEV_PS2
	tristate "PS/2 ESDI hard disk support" if BROKEN_MODULAR
	default BLK_DEV_PS2_B

bye, Roman

