Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWCPDYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWCPDYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWCPDYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:24:16 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:37356 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S932233AbWCPDYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:24:15 -0500
Date: Thu, 16 Mar 2006 11:23:18 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Fix sequencer missing negative bound check
In-reply-to: <200603160307.k2G37KLX007666@turing-police.cc.vt.edu>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Valdis.Kletnieks@vt.edu
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316032318.GA21534@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
References: <20060316011911.GA20384@eugeneteo.net>
 <200603160307.k2G37KLX007666@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Valdis.Kletnieks@vt.edu">
> On Thu, 16 Mar 2006 09:19:11 +0800, Eugene Teo said:
> > dev is missing a negative bound check.
> > 
> > Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
[snipped]
> static void seq_sysex_message(unsigned char *event_rec)
> {
>         int dev = event_rec[1];
>         int i, l = 0;
>         unsigned char  *buf = &event_rec[2];
> 
>         if ((int) dev > max_synthdev)
>                 return;
[snipped]
> that 'int dev' came out of an 'unsigned char *' - as such, I doubt you
> can get a negative value.  If anything, it should be 'unsigned int dev'.

Yes, thanks for pointing it out.

--
'int dev' came out of an 'unsigned char *' - as such, it will not get
a negative value. Thanks Valdis.

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/oss/sequencer.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/oss/sequencer.c	2006-03-16 11:15:31.000000000 +0800
@@ -709,7 +709,7 @@
 
 static void seq_sysex_message(unsigned char *event_rec)
 {
-	int dev = event_rec[1];
+	unsigned int dev = event_rec[1];
 	int i, l = 0;
 	unsigned char  *buf = &event_rec[2];
 
-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

