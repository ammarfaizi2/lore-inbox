Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281488AbRLMI6U>; Thu, 13 Dec 2001 03:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280771AbRLMI6K>; Thu, 13 Dec 2001 03:58:10 -0500
Received: from imag.imag.fr ([129.88.30.1]:44486 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id <S281488AbRLMI5w>;
	Thu, 13 Dec 2001 03:57:52 -0500
Date: Thu, 13 Dec 2001 09:57:49 +0100
From: Pierre Lombard <pierre.lombard@imag.fr>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small doc update for /proc/sys/net/ipv4/icmp_rate{mask,limit}
Message-ID: <20011213085749.GA8332@sci41.imag.fr>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011212122722.GA21997@sci41.imag.fr> <20011212.163726.38712274.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20011212.163726.38712274.davem@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2001 at 04:37:26PM -0800, David S. Miller wrote:

> Your patch does not apply, did you edit this patch by hand
> before submitting it?  The "#lines" in the patch chunks are
> inaccurate.

Yes.  I didn't thought it would break since it applied cleanly
here but it did :)

A fresh & unedited version against a vanilla 2.4.17-pre8 is
text-attached.

-- 
Best regards,
  Pierre Lombard

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="20011213-icmpmask.diff"

diff -urN linux-2.4.17-pre8/Documentation/networking/ip-sysctl.txt linux/Documentation/networking/ip-sysctl.txt
--- linux-2.4.17-pre8/Documentation/networking/ip-sysctl.txt	Wed May 16 19:21:45 2001
+++ linux/Documentation/networking/ip-sysctl.txt	Thu Dec 13 09:40:03 2001
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
diff -urN linux-2.4.17-pre8/net/ipv4/icmp.c linux/net/ipv4/icmp.c
--- linux-2.4.17-pre8/net/ipv4/icmp.c	Wed Nov  7 23:39:36 2001
+++ linux/net/ipv4/icmp.c	Thu Dec 13 09:40:03 2001
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

--UugvWAfsgieZRqgk--
