Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272242AbRIOL33>; Sat, 15 Sep 2001 07:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272080AbRIOL3V>; Sat, 15 Sep 2001 07:29:21 -0400
Received: from [209.10.41.242] ([209.10.41.242]:60824 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S272240AbRIOL3E>;
	Sat, 15 Sep 2001 07:29:04 -0400
Date: Fri, 14 Sep 2001 12:56:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-raid@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [patch] raid-xor-2.4.10-A0
Message-ID: <Pine.LNX.4.33.0109141251410.3820-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1602042851-1000465003=:3820"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1602042851-1000465003=:3820
Content-Type: TEXT/PLAIN; charset=US-ASCII


another RAID patch against 2.4.10-pre9:

 - update the SSE XOR routines to get compiled and used on recent kernels.

 - change prefetch code to pollute the cache less, and to prefetch in a
   wider window, to give enough time for prefetches to finish.

people with SSE-capable CPUs (PIII, PIV, newer Athlons) should see
something like this in the bootlog:

 raid5: measuring checksumming speed
    8regs     :  1292.400 MB/sec
    32regs    :   607.600 MB/sec
    pIII_sse  :  1407.200 MB/sec
    pII_mmx   :  1600.800 MB/sec
    p5_mmx    :  1670.000 MB/sec
 raid5: using function: pIII_sse (1407.200 MB/sec)

(if present then the SSE code is still picked up exclusively due to its
better cache-properties, even if it's 'cached performance' is lower than
that of MMX routines.)

	Ingo

--8323328-1602042851-1000465003=:3820
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="raid-xor-2.4.10-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109141256430.3820@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="raid-xor-2.4.10-A0"

LS0tIGxpbnV4L2luY2x1ZGUvYXNtLWkzODYveG9yLmgub3JpZzIJRnJpIFNl
cCAxNCAxMjoxMDoyMSAyMDAxDQorKysgbGludXgvaW5jbHVkZS9hc20taTM4
Ni94b3IuaAlGcmkgU2VwIDE0IDEyOjMyOjM2IDIwMDENCkBAIC01MjcsOCAr
NTI3LDYgQEANCiAjdW5kZWYgRlBVX1NBVkUNCiAjdW5kZWYgRlBVX1JFU1RP
UkUNCiANCi0jaWYgZGVmaW5lZChDT05GSUdfWDg2X0ZYU1IpIHx8IGRlZmlu
ZWQoQ09ORklHX1g4Nl9SVU5USU1FX0ZYU1IpDQotDQogLyoNCiAgKiBDYWNo
ZSBhdm9pZGluZyBjaGVja3N1bW1pbmcgZnVuY3Rpb25zIHV0aWxpemluZyBL
TkkgaW5zdHJ1Y3Rpb25zDQogICogQ29weXJpZ2h0IChDKSAxOTk5IFphY2gg
QnJvd24gKHdpdGggb2J2aW91cyBjcmVkaXQgZHVlIEluZ28pDQpAQCAtNTU5
LDE5ICs1NTcsMjAgQEANCiAJCTogIm1lbW9yeSIpDQogDQogI2RlZmluZSBP
RkZTKHgpCQkiMTYqKCIjeCIpIg0KLSNkZWZpbmUJUEYwKHgpCQkiCXByZWZl
dGNodDAgICJPRkZTKHgpIiglMSkgICA7XG4iDQotI2RlZmluZSBMRCh4LHkp
CQkiICAgICAgIG1vdmFwcyAgICJPRkZTKHgpIiglMSksICUleG1tIiN5IiAg
IDtcbiINCi0jZGVmaW5lIFNUKHgseSkJCSIgICAgICAgbW92YXBzICUleG1t
IiN5IiwgICAiT0ZGUyh4KSIoJTEpICAgO1xuIg0KLSNkZWZpbmUgUEYxKHgp
CQkiCXByZWZldGNobnRhICJPRkZTKHgpIiglMikgICA7XG4iDQotI2RlZmlu
ZSBQRjIoeCkJCSIJcHJlZmV0Y2hudGEgIk9GRlMoeCkiKCUzKSAgIDtcbiIN
Ci0jZGVmaW5lIFBGMyh4KQkJIglwcmVmZXRjaG50YSAiT0ZGUyh4KSIoJTQp
ICAgO1xuIg0KLSNkZWZpbmUgUEY0KHgpCQkiCXByZWZldGNobnRhICJPRkZT
KHgpIiglNSkgICA7XG4iDQotI2RlZmluZSBQRjUoeCkJCSIJcHJlZmV0Y2hu
dGEgIk9GRlMoeCkiKCU2KSAgIDtcbiINCi0jZGVmaW5lIFhPMSh4LHkpCSIg
ICAgICAgeG9ycHMgICAiT0ZGUyh4KSIoJTIpLCAlJXhtbSIjeSIgICA7XG4i
DQotI2RlZmluZSBYTzIoeCx5KQkiICAgICAgIHhvcnBzICAgIk9GRlMoeCki
KCUzKSwgJSV4bW0iI3kiICAgO1xuIg0KLSNkZWZpbmUgWE8zKHgseSkJIiAg
ICAgICB4b3JwcyAgICJPRkZTKHgpIiglNCksICUleG1tIiN5IiAgIDtcbiIN
Ci0jZGVmaW5lIFhPNCh4LHkpCSIgICAgICAgeG9ycHMgICAiT0ZGUyh4KSIo
JTUpLCAlJXhtbSIjeSIgICA7XG4iDQotI2RlZmluZSBYTzUoeCx5KQkiICAg
ICAgIHhvcnBzICAgIk9GRlMoeCkiKCU2KSwgJSV4bW0iI3kiICAgO1xuIg0K
KyNkZWZpbmUgUEZfT0ZGUyh4KQkiMjU2KzE2KigiI3giKSINCisjZGVmaW5l
CVBGMCh4KQkJIglwcmVmZXRjaG50YSAiUEZfT0ZGUyh4KSIoJTEpCQk7XG4i
DQorI2RlZmluZSBMRCh4LHkpCQkiICAgICAgIG1vdmFwcyAgICJPRkZTKHgp
IiglMSksICUleG1tIiN5Igk7XG4iDQorI2RlZmluZSBTVCh4LHkpCQkiICAg
ICAgIG1vdmFwcyAlJXhtbSIjeSIsICAgIk9GRlMoeCkiKCUxKQk7XG4iDQor
I2RlZmluZSBQRjEoeCkJCSIJcHJlZmV0Y2hudGEgIlBGX09GRlMoeCkiKCUy
KQkJO1xuIg0KKyNkZWZpbmUgUEYyKHgpCQkiCXByZWZldGNobnRhICJQRl9P
RkZTKHgpIiglMykJCTtcbiINCisjZGVmaW5lIFBGMyh4KQkJIglwcmVmZXRj
aG50YSAiUEZfT0ZGUyh4KSIoJTQpCQk7XG4iDQorI2RlZmluZSBQRjQoeCkJ
CSIJcHJlZmV0Y2hudGEgIlBGX09GRlMoeCkiKCU1KQkJO1xuIg0KKyNkZWZp
bmUgUEY1KHgpCQkiCXByZWZldGNobnRhICJQRl9PRkZTKHgpIiglNikJCTtc
biINCisjZGVmaW5lIFhPMSh4LHkpCSIgICAgICAgeG9ycHMgICAiT0ZGUyh4
KSIoJTIpLCAlJXhtbSIjeSIJO1xuIg0KKyNkZWZpbmUgWE8yKHgseSkJIiAg
ICAgICB4b3JwcyAgICJPRkZTKHgpIiglMyksICUleG1tIiN5Igk7XG4iDQor
I2RlZmluZSBYTzMoeCx5KQkiICAgICAgIHhvcnBzICAgIk9GRlMoeCkiKCU0
KSwgJSV4bW0iI3kiCTtcbiINCisjZGVmaW5lIFhPNCh4LHkpCSIgICAgICAg
eG9ycHMgICAiT0ZGUyh4KSIoJTUpLCAlJXhtbSIjeSIJO1xuIg0KKyNkZWZp
bmUgWE81KHgseSkJIiAgICAgICB4b3JwcyAgICJPRkZTKHgpIiglNiksICUl
eG1tIiN5Igk7XG4iDQogDQogDQogc3RhdGljIHZvaWQNCkBAIC04NDksMTUg
Kzg0OCw2IEBADQogICAgZGVhbHMgd2l0aCBhIGxvYWQgdG8gYSBsaW5lIHRo
YXQgaXMgYmVpbmcgcHJlZmV0Y2hlZC4gICovDQogI2RlZmluZSBYT1JfU0VM
RUNUX1RFTVBMQVRFKEZBU1RFU1QpIFwNCiAJKGNwdV9oYXNfeG1tID8gJnhv
cl9ibG9ja19wSUlJX3NzZSA6IEZBU1RFU1QpDQotDQotI2Vsc2UNCi0NCi0v
KiBEb24ndCB0cnkgYW55IFNTRTIgd2hlbiBGWFNSIGlzIG5vdCBlbmFibGVk
LCBiZWNhdXNlIE9TRlhTUiB3aWxsIG5vdCBiZSBzZXQNCi0gICAtQUsgKi8g
DQotI2RlZmluZSBYT1JfU1NFMiANCi0jZGVmaW5lIFhPUl9TRUxFQ1RfVEVN
UExBVEUoRkFTVEVTVCkgKEZBU1RFU1QpDQotDQotI2VuZGlmDQogDQogLyog
QWxzbyB0cnkgdGhlIGdlbmVyaWMgcm91dGluZXMuICAqLw0KICNpbmNsdWRl
IDxhc20tZ2VuZXJpYy94b3IuaD4NCg==
--8323328-1602042851-1000465003=:3820--
