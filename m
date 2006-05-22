Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWEVTMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWEVTMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWEVTMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:12:15 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:23170 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751085AbWEVTMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:12:14 -0400
Date: Mon, 22 May 2006 12:14:35 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.16.18
Message-ID: <20060522191435.GS23243@moss.sous-sol.org>
References: <20060522191346.GR23243@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522191346.GR23243@moss.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index ce59d4b..2567664 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .17
+EXTRAVERSION = .18
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/net/ipv4/netfilter/ip_nat_snmp_basic.c b/net/ipv4/netfilter/ip_nat_snmp_basic.c
index 4f95d47..df57e7a 100644
--- a/net/ipv4/netfilter/ip_nat_snmp_basic.c
+++ b/net/ipv4/netfilter/ip_nat_snmp_basic.c
@@ -1000,12 +1000,12 @@ static unsigned char snmp_trap_decode(st
 		
 	return 1;
 
+err_addr_free:
+	kfree((unsigned long *)trap->ip_address);
+
 err_id_free:
 	kfree(trap->id);
 
-err_addr_free:
-	kfree((unsigned long *)trap->ip_address);
-	
 	return 0;
 }
 
@@ -1123,11 +1123,10 @@ static int snmp_parse_mangle(unsigned ch
 		struct snmp_v1_trap trap;
 		unsigned char ret = snmp_trap_decode(&ctx, &trap, map, check);
 		
-		/* Discard trap allocations regardless */
-		kfree(trap.id);
-		kfree((unsigned long *)trap.ip_address);
-		
-		if (!ret)
+		if (ret) {
+			kfree(trap.id);
+			kfree((unsigned long *)trap.ip_address);
+		} else 
 			return ret;
 		
 	} else {
