Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbTCEQPn>; Wed, 5 Mar 2003 11:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbTCEQPn>; Wed, 5 Mar 2003 11:15:43 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:29589 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267385AbTCEQPn>; Wed, 5 Mar 2003 11:15:43 -0500
Message-Id: <200303051624.h25GOqGi006862@locutus.cmf.nrl.navy.mil>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Wed, 05 Mar 2003 10:11:49 CST."
             <Pine.LNX.4.44.0303051010200.31461-100000@chaos.physics.uiowa.edu> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 05 Mar 2003 11:24:52 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0303051010200.31461-100000@chaos.physics.uiowa.edu>,K
ai Germaschewski writes:
>...quite a bit of effort to remove those duplicate entries...

shocking!  so how about this then:

atm-y   := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
mpoa-y  := mpc.o mpoa_caches.o mpoa_proc.o

obj-$(CONFIG_ATM) += atm.o
atm-$(CONFIG_PROC_FS) += proc.o
atm-$(subst m,y,$(CONFIG_ATM_CLIP)) += ipcommon.o
atm-$(subst m,y,$(CONFIG_NET_SCH_ATM)) += ipcommon.o
obj-$(CONFIG_ATM_CLIP) += clip.o
obj-$(CONFIG_ATM_LANE) += lec.o
obj-$(CONFIG_ATM_MPOA) += mpoa.o
obj-$(CONFIG_PPPOATM) += pppoatm.o

