Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290175AbSAQTYY>; Thu, 17 Jan 2002 14:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSAQTYN>; Thu, 17 Jan 2002 14:24:13 -0500
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:45903
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S290175AbSAQTX6>; Thu, 17 Jan 2002 14:23:58 -0500
Message-Id: <200201171923.g0HJNm303327@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: Rik van Riel <riel@conectiva.com.br>, torvalds@transmeta.com,
        Dave Jones <davej@suse.de>
Subject: [PATCH: NEW ARCHITECTURE FOR 2.5.2] support for NCR voyager
 343x/345x/4100/51xx architecture
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Jan 2002 14:23:47 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically a layout change from the previous plus fixes for the new 
scheduler.  It's at

http://www.hansenpartnership.com/voyager/files/voyager-2.5.2.diff (150k)

I've tried to remove some of the voyager specific pieces from the i386 files 
by re-arranging the code.  The most significant change is to create a 
smp_intr_init() function and move it out of i8259.c

I've also altered process.c to allow overrides of the code for performing 
machine power off and restart and removed the actual code into voyager.c.

I've also addressed Dave Jones issues with the nesting in setup.c by creating 
a new machine_specific_memory_stup() function.  However, I can't move the 
voyager memory setup routines out of here unless I export some of the 
currently static interfaces which I'm loth to do.

I haven't included the patch to make the new scheduler work with an 
architecture that uses physical cpu id in p->cpu but I have sent that off 
separately to Ingo.

James Bottomley


