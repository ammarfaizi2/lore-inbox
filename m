Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSFVRMQ>; Sat, 22 Jun 2002 13:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSFVRMP>; Sat, 22 Jun 2002 13:12:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:24252 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316106AbSFVRMP>;
	Sat, 22 Jun 2002 13:12:15 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 22 Jun 2002 19:12:16 +0200 (MEST)
Message-Id: <UTC200206221712.g5MHCGU08868.aeb@smtp.cwi.nl>
To: jgarzik@mandrakesoft.com
Subject: ethernet name clash at boot
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with a handful of ethernet cards things go wrong
when booting 2.5.24. Backing out the change that makes
net_dev_init() into an initcall in net/core/dev.c solves
the problem (no doubt accidentally).

More precisely, what happens is that two cards both get assigned
eth0, and then when the second one wants to register the error
-EEXIST is returned.

Thus, some more locking is required, or names must only be given
to things in the dev_base chain, or ...

Andries
