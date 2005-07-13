Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVGMXPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVGMXPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVGMXNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:13:52 -0400
Received: from web25801.mail.ukl.yahoo.com ([217.12.10.186]:4769 "HELO
	web25801.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261934AbVGMXMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:12:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=B6fy3mJIjGsDC/w+liZr8R3SBIqpsUkOJm0Bnyz0TNnQzGbRQC1l6FOdDGGCO+TbT1Bjijb1iZ+Oh4kTE+8bYJlAujPEhGmaPpV0II3eGoOM0VMu4PZ/SVM7V4Jl15BfbRanQM2r0rK7Bn7c+IjXBVnAXRVeV8+Bvx/86x8Cw/Q=  ;
Message-ID: <20050713231200.24037.qmail@web25801.mail.ukl.yahoo.com>
Date: Thu, 14 Jul 2005 01:12:00 +0200 (CEST)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: console remains blanked
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like, since [1] was merged, a blanked console
(due to inactivity for example) doesn't get unblanked
anymore when new output is written to it.

This hunk of the already metioned patch, which
modifies vt_console_print() in drivers/char/vt.c, is
possibly the cause:

@@ -2220,9 +2220,6 @@
 	}
 	set_cursor(vc);
 
-	if (!oops_in_progress)
-		poke_blanked_console();
-
 quit:
 	clear_bit(0, &printing);
 }


Is that new behaviour intentional?
The old behaviour looks more interesting to me,
allowing one to see console messages immediately even
if the console was blanked after some idle time.

Cheers,
Albert

[1]
http://marc.theaimsgroup.com/?l=linux-kernel&m=111052009232499&w=2



		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
