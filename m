Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbTHLLBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbTHLLBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:01:48 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:28362 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S270007AbTHLLBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:01:46 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3+sk98lin driver with hardware bug make eth unusable
Date: Tue, 12 Aug 2003 13:01:43 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121301.43873.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've already reported this problem to syskonnect few weeks ago (without 
success as I see). 

There is a ASIC bug in several popular motherboards (including ASUS ones) 
related to TX hardware checksum. 

For packets smaller that 56 bytes (payload), as UDP dns queries, the asic 
generates a bad checksum making the drivers unusable for "normal" Internet 
usage:

12:50:26.602458 192.168.0.10.33520 > 192.168.0.3.53: [bad udp cksum 617e!]  
55764+ [45727n] A? ponti.gallimedina.net. (39) (DF) (ttl 64, id 8705, len 67)
12:50:26.733664 192.168.0.10.33515 > 192.168.0.3.53: [bad udp cksum 5e7e!]... 
12:50:40.603124 192.168.0.10.33520 > 192.168.0.3.53: [bad udp cksum 617e!]... 
12:50:40.743436 192.168.0.10.33523 > 192.168.0.3.53: [bad udp cksum 607e!]... 
12:50:54.604568 192.168.0.10.33526 > 192.168.0.3.53: [bad udp cksum 717e!]... 
12:50:54.744493 192.168.0.10.33523 > 192.168.0.3.53: [bad udp cksum 607e!]...

The only solution is to comment out
 #define USE_SK_TX_CHECKSUM
in skge.c

Could be this an option in Kconfig?

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/
