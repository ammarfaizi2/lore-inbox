Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286466AbSABBBA>; Tue, 1 Jan 2002 20:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286465AbSABBAv>; Tue, 1 Jan 2002 20:00:51 -0500
Received: from SMTP7.ANDREW.CMU.EDU ([128.2.10.87]:52242 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S286466AbSABBAo>; Tue, 1 Jan 2002 20:00:44 -0500
Date: Tue, 1 Jan 2002 20:00:43 -0500 (EST)
From: Steinar Hauan <hauan@cmu.edu>
X-X-Sender: <hauan@unix13.andrew.cmu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: smp cputime issues
Message-ID: <Pine.GSO.4.33L-022.0201011959360.7513-300000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1009933243=:7513"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1009933243=:7513
Content-Type: TEXT/PLAIN; charset=US-ASCII

hello,

  we are encountering some weird timing behaviour on our linux cluster.

  specifically: when running 2 copies of selected programs on a
  dual-cpu system, the cputime reported for each process is up to 25%
  higher than when the processes are run on their own. however, if running
  two different jobs on the same machine, both complete with a cputime
  equal to when run individually. sample timing output attached.

  profiling confirms that everything slows down approximately to scale.
  the results reproduce on a range of different machines (see below).

additional specifications:
  - kernel version 2.4.16 (with apic enabled)
  - chipsets: apollo pro 133, apollo pro 266,
              intel i860, serverworks LE
  - all jobs requires less than 1/10 of physical memory
  - no significant disk i/o takes place
  - timing with dtime(), /usr/bin/time and shell built-in time
  - this behavior is NOT seen for all applications. the worst
    "offender" spends most of its time doing linear algebra.

  ideas or info-pointers appreciated. more specs available on request.

regards,
--
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA

---559023410-851401618-1009933243=:7513
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="one.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33L-022.0201012000430.7513@unix13.andrew.cmu.edu>
Content-Description: 
Content-Disposition: attachment; filename="one.txt"

b3V0cHV0IGZyb20gcnVubmluZyBhIHNpbmdsZSBpbWFnZSBjb3B5DQoNClty
ZXBvcnRlZCBieSBkdGltZSgpXQ0KDQpDUFUgc2Vjb25kcyBzcGVudCBpbiBJ
UE9QVCBhbmQgZnVuY3Rpb24gZXZhbHVhdGlvbnMgPSAgICAgMTMxLjk5OTk5
ODINCg0KW3JlcG9ydGVkIGJ5IC91c3IvYmluL3RpbWUgLXYgXQ0KDQoJQ29t
bWFuZCBiZWluZyB0aW1lZDogIi4vaXBvcHQgcm9ib3RfMjAwMC5ubCINCglV
c2VyIHRpbWUgKHNlY29uZHMpOiAxMzQuMDENCglTeXN0ZW0gdGltZSAoc2Vj
b25kcyk6IDAuMzYNCglQZXJjZW50IG9mIENQVSB0aGlzIGpvYiBnb3Q6IDk5
JQ0KCUVsYXBzZWQgKHdhbGwgY2xvY2spIHRpbWUgKGg6bW06c3Mgb3IgbTpz
cyk6IDI6MTQuNDINCglBdmVyYWdlIHNoYXJlZCB0ZXh0IHNpemUgKGtieXRl
cyk6IDANCglBdmVyYWdlIHVuc2hhcmVkIGRhdGEgc2l6ZSAoa2J5dGVzKTog
MA0KCUF2ZXJhZ2Ugc3RhY2sgc2l6ZSAoa2J5dGVzKTogMA0KCUF2ZXJhZ2Ug
dG90YWwgc2l6ZSAoa2J5dGVzKTogMA0KCU1heGltdW0gcmVzaWRlbnQgc2V0
IHNpemUgKGtieXRlcyk6IDANCglBdmVyYWdlIHJlc2lkZW50IHNldCBzaXpl
IChrYnl0ZXMpOiAwDQoJTWFqb3IgKHJlcXVpcmluZyBJL08pIHBhZ2UgZmF1
bHRzOiAyOTMNCglNaW5vciAocmVjbGFpbWluZyBhIGZyYW1lKSBwYWdlIGZh
dWx0czogMjMzNTINCglWb2x1bnRhcnkgY29udGV4dCBzd2l0Y2hlczogMA0K
CUludm9sdW50YXJ5IGNvbnRleHQgc3dpdGNoZXM6IDANCglTd2FwczogMA0K
CUZpbGUgc3lzdGVtIGlucHV0czogMA0KCUZpbGUgc3lzdGVtIG91dHB1dHM6
IDANCglTb2NrZXQgbWVzc2FnZXMgc2VudDogMA0KCVNvY2tldCBtZXNzYWdl
cyByZWNlaXZlZDogMA0KCVNpZ25hbHMgZGVsaXZlcmVkOiAwDQoJUGFnZSBz
aXplIChieXRlcyk6IDQwOTYNCglFeGl0IHN0YXR1czogMA0K
---559023410-851401618-1009933243=:7513
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="two.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33L-022.0201012000431.7513@unix13.andrew.cmu.edu>
Content-Description: 
Content-Disposition: attachment; filename="two.txt"

b3V0cHV0IGZyb20gcnVubmluZyB0d28gaW1hZ2VzIHNpbXVsdGFuZW91c2x5
DQoNCltyZXBvcnRlZCBieSBkdGltZSgpXQ0KDQpDUFUgc2Vjb25kcyBzcGVu
dCBpbiBJUE9QVCBhbmQgZnVuY3Rpb24gZXZhbHVhdGlvbnMgPSAgICAgMTU3
LjcwMDAwMjQNCg0KW3JlcG9ydGVkIGJ5IC91c3IvYmluL3RpbWUgLXYgXQ0K
CUNvbW1hbmQgYmVpbmcgdGltZWQ6ICIuL2lwb3B0IHJvYm90XzIwMDAubmwi
DQoJVXNlciB0aW1lIChzZWNvbmRzKTogMTU5LjgxDQoJU3lzdGVtIHRpbWUg
KHNlY29uZHMpOiAwLjUwDQoJUGVyY2VudCBvZiBDUFUgdGhpcyBqb2IgZ290
OiA5OSUNCglFbGFwc2VkICh3YWxsIGNsb2NrKSB0aW1lIChoOm1tOnNzIG9y
IG06c3MpOiAyOjQwLjQxDQoJQXZlcmFnZSBzaGFyZWQgdGV4dCBzaXplIChr
Ynl0ZXMpOiAwDQoJQXZlcmFnZSB1bnNoYXJlZCBkYXRhIHNpemUgKGtieXRl
cyk6IDANCglBdmVyYWdlIHN0YWNrIHNpemUgKGtieXRlcyk6IDANCglBdmVy
YWdlIHRvdGFsIHNpemUgKGtieXRlcyk6IDANCglNYXhpbXVtIHJlc2lkZW50
IHNldCBzaXplIChrYnl0ZXMpOiAwDQoJQXZlcmFnZSByZXNpZGVudCBzZXQg
c2l6ZSAoa2J5dGVzKTogMA0KCU1ham9yIChyZXF1aXJpbmcgSS9PKSBwYWdl
IGZhdWx0czogMjkzDQoJTWlub3IgKHJlY2xhaW1pbmcgYSBmcmFtZSkgcGFn
ZSBmYXVsdHM6IDIzMzUyDQoJVm9sdW50YXJ5IGNvbnRleHQgc3dpdGNoZXM6
IDANCglJbnZvbHVudGFyeSBjb250ZXh0IHN3aXRjaGVzOiAwDQoJU3dhcHM6
IDANCglGaWxlIHN5c3RlbSBpbnB1dHM6IDANCglGaWxlIHN5c3RlbSBvdXRw
dXRzOiAwDQoJU29ja2V0IG1lc3NhZ2VzIHNlbnQ6IDANCglTb2NrZXQgbWVz
c2FnZXMgcmVjZWl2ZWQ6IDANCglTaWduYWxzIGRlbGl2ZXJlZDogMA0KCVBh
Z2Ugc2l6ZSAoYnl0ZXMpOiA0MDk2DQoJRXhpdCBzdGF0dXM6IDANCg==
---559023410-851401618-1009933243=:7513--
