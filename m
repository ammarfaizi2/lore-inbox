Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWIABiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWIABiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWIABiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:38:13 -0400
Received: from gw.goop.org ([64.81.55.164]:16055 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932325AbWIABiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:38:12 -0400
Message-ID: <44F78EF6.1060701@goop.org>
Date: Thu, 31 Aug 2006 18:37:58 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Type checking for write_pda()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just added type checking for assignments the PDA in the i386 PDA code.
Here's the x86-64 equivalent.  (Obviously this doesn't contain the latest
x86-64 PDA change.)

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

diff -r 77945c3646ac include/asm-x86_64/pda.h
--- a/include/asm-x86_64/pda.h  Thu Aug 31 18:30:26 2006 -0700
+++ b/include/asm-x86_64/pda.h  Thu Aug 31 18:34:49 2006 -0700
@@ -47,6 +47,7 @@ extern void __bad_pda_field(void);
 
 #define pda_to_op(op,field,val) do { \
        typedef typeof_field(struct x8664_pda, field) T__; \
+       if (0) { T__ tmp__; tmp__ = (val); }                            \
        switch (sizeof_field(struct x8664_pda, field)) {                \
 case 2: \
 asm volatile(op "w %0,%%gs:%P1"::"ri" ((T__)val),"i"(pda_offset(field)):"memory"); break; \


