Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWBCUI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWBCUI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWBCUI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:08:26 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:38079 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932143AbWBCUI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:08:26 -0500
Date: Fri, 3 Feb 2006 21:08:23 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: small etherdevice.h fix
Message-ID: <Pine.LNX.4.62.0602032105180.31368@artax.karlin.mff.cuni.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This fixes a small bug in is_valid_ether_addr --- for address in the form 
FF:xx:xx:xx:xx:xx it returns true. The comment is about FF:FF:FF:FF:FF:FF 
is not true, is_multicast_ether_addr doesn't accept FF:FF:FF:FF:FF:FF as 
multicast (as you can see few lines above).

Mikulas

--- include/linux/etherdevice.h_	2006-02-03 21:05:23.000000000 +0100
+++ include/linux/etherdevice.h	2006-02-03 21:05:59.000000000 +0100
@@ -91,9 +91,7 @@
   */
  static inline int is_valid_ether_addr(const u8 *addr)
  {
-	/* FF:FF:FF:FF:FF:FF is a multicast address so we don't need to
-	 * explicitly check for it here. */
-	return !is_multicast_ether_addr(addr) && !is_zero_ether_addr(addr);
+	return !(addr[0] & 1) && !is_zero_ether_addr(addr);
  }

  /**
