Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVBXCCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVBXCCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVBXCCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:02:03 -0500
Received: from web40908.mail.yahoo.com ([66.218.78.205]:36253 "HELO
	web40908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261739AbVBXCBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:01:54 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=tDVsMie8xdnsVNzwFFig+qFAVJImh62Fx79ii/8QMQ2Hl6k5cbWONqBm0w0BqYiwOgoOOY+GYT5ld5CcZ0UGlfFqCIiQnVQNi79HN2ifXy8Qt+Ond7Evn1TAfdlXzHvTtWajgpEJhj3c8KN2MD8zo1isSvJNR2w4ykwg7TRbgVg=  ;
Message-ID: <20050224020154.20822.qmail@web40908.mail.yahoo.com>
Date: Wed, 23 Feb 2005 18:01:53 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
To: Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org
Cc: =?ISO-8859-1?Q?=20=22Rog=E9rio=22?= Brito <rbrito@ime.usp.br>,
       jgarzik@pobox.com
In-Reply-To: <20050224015859.55191.qmail@web40910.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-330874952-1109210513=:19847"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-330874952-1109210513=:19847
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Retry... that patch got screwed up in the last
email...
-Brian



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
--0-330874952-1109210513=:19847
Content-Type: text/plain; name="patch1.txt"
Content-Description: patch1.txt
Content-Disposition: inline; filename="patch1.txt"

--- libata-core.c.orig	2005-02-23 17:41:03.831836464 -0800
+++ libata-core.c	2005-02-23 17:54:51.287044152 -0800
@@ -3158,6 +3158,11 @@
 			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 				handled |= ata_host_intr(ap, qc);
 			}
+			else {
+				/* bk - just ack spurious interrupt here - temp workaround */
+				ata_irq_ack(ap, 0); 		
+				printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
+			}
 		}
 	}
 

--0-330874952-1109210513=:19847--
