Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277923AbRJORG2>; Mon, 15 Oct 2001 13:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJORGT>; Mon, 15 Oct 2001 13:06:19 -0400
Received: from host.sargentlundy.com ([151.154.52.12]:61199 "EHLO
	mail01.sargentlundy.com") by vger.kernel.org with ESMTP
	id <S277859AbRJORGP> convert rfc822-to-8bit; Mon, 15 Oct 2001 13:06:15 -0400
Subject: Bootp Timeout Problem
To: larsi@gnus.org
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF6348277C.08D3A202-ON86256AE6.005B78B3@sargentlundy.com>
From: CARL.P.HIRSCH@sargentlundy.com
Date: Mon, 15 Oct 2001 12:05:30 -0500
X-MIMETrack: Serialize by Router on mail01/Sargentlundy(Release 5.0.7 |March 21, 2001) at
 10/15/2001 12:05:39 PM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars - I came across the message below while searching to a solution for a
DHCP timeout issue. I'm fairly certain that this fix is relevant to the
problem I'm investigating. We're working with a floppy linux distro that
Novell created for imaging Novell workstations and I hope to apply this
patch to the floppy distro to see if it is the fix we're looking for (we
suspect Spantree Portfast on Cisco Catalyst3524XLs is tripping up DHCP
acquisition)..

I'm a bit of a linux newbie - does this involve editing the ifconfig.c file
only, or is a recompile or any components (or even the kernel?)  required
to cause the change to take effect? If so, I expect the various FAQs can
walk me through the actual procedure.

LKML - apologies if this is off-topic, please reply off-list or CC me.

thanks much,
-carl hirsch
network analyst

From: Lars Magne Ingebrigtsen (larsi@gnus.org)
Date: Sat Jul 29 2000 - 06:16:33 EST
     Next message: Adam Sampson: "Re: sysconf (was Re: RLIM_INFINITY
     inconsistency between archs)"
     Previous message: Amit D Chaudhary: "Re: NFSv4 ACLs (was: ...ACL's and
     reiser...)"
     Next in thread: Fred Reimer: "Re: 2.2.16 bootp timeout problem
     (patch)"
     Reply: Fred Reimer: "Re: 2.2.16 bootp timeout problem (patch)"
     Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]



The Cisco Catalyst 3500 switch has what seems like a training period
of about ten seconds. Therefore, the default 3*2 second waiting
period between card resets is too small to allow a Linux bootp client
to boot through one of these switches.


The following micro-patch just increases the CONF_SEND_RETRIES (which
says how many bootp packets to send out between reopening the device(s))
from 3 to 10, which fixes the problem.


--- ipconfig.c~ Wed Jun 7 23:26:44 2000
+++ ipconfig.c Sat Jul 29 12:53:18 2000
@@ -75,7 +75,7 @@


 /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
 #define CONF_OPEN_RETRIES 3 /* (Re)open devices three times */
-#define CONF_SEND_RETRIES 3 /* Send requests three times */
+#define CONF_SEND_RETRIES 10 /* Send requests ten times */
 #define CONF_BASE_TIMEOUT (HZ*2) /* Initial timeout: 2 seconds */
 #define CONF_TIMEOUT_RANDOM (HZ) /* Maximum amount of randomization */
 #define CONF_TIMEOUT_MULT *7/4 /* Rate of timeout growth */


--
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/


