Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTDOXXB (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTDOXXB 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:23:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60409 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264155AbTDOXW7 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 19:22:59 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.67: Summit family ID strings
Date: Tue, 15 Apr 2003 16:34:44 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_W5SEKB1F27SOKT59FJ92"
Message-Id: <200304151634.44331.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_W5SEKB1F27SOKT59FJ92
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The BIOS gang says that all future Summit family (EXA) boxes will have Pr=
oduct=20
ID strings starting with EXA.  This includes the forthcoming x445.


diff -pru 2.5.67/include/asm-i386/mach-summit/mach_mpparse.h=20
t67/include/asm-i386/mach-summit/mach_mpparse.h
--- 2.5.67/include/asm-i386/mach-summit/mach_mpparse.h=09Mon Apr  7 10:31=
:10=20
2003
+++ t67/include/asm-i386/mach-summit/mach_mpparse.h=09Tue Apr 15 16:20:43=
 2003
@@ -19,6 +19,7 @@ static inline void mps_oem_check(struct=20
 {
 =09if (!strncmp(oem, "IBM ENSW", 8) &&=20
 =09=09=09(!strncmp(productid, "VIGIL SMP", 9)=20
+=09=09=09 || !strncmp(productid, "EXA", 3)
 =09=09=09 || !strncmp(productid, "RUTHLESS SMP", 12))){
 =09=09x86_summit =3D 1;
 =09=09use_cyclone =3D 1; /*enable cyclone-timer*/
@@ -28,7 +29,9 @@ static inline void mps_oem_check(struct=20
 /* Hook from generic ACPI tables.c */
 static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-=09if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "SERVIGIL", =
8)){
+=09if (!strncmp(oem_id, "IBM", 3) &&
+=09    (!strncmp(oem_table_id, "SERVIGIL", 8)
+=09     || !strncmp(oem_table_id, "EXA", 3))){
 =09=09x86_summit =3D 1;
 =09=09use_cyclone =3D 1; /*enable cyclone-timer*/
 =09}


--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_W5SEKB1F27SOKT59FJ92
Content-Type: text/x-diff;
  charset="us-ascii";
  name="x445_2003-04-15_2.5.67"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="x445_2003-04-15_2.5.67"

diff -pru 2.5.67/include/asm-i386/mach-summit/mach_mpparse.h t67/include/asm-i386/mach-summit/mach_mpparse.h
--- 2.5.67/include/asm-i386/mach-summit/mach_mpparse.h	Mon Apr  7 10:31:10 2003
+++ t67/include/asm-i386/mach-summit/mach_mpparse.h	Tue Apr 15 16:20:43 2003
@@ -19,6 +19,7 @@ static inline void mps_oem_check(struct 
 {
 	if (!strncmp(oem, "IBM ENSW", 8) && 
 			(!strncmp(productid, "VIGIL SMP", 9) 
+			 || !strncmp(productid, "EXA", 3)
 			 || !strncmp(productid, "RUTHLESS SMP", 12))){
 		x86_summit = 1;
 		use_cyclone = 1; /*enable cyclone-timer*/
@@ -28,7 +29,9 @@ static inline void mps_oem_check(struct 
 /* Hook from generic ACPI tables.c */
 static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "SERVIGIL", 8)){
+	if (!strncmp(oem_id, "IBM", 3) &&
+	    (!strncmp(oem_table_id, "SERVIGIL", 8)
+	     || !strncmp(oem_table_id, "EXA", 3))){
 		x86_summit = 1;
 		use_cyclone = 1; /*enable cyclone-timer*/
 	}

--------------Boundary-00=_W5SEKB1F27SOKT59FJ92--

