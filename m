Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317834AbSGWRd5>; Tue, 23 Jul 2002 13:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317879AbSGWRd5>; Tue, 23 Jul 2002 13:33:57 -0400
Received: from [205.205.44.10] ([205.205.44.10]:18957 "EHLO
	sembo111.teknor.com") by vger.kernel.org with ESMTP
	id <S317834AbSGWRd5>; Tue, 23 Jul 2002 13:33:57 -0400
Message-ID: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com>
From: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
To: "Linux-Ha (E-mail)" <linux-ha@muc.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Handling NMI in a kernel module
Date: Tue, 23 Jul 2002 13:37:01 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to request_nmi() the way you can request_irq() from a kernel
driver on the i386 arch?

Our hardware watchdog is dual stage and can generate NMI on first stage ,
our cPCI handle switch can also be used for Hot swap request via NMI.
I'ld like to make use of this, I noticed cpqhealth module already
implemented some nmi handling but this driver is close sourced.

Should we patch in i386/kernel/traps.c to add a callback to our stuff in
unkown_nmi_error().

I'ld like my driver to register a callback there, what about maintaining a
list of user callback functions which could be registered via:
 
request_nmi(int option, void (*hander)(void *dev_id, struct pt_regs *regs),
unsigned long flags, const char *dev_name, void *dev_id);

where option could take meaning such as
 - prepend   : place at start of nmi callback functions
 - append    : place at end of nmi callback functions 
 - truncate : replace callback chain

Is there any standard mecanism to implement such features( dual stage
watchdog ) ?

Comments are welcome.

Francois Isabelle
Francois.Isabelle@ca.kontron.com
Kontron Canada Inc

 
 


