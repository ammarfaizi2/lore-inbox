Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUAMWmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUAMWmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:42:02 -0500
Received: from mailserver2.hrz.tu-darmstadt.de ([130.83.47.4]:14097 "EHLO
	mailserver2.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S266136AbUAMWjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:39:47 -0500
Message-Id: <200401132239.i0DMddeK027814@mailserver2.hrz.tu-darmstadt.de>
From: Jens David <dg1kjd@afthd.tu-darmstadt.de>
Organization: FBR Networks Inc.
To: davej@redhat.com, hpa@zytor.com
Subject: [PATCH] powernow-k7 settling time
Date: Tue, 13 Jan 2004 23:39:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_3M9GAJV7TYVE9REF9EIN"
X-TUD-HRZ-MailScanner: Found to be clean
X-TUD-HRZ-MailScanner-SpamCheck: not spam, SpamAssassin (Wertung=3.31,
	benoetigt 5, MSGID_FROM_MTA_SHORT 3.31)
X-TUD-HRZ-MailScanner-SpamScore: sss
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_3M9GAJV7TYVE9REF9EIN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Dave, Jeff & all,

I do not know exactly where to send this patch to, so please
forward as appropriate.

This patch is needed to get powernow-k7 to work on my el-cheapo
notebook. It seems that the BIOS table that describes the voltage
regulator settling time and possible frequency/clock combinations
is buggy in some cases (such as mine). Specifically if the settling
time is not large enough we switch clock frequencies too soon,
resulting in system instability and possible hardware damage.
This patch analyzes the value suggested by the BIOS and if too
low (I do not believe any general-purpose high current CPU VR
design will settle in under 5ms) it uses a standard value (50ms).
As long as nobody is gonna try delta-sigma modulation of the main
CPU clock the performance loss is probably neglectible. ;-)
I wrote myself a little testbench and with this patch my system works
stable no matter how often I switch and what applications are running
(mplayer proved to be a good test case) provided that clock frequencies
are not adjusted below the 796 MHz (core) step (K7-2000+).

Patch against linux-2.4.24-0pre2.1mdk from current Mandrake Cooker.
Should apply cleanly to powernow-patched vanilla-2.4.x as well. Probably
relevant for Linux-2.6, too.

-- j



-- 
Jens David, DG1KJD
Email: dg1kjd@afthd.tu-darmstadt.de
http://www.afthd.tu-darmstadt.de/~dg1kjd
Work: +49 351 80800 527  ---  Home/Mobile: +49 173 6394993





--------------Boundary-00=_3M9GAJV7TYVE9REF9EIN
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.4.24-0.pre2.1mdk-powernow_k7-settling_time"
Content-Transfer-Encoding: base64
Content-Description: Increase settling time if value provided by BIOS is too low. Patch against Linux-2.4.24-0pre2.1mdk
Content-Disposition: attachment; filename="patch-2.4.24-0.pre2.1mdk-powernow_k7-settling_time"

LS0tIGxpbnV4LTIuNC4yNC0wLnByZTIuMW1kay5vcmlnL2FyY2gvaTM4Ni9rZXJuZWwvcG93ZXJu
b3ctazcuYwkyMDA0LTAxLTEzIDE4OjAyOjI3LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi40
LjI0LTAucHJlMi4xbWRrL2FyY2gvaTM4Ni9rZXJuZWwvcG93ZXJub3ctazcuYwkyMDA0LTAxLTEz
IDIyOjI2OjA5LjAwMDAwMDAwMCArMDEwMApAQCAtMzEzLDggKzMxMywxNiBAQCBzdGF0aWMgaW50
IHBvd2Vybm93X2RlY29kZV9iaW9zIChpbnQgbWF4CiAJCQl9CiAJCQlkcHJpbnRrICgiIHZvbHRh
Z2UgcmVndWxhdG9yKVxuIik7CiAKLQkJCWxhdGVuY3kgPSBwc2ItPnNldHRsaW5ndGltZTsKLQkJ
CWRwcmludGsgKEtFUk5fSU5GTyBQRlggIlNldHRsaW5nIFRpbWU6ICVkIG1pY3Jvc2Vjb25kcy5c
biIsIHBzYi0+c2V0dGxpbmd0aW1lKTsKKwkJCWRwcmludGsgKEtFUk5fSU5GTyBQRlggIlNldHRs
aW5nIFRpbWUgZnJvbSBCSU9TOiAlZCBtaWNyb3NlY29uZHMuXG4iLCBwc2ItPnNldHRsaW5ndGlt
ZSk7CisJCQlpZiAocHNiLT5zZXR0bGluZ3RpbWUgPj0gNTAwMCkgeyAgICAgIC8qID49IDVtcz8g
Ki8KKwkJCQlkcHJpbnRrIChLRVJOX0lORk8gUEZYICJVc2luZyBCSU9TIFNldHRsaW5nIFRpbWUu
XG4iKTsKKwkJCQlsYXRlbmN5ID0gcHNiLT5zZXR0bGluZ3RpbWU7CisJCQl9IGVsc2UgeworCQkJ
ICAgICAgICAvKiBubywgdGFibGUgcHJvYmFibHkgd3JvbmcsIGJlIGNvbnNlcnZhdGl2ZTogc2V0
IHRvIDUwIG1zICovCisJCQkJZHByaW50ayAoS0VSTl9JTkZPIFBGWCAiU2V0dGxpbmcgVGltZSBz
ZWVtcyB0b28gc21hbGwsIGNvcnJlY3RpbmchXG4iKTsKKwkJCQlsYXRlbmN5ID0gNTAwMDA7CisJ
CQl9CisJCQkKIAkJCWRwcmludGsgKEtFUk5fSU5GTyBQRlggIkhhcyAlZCBQU1QgdGFibGVzLiAo
T25seSBkdW1waW5nIG9uZXMgcmVsZXZhbnQgdG8gdGhpcyBDUFUpLlxuIiwgcHNiLT5udW1wc3Qp
OwogCiAJCQlwICs9IHNpemVvZiAoc3RydWN0IHBzYl9zKTsK

--------------Boundary-00=_3M9GAJV7TYVE9REF9EIN--

