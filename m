Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVADUbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVADUbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVADU2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:28:33 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:65222 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262114AbVADUYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:24:10 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Mark_H_Johnson@raytheon.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, perex@suse.cz,
       Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
From: Mark_H_Johnson@raytheon.com
Subject: Re: 2.6.10-mm1: ALSA ac97 compile error with CONFIG_PM=n
Date: Tue, 4 Jan 2005 11:01:47 -0600
Message-ID: <OF0F545DFC.B5D4268B-ON86256F7F.005D8C3B-86256F7F.005D8C69@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/04/2005 11:02:51 AM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=09BBE5ECDFCE0AAB8f9e8a93df938690918c09BBE5ECDFCE0AAB"
Content-Disposition: inline
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=09BBE5ECDFCE0AAB8f9e8a93df938690918c09BBE5ECDFCE0AAB
Content-type: text/plain; charset=US-ASCII

>That's not the problem, since function and definition are in the same
>module.
>
>You didn't send your .config, but looking at the code it seems
>CONFIG_PM=n was the culprit.
Yes. CONFIG_PM=N in my .config.

>As a workaround, it should work after enabling the following option:
>  Power management options (ACPI, APM)
>    Power Management support
Hmm. I don't want to do that for my real time testing. I turned that off
to eliminate a class of possible latencies.

>This is only a workaround, I've Cc'ed the ALSA maintainers for a real
>fix.

How about the attached patch instead (which moves the #ifdef CONFIG_PM
and snd_ac97_suspend after the two functions I am having problems with).
Apparently the use of snd_ac97_restore_status and snd_ac97_restore_iec958
is in ac97_patch.c as well as in the power management code. I have not
run the code yet a quick build didn't find any problems with it. I have
a full build / test coming later today.

  --Mark

PS: On the other message you sent related to [add|del]_mtd_partitions
applies with the 2nd hunk failing (that code not present) but the first
hunk makes the build problem I had go away. Thanks.
--0__=09BBE5ECDFCE0AAB8f9e8a93df938690918c09BBE5ECDFCE0AAB
Content-type: application/octet-stream; 
	name="ac97-fix-nopm.patch"
Content-Disposition: attachment; filename="ac97-fix-nopm.patch"
Content-transfer-encoding: base64

LS0tIGtlcm5lbC0yLjYuMTBtbTEvc291bmQvcGNpL2FjOTcvYWM5N19jb2RlYy5jLm9yaWcJMjAw
NS0wMS0wNCAwNzo0MDoyNy4wMDAwMDAwMDAgLTA2MDAKKysrIGtlcm5lbC0yLjYuMTBtbTEvc291
bmQvcGNpL2FjOTcvYWM5N19jb2RlYy5jCTIwMDUtMDEtMDQgMTA6NDg6MjEuMDAwMDAwMDAwIC0w
NjAwCkBAIC0yMjAxLDE4ICsyMjAxLDYgQEAKIH0KIAogCi0jaWZkZWYgQ09ORklHX1BNCi0vKioK
LSAqIHNuZF9hYzk3X3N1c3BlbmQgLSBHZW5lcmFsIHN1c3BlbmQgZnVuY3Rpb24gZm9yIEFDOTcg
Y29kZWMKLSAqIEBhYzk3OiB0aGUgYWM5NyBpbnN0YW5jZQotICoKLSAqIFN1c3BlbmRzIHRoZSBj
b2RlYywgcG93ZXIgZG93biB0aGUgY2hpcC4KLSAqLwotdm9pZCBzbmRfYWM5N19zdXNwZW5kKGFj
OTdfdCAqYWM5NykKLXsKLQlzbmRfYWM5N19wb3dlcmRvd24oYWM5Nyk7Ci19Ci0KIC8qCiAgKiBy
ZXN0b3JlIGFjOTcgc3RhdHVzCiAgKi8KQEAgLTIyNTMsNiArMjI0MSwxOCBAQAogCX0KIH0KIAor
I2lmZGVmIENPTkZJR19QTQorLyoqCisgKiBzbmRfYWM5N19zdXNwZW5kIC0gR2VuZXJhbCBzdXNw
ZW5kIGZ1bmN0aW9uIGZvciBBQzk3IGNvZGVjCisgKiBAYWM5NzogdGhlIGFjOTcgaW5zdGFuY2UK
KyAqCisgKiBTdXNwZW5kcyB0aGUgY29kZWMsIHBvd2VyIGRvd24gdGhlIGNoaXAuCisgKi8KK3Zv
aWQgc25kX2FjOTdfc3VzcGVuZChhYzk3X3QgKmFjOTcpCit7CisJc25kX2FjOTdfcG93ZXJkb3du
KGFjOTcpOworfQorCiAvKioKICAqIHNuZF9hYzk3X3Jlc3VtZSAtIEdlbmVyYWwgcmVzdW1lIGZ1
bmN0aW9uIGZvciBBQzk3IGNvZGVjCiAgKiBAYWM5NzogdGhlIGFjOTcgaW5zdGFuY2UK

--0__=09BBE5ECDFCE0AAB8f9e8a93df938690918c09BBE5ECDFCE0AAB--

