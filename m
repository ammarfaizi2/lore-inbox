Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263538AbSJGWU5>; Mon, 7 Oct 2002 18:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263539AbSJGWU5>; Mon, 7 Oct 2002 18:20:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62624 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263538AbSJGWU4>; Mon, 7 Oct 2002 18:20:56 -0400
To: linux-kernel@vger.kernel.org
Cc: juang@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF2F07E0DC.299628DE-ON87256C4B.00790F36@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Mon, 7 Oct 2002 16:26:32 -0600
Subject: kernelNFS(lockd) problem and patch suggestion 
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/07/2002 16:26:33
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=08BBE6D8DFEA89A68f9e8a93df938690918c08BBE6D8DFEA89A6"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=08BBE6D8DFEA89A68f9e8a93df938690918c08BBE6D8DFEA89A6
Content-type: text/plain; charset=US-ASCII





Hi all,

I noticed that after starting a linux NFS server, the first lock request
gets delayed about 30 seconds even after waiting the 45 seconds
corresponding to the grace period.
At first I thought this was due to the fact that being the first time a
lock is acquired through the server lockd/statd interaction was required
and the creation of a new file was involved
(i.e. statd/sm/client_IP) but still 30 seconds was way too long...

After taking a look at the code I realized that the lockd thread sets grace
period and then goes to sleep for a long time waiting for messages and the
first message always gets processed
before checking if the grace period has completed (which it might after
sleeping for a long time).

I think this can be easily fixed by clearing the grace period after waiting
for messages and before procesing them for correct operation as described
in the following patch.

I will appreciate if this patch can be considered for inclusion in the
general distribution of the kernel.

(See attached file: lockd_delay_patch.2.4.19)


Juan
--0__=08BBE6D8DFEA89A68f9e8a93df938690918c08BBE6D8DFEA89A6
Content-type: application/octet-stream; 
	name="lockd_delay_patch.2.4.19"
Content-Disposition: attachment; filename="lockd_delay_patch.2.4.19"
Content-transfer-encoding: base64

KioqIGxpbnV4LTIuNC4xOS9mcy9sb2NrZC9zdmMuYwlTdW4gT2N0IDIxIDEwOjMyOjMzIDIwMDEN
Ci0tLSBsaW51eC0yLjQuMTkubG9ja2RfZGVsYXlfcGF0Y2gvZnMvbG9ja2Qvc3ZjLmMJTW9uIE9j
dCAgNyAyMjoxNjoyMCAyMDAyDQoqKioqKioqKioqKioqKioNCioqKiAxNDQsMTUxICoqKioNCiAg
CQkgKi8NCiAgCQlpZiAoIW5sbXN2Y19ncmFjZV9wZXJpb2QpIHsNCiAgCQkJdGltZW91dCA9IG5s
bXN2Y19yZXRyeV9ibG9ja2VkKCk7DQohIAkJfSBlbHNlIGlmICh0aW1lX2JlZm9yZShncmFjZV9w
ZXJpb2RfZXhwaXJlLCBqaWZmaWVzKSkNCiEgCQkJY2xlYXJfZ3JhY2VfcGVyaW9kKCk7DQogIA0K
ICAJCS8qDQogIAkJICogRmluZCBhIHNvY2tldCB3aXRoIGRhdGEgYXZhaWxhYmxlIGFuZCBjYWxs
IGl0cw0KLS0tIDE0NCwxNTAgLS0tLQ0KICAJCSAqLw0KICAJCWlmICghbmxtc3ZjX2dyYWNlX3Bl
cmlvZCkgew0KICAJCQl0aW1lb3V0ID0gbmxtc3ZjX3JldHJ5X2Jsb2NrZWQoKTsNCiEgCQl9IA0K
ICANCiAgCQkvKg0KICAJCSAqIEZpbmQgYSBzb2NrZXQgd2l0aCBkYXRhIGF2YWlsYWJsZSBhbmQg
Y2FsbCBpdHMNCioqKioqKioqKioqKioqKg0KKioqIDE2MywxNjggKioqKg0KLS0tIDE2MiwxNzcg
LS0tLQ0KICANCiAgCQlkcHJpbnRrKCJsb2NrZDogcmVxdWVzdCBmcm9tICUwOHhcbiIsDQogIAkJ
CSh1bnNpZ25lZCludG9obChycXN0cC0+cnFfYWRkci5zaW5fYWRkci5zX2FkZHIpKTsNCisgDQor
ICAgICAgICAgICAgICAgICAvKiBXZSBuZWVkIHRvIGRvIHRoZSBjbGVhci9ncmFjZSBwZXJpb2Qg
aGVyZSBhbmQgbm90IGJlZm9yZSBzdmNfcmVjdigpDQorICAgICAgICAgICAgICAgICAgKiBiZWNh
dXNlIHN2Y19yZWN2IG1heSBzbGVlcCBsb25nZXIgdGhhbiB0aGUgZ3JhY2UgcGVyaW9kIGFuZCB0
aGUgDQorICAgICAgICAgICAgICAgICAgKiBmaXJzdCByZXF1ZXN0IG1heSBiZSBmYWxzZWx5IHBy
b2Nlc3NlZCBhcyBpZiB0aGUgc2VydmVyIHdhcyBpbiB0aGUgDQorICAgICAgICAgICAgICAgICAg
KiBncmFjZSBwZXJpb2Qgd2hlbiBpdCBpcyBub3QgY2F1c2luZyB1bm5lY2Vzc2FyeSBkZWxheXMu
DQorICAgICAgICAgICAgICAgICAgKiBKdWFuIEMuIEdvbWV6IGpfY2FybG9zX2dvbWVAeWFob28u
Y29tDQorICAgICAgICAgICAgICAgICAgKi8NCisgICAgICAgICAgICAgICAgIGlmIChubG1zdmNf
Z3JhY2VfcGVyaW9kICYmIHRpbWVfYmVmb3JlKGdyYWNlX3BlcmlvZF9leHBpcmUsIGppZmZpZXMp
KXsNCisgICAgICAgICAgICAgICAgICAgY2xlYXJfZ3JhY2VfcGVyaW9kKCk7DQorICAgICAgICAg
ICAgICAgICB9DQogIA0KICAJCS8qDQogIAkJICogTG9vayB1cCB0aGUgTkZTIGNsaWVudCBoYW5k
bGUuIFRoZSBoYW5kbGUgaXMgbmVlZGVkIGZvcg0K

--0__=08BBE6D8DFEA89A68f9e8a93df938690918c08BBE6D8DFEA89A6--

