Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSCNP2K>; Thu, 14 Mar 2002 10:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311148AbSCNP2B>; Thu, 14 Mar 2002 10:28:01 -0500
Received: from netmail.netcologne.de ([194.8.194.109]:5461 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S311475AbSCNP1s>; Thu, 14 Mar 2002 10:27:48 -0500
Message-Id: <200203141527.AUR63833@netmail.netcologne.de>
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre2-jp7 #1 Fre =?iso8859-15?q?M=E4r=208=2021=3A37=3A18=20CET=202002=20i686?= unknown
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA and IrDA workaround for Dell Inspiron
Date: Thu, 14 Mar 2002 16:27:01 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1XYYFDIKD1XZBLEIBOKG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1XYYFDIKD1XZBLEIBOKG
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit


Here is a patch to solve an IrDA lockup when ALSA OSS is used with IrDA on 
Dell Inspiron 8100. Maybe some other laptops are concerned, too. Please test 
if other machines can use this patch.

The ALSA OSS initialization code performs a hard reset on the IrDA port of a 
Dell Inspiron. No more data can be sent or received via the infrared port 
until a cold restart of the system (power down). The lockup will always 
happen when ALSA is started after IrDA which is normally the case. 

I found the ALSA OSS AC97 modem probe is the reason. This patch enables a 
workaround by a kernel option CONFIG_SOUND_NO_MODEM_PROBE which 
disables the modem probe if the option is enabled.

The patch will be included in my upcoming kernel patch set -jp8.

Please reply with CC since I am not subscribed to the Linux kernel mailing 
list.

Cheers,

Jörg Prante <joerg@infolinux.de>

--------------Boundary-00=_1XYYFDIKD1XZBLEIBOKG
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="alsa-irda-no-modem-probe.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-irda-no-modem-probe.patch"

LS0tIGxpbnV4L3NvdW5kL29zcy9hYzk3X2NvZGVjLmMJRnJpIE1hciAgOCAwMzoxODoxMyAyMDAy
CisrKyBsaW51eC1qcDgvc291bmQvb3NzL2FjOTdfY29kZWMuYwlUaHUgTWFyIDE0IDE1OjQ4OjM5
IDIwMDIKQEAgLTMxLDYgKzMxLDggQEAKICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgogICoKICAqIEhpc3Rv
cnkKKyAqIHYwLjRhIE1hciAxMiAyMDAyIEr2cmcgUHJhbnRlIDxqb2VyZ0BpbmZvbGludXguZGU+
CisgKiAgbWlub3IgZml4OiBkbyBub3QgcHJvYmUgZm9yIG1vZGVtIGNvZGVjCiAgKiB2MC40IE1h
ciAxNSAyMDAwIE9sbGllIExobwogICoJZHVhbCBjb2RlY3Mgc3VwcG9ydCB2ZXJpZmllZCB3aXRo
IDQgY2hhbm5lbHMgb3V0cHV0CiAgKiB2MC4zIEZlYiAyMiAyMDAwIE9sbGllIExobwpAQCAtNjkx
LDggKzY5MywxNSBAQAogCX0KIAogCS8qIHByb2JlIGZvciBNb2RlbSBDb2RlYyAqLworI2lmIENP
TkZJR19TT1VORF9OT19NT0RFTV9QUk9CRQorCS8qIERvIG5vdCBwcm9iZSBmb3IgTW9kZW0gQ29k
ZWMuIAorCSAgIFRoaXMgcHJldmVudHMgSXJEQSBsb2NrdXBzIG9uIHNvbWUgbGFwdG9wcyAoRGVs
bCBJbnNwaXJvbikKKyAgICAgICB3aGVuIHNvdW5kIGlzIGluaXRpYWxpemVkIGFmdGVyIElyREEg
aW5pdC4gLWpwcmFudGUgKi8KKwltb2RlbSA9IDA7IAorI2Vsc2UKIAljb2RlYy0+Y29kZWNfd3Jp
dGUoY29kZWMsIEFDOTdfRVhURU5ERURfTU9ERU1fSUQsIDBMKTsKIAltb2RlbSA9IGNvZGVjLT5j
b2RlY19yZWFkKGNvZGVjLCBBQzk3X0VYVEVOREVEX01PREVNX0lEKTsKKyNlbmRpZgogCiAJY29k
ZWMtPm5hbWUgPSBOVUxMOwogCWNvZGVjLT5jb2RlY19vcHMgPSAmbnVsbF9vcHM7Ci0tLSBsaW51
eC9zb3VuZC9vc3MvQ29uZmlnLmluCVRodSBNYXIgMTQgMDA6NDI6NDggMjAwMgorKysgbGludXgt
anA4L3NvdW5kL29zcy9Db25maWcuaW4JVGh1IE1hciAxNCAxNTo1MzozMiAyMDAyCkBAIC00LDYg
KzQsMTEgQEAKICMgTW9yZSBoYWNraW5nIGZvciBtb2R1bGFyaXNhdGlvbi4KICMKIAorIyBEbyBu
b3QgcHJvYmUgZm9yIG1vZGVtIGNvZGVjIG9wdGlvbi4gVGhpcyBpcyBhIHdvcmthcm91bmQgdG8g
cHJldmVudCAKKyMgaGFyZCBJckRBIGxvY2t1cHMgb24gc29tZSBsYXB0b3BzIChEZWxsIEluc3Bp
cm9uKS4gLWpwcmFudGUKKworYm9vbCAnRG8gbm90IHByb2JlIGZvciBBQzk3IE1vZGVtIENvZGVj
IChwcmV2ZW50IElyREEgbG9ja3VwKScgQ09ORklHX1NPVU5EX05PX01PREVNX1BST0JFCisKICMg
UHJvbXB0IHVzZXIgZm9yIHByaW1hcnkgZHJpdmVycy4KIAogZGVwX3RyaXN0YXRlICcgIEJUODc4
IGF1ZGlvIGRtYScgQ09ORklHX1NPVU5EX0JUODc4ICRDT05GSUdfU09VTkQK

--------------Boundary-00=_1XYYFDIKD1XZBLEIBOKG--
