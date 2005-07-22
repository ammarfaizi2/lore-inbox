Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVGVVr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVGVVr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVGVVpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:45:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41482 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262195AbVGVVpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:45:00 -0400
Date: Fri, 22 Jul 2005 23:44:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/rio/: fix warnings with -Wundef
Message-ID: <20050722214453.GX3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings with -Wundef:

<--  snip  -->

...
  CC      drivers/char/rio/rioboot.o
drivers/char/rio/rioboot.c:905:5: warning: "NEED_TO_FIX" is not defined
drivers/char/rio/rioboot.c:921:5: warning: "NEED_TO_FIX" is not defined
drivers/char/rio/rioboot.c:1146:5: warning: "NEED_TO_FIX" is not defined
drivers/char/rio/rioboot.c:1162:5: warning: "NEED_TO_FIX" is not defined
drivers/char/rio/rioboot.c:1172:5: warning: "NEED_TO_FIX" is not defined
drivers/char/rio/rioboot.c:1191:5: warning: "NEED_TO_FIX" is not defined
...
  CC      drivers/char/rio/rioroute.o
drivers/char/rio/rioroute.c:1026:5: warning: "NEED_TO_FIX_THIS" is not defined
  CC      drivers/char/rio/riotable.o
...
drivers/char/rio/riotable.c:774:5: warning: "NEED_TO_FIX" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/rio/rioboot.c  |   12 ++++++------
 drivers/char/rio/rioroute.c |    2 +-
 drivers/char/rio/riotable.c |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.13-rc3-mm1-full/drivers/char/rio/rioboot.c.old	2005-07-22 18:18:07.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/char/rio/rioboot.c	2005-07-22 18:47:35.000000000 +0200
@@ -902,7 +902,7 @@
 	       (HostP->Mapping[entry].RtaUniqueNum==RtaUniq))
 	    {
 	        HostP->Mapping[entry].Flags |= RTA_BOOTED|RTA_NEWBOOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 		RIO_SV_BROADCAST(HostP->svFlags[entry]);
 #endif
 		if ( (sysport=HostP->Mapping[entry].SysPort) != NO_PORT )
@@ -918,7 +918,7 @@
 		   {
 			entry2 = HostP->Mapping[entry].ID2 - 1;
 			HostP->Mapping[entry2].Flags |= RTA_BOOTED|RTA_NEWBOOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 			RIO_SV_BROADCAST(HostP->svFlags[entry2]);
 #endif
 			sysport = HostP->Mapping[entry2].SysPort;
@@ -1143,7 +1143,7 @@
 		    CCOPY( MapP->Name, HostP->Mapping[entry].Name, MAX_NAME_LEN );
 		    HostP->Mapping[entry].Flags =
 		     SLOT_IN_USE | RTA_BOOTED | RTA_NEWBOOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 		    RIO_SV_BROADCAST(HostP->svFlags[entry]);
 #endif
 		    RIOReMapPorts( p, HostP, &HostP->Mapping[entry] );
@@ -1159,7 +1159,7 @@
    "This RTA has a tentative entry on another host - delete that entry (1)\n");
 		    HostP->Mapping[entry].Flags =
 		     SLOT_TENTATIVE | RTA_BOOTED | RTA_NEWBOOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 		    RIO_SV_BROADCAST(HostP->svFlags[entry]);
 #endif
 		}
@@ -1169,7 +1169,7 @@
 		    {
 			HostP->Mapping[entry2].Flags = SLOT_IN_USE |
 			 RTA_BOOTED | RTA_NEWBOOT | RTA16_SECOND_SLOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 			RIO_SV_BROADCAST(HostP->svFlags[entry2]);
 #endif
 			HostP->Mapping[entry2].SysPort = MapP2->SysPort;
@@ -1188,7 +1188,7 @@
 		    else
 			HostP->Mapping[entry2].Flags = SLOT_TENTATIVE |
 			 RTA_BOOTED | RTA_NEWBOOT | RTA16_SECOND_SLOT;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 			RIO_SV_BROADCAST(HostP->svFlags[entry2]);
 #endif
 		    bzero( (caddr_t)MapP2, sizeof(struct Map) );
--- linux-2.6.13-rc3-mm1-full/drivers/char/rio/rioroute.c.old	2005-07-22 18:18:37.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/char/rio/rioroute.c	2005-07-22 18:18:43.000000000 +0200
@@ -1023,7 +1023,7 @@
     if (link < LINKS_PER_UNIT)
 	    return 1;
 
-#if NEED_TO_FIX_THIS
+#ifdef NEED_TO_FIX_THIS
     /* Ok so all the links are disconnected. But we may have only just
     ** made this slot tentative and not yet received a topology update.
     ** Lets check how long ago we made it tentative.
--- linux-2.6.13-rc3-mm1-full/drivers/char/rio/riotable.c.old	2005-07-22 18:18:51.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/char/rio/riotable.c	2005-07-22 18:18:55.000000000 +0200
@@ -771,7 +771,7 @@
 	    if ((MapP->Flags & RTA16_SECOND_SLOT) == 0)
 	      CCOPY( MapP->Name, HostMapP->Name, MAX_NAME_LEN );
 	    HostMapP->Flags = SLOT_IN_USE | RTA_BOOTED;
-#if NEED_TO_FIX
+#ifdef NEED_TO_FIX
 	    RIO_SV_BROADCAST(p->RIOHosts[host].svFlags[MapP->ID-1]);
 #endif
 	    if (MapP->Flags & RTA16_SECOND_SLOT)

