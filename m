Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTCEQQy>; Wed, 5 Mar 2003 11:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTCEQQy>; Wed, 5 Mar 2003 11:16:54 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:43782 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267491AbTCEQQw>; Wed, 5 Mar 2003 11:16:52 -0500
Date: Wed, 5 Mar 2003 17:26:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: chas williams <chas@locutus.cmf.nrl.navy.mil>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-Reply-To: <Pine.LNX.4.44.0303050952010.31461-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0303051722060.32518-100000@serv>
References: <Pine.LNX.4.44.0303050952010.31461-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Mar 2003, Kai Germaschewski wrote:

> The preferred way would be:
> 
> obj-$(CONFIG_ATM) += atm.o
> 
> atm-y := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
> atm-$(subst m,y,$(CONFIG_ATM_CLIP))	+= ipcommon.o
> atm-$(subst m,y,$(CONFIG_NET_SCH_ATM))	+= ipcommon.o
> atm-$(CONFIG_PROC_FS)			+= proc.o

BTW some of this could also be done in the Kconfig:

config ATM_IPCOMMON
	bool
	default y if ATM_CLIP || NET_SCH_ATM

so you can change this into:

atm-$(CONFIG_ATM_IPCOMMON) += ipcommon.o

bye, Roman

