Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266799AbUF3SnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266799AbUF3SnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266804AbUF3SnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:43:13 -0400
Received: from unknown-raq-customer.dca1.superb.net ([207.228.240.52]:5897
	"EHLO allied.allied-universal.com") by vger.kernel.org with ESMTP
	id S266799AbUF3SnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:43:09 -0400
To: linux-kernel@vger.kernel.org
From: Paul King <paul@allied-universal.com>
Subject: Telephony Driver ISAPNP fix kernel 2.6.7
Reply-To: paul@allied-universal.com
CC: alan@redhat.com
Date: Wed, 30 Jun 2004 19:39:47 +0100
X-Originating-Host: cache5-lutn.server.ntli.net [62.252.64.16]; Wed, 30 Jun 2004 18:12:32 GMT
X-Mailer: Mailreader.com v2.3.29 (2001-07-20)
X-Browser: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.1.4322), JavaScript: On
Message-ID: <jUsT.aNoTheR.mEsSaGe.iD.108861915230674@mail.allied-universal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got an ISA Phonejack card and quickly found it wouldn't 
work with a stock 2.6.7 kernel. 

So found this bug in the ISAPNP part of the code, throughout the 
code it use it's own data structure to reference it's base IO address,
in the ISAPNP code this was not being populated with any value hence 
it can't talk to the card and so the driver fails.


--- ixj.c       2004-06-30 18:41:44.596776376 +0000
+++ /usr/src/linux/drivers/telephony/ixj.c      2004-06-30 18:42:
44.448677504 +0000
@@ -7741,6 +7741,7 @@
                        }

                        j = ixj_alloc();
+                       j->DSPbase = pnp_port_start(dev,0);
                        request_region(j->DSPbase, 16, "ixj DSP");

                        if (func != 0x110)







