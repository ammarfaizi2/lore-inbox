Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTAUXZe>; Tue, 21 Jan 2003 18:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbTAUXZe>; Tue, 21 Jan 2003 18:25:34 -0500
Received: from host194.steeleye.com ([66.206.164.34]:23306 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267337AbTAUXZa>; Tue, 21 Jan 2003 18:25:30 -0500
Message-Id: <200301212334.h0LNYPF03207@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andries.Brouwer@cwi.nl
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: 3c509.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Jan 2003 18:34:25 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please Don't do this:

 #include <linux/ethtool.h>
 #include <linux/device.h>
 #include <linux/eisa.h>
+#include <linux/mca-legacy.h>
 
 #include <asm/uaccess.h>

If you're getting MCA_NOTFOUND undefined, it's because CONFIG_MCA_LEGACY isn't 
set when mca.h is included (either because it's not in your kernel config, or 
possibly because config.h isn't included into the right place in the 
driver---the latter doesn't look to be the problem for 3c509.c).

James


