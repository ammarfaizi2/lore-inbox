Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284118AbRLFPFx>; Thu, 6 Dec 2001 10:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284122AbRLFPFo>; Thu, 6 Dec 2001 10:05:44 -0500
Received: from [212.169.100.200] ([212.169.100.200]:35566 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S284118AbRLFPFe>; Thu, 6 Dec 2001 10:05:34 -0500
Date: Thu, 6 Dec 2001 16:11:30 +0100
From: Morten Helgesen <admin@nextframe.net>
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] converting drivers/net/wan/lmc/lmc_main.c from suser() to capable()
Message-ID: <20011206161130.D122@sexything>
Reply-To: admin@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus, Marcelo and the rest of you.

The code mentioned in the subject does not seem to have a maintainer. I sent the patch to those mentioned
in lmc_main.c, and from Andrew Stanley-Jones I got the following answer:

"I'm not sure it's really being maintained, but I was the last one to work
 on it afaik.  Feel free to apply it.
 -Andrew"

So I guess, if the patch looks good, it is just for you to apply it ... it is against 2.5.1-pre5, but should
apply cleanly to 2.4 as well ...

== Morten

-- 
mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net

--- /usr/src/linux-2.5.1-pre5/drivers/net/wan/lmc/lmc_main.c    Fri Sep 14 01:04:43 2001
+++ /usr/src/patched-linux-2.5.1-pre5/drivers/net/wan/lmc/lmc_main.c    Thu Dec  6 13:17:21 2001
@@ -176,7 +176,7 @@

     case LMCIOCSINFO: /*fold01*/
         sp = &((struct ppp_device *) dev)->sppp;
-        if (!suser ()) {
+        if (!capable(CAP_NET_ADMIN)) {
             ret = -EPERM;
             break;
         }
@@ -211,7 +211,7 @@
             u_int16_t  old_type = sc->if_type;
             u_int16_t  new_type;

-           if (!suser ()) {
+           if (!capable(CAP_NET_ADMIN)) {
                ret = -EPERM;
                break;
            }
@@ -291,7 +291,7 @@
         break;

     case LMCIOCCLEARLMCSTATS: /*fold01*/
-        if (!suser ()){
+        if (!capable(CAP_NET_ADMIN)){
             ret = -EPERM;
             break;
         }
@@ -305,7 +305,7 @@
         break;

     case LMCIOCSETCIRCUIT: /*fold01*/
-        if (!suser ()){
+        if (!capable(CAP_NET_ADMIN)){
             ret = -EPERM;
             break;
         }
@@ -323,7 +323,7 @@
         break;

     case LMCIOCRESET: /*fold01*/
-        if (!suser ()){
+        if (!capable(CAP_NET_ADMIN)){
             ret = -EPERM;
             break;
         }
@@ -356,7 +356,7 @@
         {
             struct lmc_xilinx_control xc; /*fold02*/

-            if (!suser ()){
+            if (!capable(CAP_NET_ADMIN)){
                 ret = -EPERM;
                 break;
             }

