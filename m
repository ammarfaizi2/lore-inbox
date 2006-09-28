Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751939AbWI1SWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWI1SWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWI1SWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:22:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:19381 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751938AbWI1SWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:22:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=N08QOfJqh86k79sVzk6ZlQd4JFyX8DDr9gmZvlgM64Gkn/oaPGxv06fSJNbXQVA5d1+E/YkH4M5R2TTyjOikE/hs030Ah0xUDIwOid3er663IEBwyFocLWc3ToQiZeKu3kIf/BV9rAY9HIU6IR7hXef1QTt3nJPzMxPx8BKyqEE=
Message-ID: <f46018bb0609281122l6998bed8raacd50a353c3c3fd@mail.gmail.com>
Date: Thu, 28 Sep 2006 14:22:30 -0400
From: "Holden Karau" <holden@pigscanfly.ca>
To: simon@thekelleys.org.uk
Subject: [PATCH] 2.6.18 atmel iwlist stats patch
Cc: netdev <netdev@vger.kernel.org>,
       atmelwlandriver-devel@lists.sourceforge.net, holdenk@xandros.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 177df622be17c929
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com

I have made a small patch for the atmel driver [included in the 2.6.18
kernel] to output signal strength information as part of iwlist scan
[before it did not output any signal strength related information].
Signed-off-by: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
--
The output of iwlist scan is frequently used by user space utilites to
chose which wireless network to connect to based on the reported
signal strength, so I think this could be useful [of course I could be
horribly wrong about that but *shrugs*]. Incase the patch gets mangled
I've also put it up on at
http://www.holdenkarau.com/~holden/projects/atmel/patches/001-iwlist-stats.patch
And now for the patch:
--- drivers/net/wireless/atmel.c.orig	2006-09-28 14:14:42.000000000 -0400
+++ drivers/net/wireless/atmel.c	2006-09-28 14:14:55.000000000 -0400
@@ -2345,6 +2345,14 @@ static int atmel_get_scan(struct net_dev
 		iwe.u.freq.e = 0;
 		current_ev = iwe_stream_add_event(current_ev, extra +
IW_SCAN_MAX_DATA, &iwe, IW_EV_FREQ_LEN);

+		/* Add quality statistics */
+		iwe.cmd = IWEVQUAL;
+		iwe.u.qual.level = (__u8) priv->BSSinfo[i].RSSI;
+		iwe.u.qual.qual  = iwe.u.qual.level;
+		/* iwe.u.qual.noise  = SOMETHING */
+		current_ev = iwe_stream_add_event(current_ev, extra +
IW_SCAN_MAX_DATA , &iwe, IW_EV_QUAL_LEN);
+
+
 		iwe.cmd = SIOCGIWENCODE;
 		if (priv->BSSinfo[i].UsingWEP)
 			iwe.u.data.flags = IW_ENCODE_ENABLED | IW_ENCODE_NOKEY;
