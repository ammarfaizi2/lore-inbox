Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTIPLl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTIPLlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:41:55 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:6306 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261839AbTIPLlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:41:55 -0400
Date: Tue, 16 Sep 2003 13:41:52 +0200 (MEST)
Message-Id: <200309161141.h8GBfqZv012047@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: davej@codemonkey.org.uk
Subject: agpgart's MODULE_ALIAS is broken
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

With 2.6.0-test5, the generated alias for agpgart
in modules.alias looks wrong:

alias char-major-10-AGPGART_MINOR agpgart

Surely that should be char-major-10-175.

The problem is that AGP's MODULE_ALIAS_MISCDEV() is in
backend.c, but AGPGART_MINOR isn't #define:d there
because agpgart.h is only #include:d in frontend.c.
This causes MODULE_ALIAS_MISCDEV()'s __stringify()
to convert the token itself rather than its value.

Should be easy to fix (move the ALIAS or add #include).

/Mikael
