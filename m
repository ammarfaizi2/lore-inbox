Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRLLM1t>; Wed, 12 Dec 2001 07:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRLLM1j>; Wed, 12 Dec 2001 07:27:39 -0500
Received: from imag.imag.fr ([129.88.30.1]:32672 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id <S279307AbRLLM1Z>;
	Wed, 12 Dec 2001 07:27:25 -0500
Date: Wed, 12 Dec 2001 13:27:22 +0100
From: Pierre Lombard <pierre.lombard@imag.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] small doc update for /proc/sys/net/ipv4/icmp_rate{mask,limit}
Message-ID: <20011212122722.GA21997@sci41.imag.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Comments in the C code are incorrect and the documentation is
outdated.

Attached patch is for 2.4.17-pre8 but probably applies cleanly
against 2.5.x too.

-- 
Best regards,
  Pierre Lombard

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="20011212-icmpmask.diff"

--- linux-2.4.17-pre8~/Documentation/networking/ip-sysctl.txt	Wed Dec 12 12:52:25 2001
+++ linux-2.4.17-pre8/Documentation/networking/ip-sysctl.txt	Wed Dec 12 12:53:17 2001
@@ -309,13 +309,20 @@
 	ICMP ECHO requests sent to it or just those to broadcast/multicast
 	addresses, respectively.
 
-icmp_destunreach_rate - INTEGER
-icmp_paramprob_rate - INTEGER
-icmp_timeexceed_rate - INTEGER
-icmp_echoreply_rate - INTEGER (not enabled per default)
-	Limit the maximal rates for sending ICMP packets to specific targets.
+icmp_ratelimit - INTEGER
+	Limit the maximal rates for sending ICMP packets whose type matches
+	icmp_ratemask (see below) to specific targets.
 	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
-	See the source for more information.
+	Default: 1
+
+icmp_ratemask - INTEGER
+	Mask made of ICMP types for which rates are being limited.
+	Default: 6168
+	Note: 6168 = 0x1818 = 1<<ICMP_DEST_UNREACH + 1<<ICMP_SOURCE_QUENCH +
+	      1<<ICMP_TIME_EXCEEDED + 1<<ICMP_PARAMETERPROB, which means
+	      dest unreachable (3), source quench (4), time exceeded (11)
+	      and parameter problem (12) ICMP packets are rate limited
+	      (check values in icmp.h)
 
 icmp_ignore_bogus_error_responses - BOOLEAN
 	Some routers violate RFC 1122 by sending bogus responses to broadcast
--- linux-2.4.17-pre8~/net/ipv4/icmp.c	Wed Dec 12 12:48:56 2001
+++ linux-2.4.17-pre8/net/ipv4/icmp.c	Wed Dec 12 12:51:41 2001
@@ -154,8 +154,8 @@
  * 	it's bit position.
  *
  *	default: 
- *	dest unreachable (0x03), source quench (0x04),
- *	time exceeded (0x11), parameter problem (0x12)
+ *	dest unreachable (3), source quench (4),
+ *	time exceeded (11), parameter problem (12)
  */
 
 int sysctl_icmp_ratelimit = 1*HZ;

--9jxsPFA5p3P2qPhR--
