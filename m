Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUCaWp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCaWp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:45:27 -0500
Received: from 65-248-111-151.cn.tx.cebridge.net ([65.248.111.151]:1680 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S262547AbUCaWpT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:45:19 -0500
From: Brian Jackson <iggy@gentoo.org>
Organization: Gentoo Linux
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Makefile patch to create KBUILD_OUPUT if it doesn't exist
Date: Wed, 31 Mar 2004 16:47:35 -0600
User-Agent: KMail/1.6.51
Cc: kai@germaschewski.name, sam@ravnborg.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403311647.37184.iggy@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It was probably intentional to not have the Makefile automagically create 
KBUILD_OUPUT if it doesn't exist, but just in case, here's a patch which 
makes it do just that. I'd appreciate feedback either way just so I know if 
it's actually getting looked at or if it got lost somewhere along the way.

- --Brian Jackson

- --- Makefile.orig	2004-03-31 16:21:48.254691909 -0600
+++ Makefile	2004-03-31 16:34:27.507098249 -0600
@@ -88,10 +88,10 @@
 ifneq ($(KBUILD_OUTPUT),)
 # Invoke a second make in the output directory, passing relevant variables
 # check that the output directory actually exists
+$(if $(wildcard $(KBUILD_OUTPUT)),, \
+     $(shell mkdir -p ${KBUILD_OUTPUT}))
 saved-output := $(KBUILD_OUTPUT)
 KBUILD_OUTPUT := $(shell cd $(KBUILD_OUTPUT) && /bin/pwd)
- -$(if $(wildcard $(KBUILD_OUTPUT)),, \
- -     $(error output directory "$(saved-output)" does not exist))
 
 .PHONY: $(MAKECMDGOALS)
 

- -- 
http://www.brianandsara.net
For Sale : http://www.brianandsara.net/temp/forsale.php
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAa0qH+cPN+Z7qK9cRAiB9AJ0dtkq92cgYTailSvEPBS2Z/iez9wCg0CA2
GBdCdX7RPUhe9EXdXn7Y6Yg=
=+vf2
-----END PGP SIGNATURE-----
