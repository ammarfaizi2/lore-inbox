Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271341AbTGWV65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271343AbTGWV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:58:57 -0400
Received: from corky.net ([212.150.53.130]:22737 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S271341AbTGWV64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:58:56 -0400
Date: Thu, 24 Jul 2003 01:14:00 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: linux-kernel@vger.kernel.org
Subject: KERN_ERR "ide: late registration of driver."
Message-ID: <Pine.LNX.4.44.0307240100390.17172-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently installed 2.4.22-pre7 on 2 boxes here.

During boot, I always get the message "ide: late registration of driver."
which comes from ide.c:2234:ide_register_driver().

Seems like drivers_run is already set by the time ide_register_driver get
called.  Following the logic of that driver, it makes sense.  ide_init()
gets called early and inits the ide.  (banner: "Uniform Multi-Platform
E-IDE driver...").  ide_register_driver() is never used inside the driver
but is exported and called after partition check, way down the line.

Therefore, I don't see why the late registration is an error.  Am I
missing something ?

And if its not an error, it shouldn't be printed as KERN_ERR.  When
booting the kernel with the 'quiet' option, thats the only message
printed.

	Yoav Weiss

