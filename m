Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTCEOel>; Wed, 5 Mar 2003 09:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTCEOel>; Wed, 5 Mar 2003 09:34:41 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:10389 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S263321AbTCEOek>; Wed, 5 Mar 2003 09:34:40 -0500
Message-Id: <200303051443.h25EhlGi006161@locutus.cmf.nrl.navy.mil>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Mon, 03 Mar 2003 18:28:20 CST."
             <Pine.LNX.4.44.0303031825240.16397-100000@chaos.physics.uiowa.edu> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 05 Mar 2003 09:43:47 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0303031825240.16397-100000@chaos.physics.uiowa.edu>,K
ai Germaschewski writes:
>Not terribly important, but you can write this as:
>obj-$(CONFIG_ATM)	+= atm.o
>atm-y			+= addr.o pvc.o signaling.o svc.o ...
>atm-$(CONFIG_PROC_FS)	+= proc.o

after looking at some other examples, i guess i like this even better:


ipcommon-obj-$(subst m,y,$(CONFIG_ATM_CLIP)) := ipcommon.o
ipcommon-obj-$(subst m,y,$(CONFIG_NET_SCH_ATM)) := ipcommon.o

atm-objs        := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o $(ipcommon-obj-y)

obj-$(CONFIG_ATM) += atm.o
atm-$(CONFIG_PROC_FS) += proc.o
