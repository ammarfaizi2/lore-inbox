Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274958AbTHPUls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 16:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274959AbTHPUls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 16:41:48 -0400
Received: from h-66-167-78-223.SNVACAID.covad.net ([66.167.78.223]:25243 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S274958AbTHPUlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 16:41:47 -0400
Date: Sat, 16 Aug 2003 13:40:56 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200308162040.h7GKeuf07629@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Cc: jmorris@inercode.com.au, mpm@selenic.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2003-08-16 15:51:10, Matt Mackall wrote:
>The
>current code uses the stack (though currently rather a lot of it),
>which lets it be fully re-entrant. Not an option with cryptoapi.

	I posted a patch a while ago on one of the linux crypto
mailing lists that defined these routines to support allocating
crypto_tfm's on the stack:

int crypto_tfm_alloc_size(struct crypto_alg *alg, u32 tfm_flags);
int crypto_tfm_init(struct crypto_tfm *tfm, struct crypto_alg *alg,
                    u32 tfm_flags);

	The patch also created crypto_alg_{get,put} routines so that
crypto_tfm's could be created quickly without having to look up and
release references to crypto_alg's.

	I have a version of cryptoloop.c that uses these changes so
write operations on device-backed loop devices will not corrupt data
(I beileve that in the stock 2.6.0-test3 this data corruption can
happen, although I've never observed it).  The changes should also
facilitate a future version of loop.c that may be able to have
encryptions or decryption for the same /dev/loop/ device running on
multiple CPU's simultaneously.

	If there is interest, I can assemble a new version of the
patch for 2.6.0-test3.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
