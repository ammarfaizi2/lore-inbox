Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbUEWH5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUEWH5W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 03:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUEWH5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 03:57:22 -0400
Received: from marvin.harmless.hu ([195.70.51.173]:21972 "EHLO
	marvin.harmless.hu") by vger.kernel.org with ESMTP id S263059AbUEWH44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 03:56:56 -0400
Date: Sun, 23 May 2004 09:57:56 +0200 (CEST)
From: Gergely Czuczy <phoemix@harmless.hu>
X-X-Sender: phoemix@localhost
To: linux-kernel@vger.kernel.org
Cc: itk-sysadm@ppke.hu
Subject: Linux 2.4 VS 2.6 fork VS thread creation time test
Message-ID: <Pine.LNX.4.60.0405230914330.15840@localhost>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1740234236-1085299076=:15840"
X-HD-Virus-Scanned: by amavisd-new-20030616-p7 at harmless.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1740234236-1085299076=:15840
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everyone,

Today morning I've made a test about the thead and child process
creation(fork) time on both 2.4 and 2.6 kernels.

The test systems
================

Box A:
 - kernel: Linux 2.4.22-xfs
 - CPU: Intel P3-700 MHz (slot1)
 - Ram: 384MB SDR SDRAM

Box B:
 - kernel: Linux 2.6.6-mm5
 - CPU: Intel P4-2.6Ghz
 - Ram: 512 DDR SDRAM

Box B is a lot better, but it doesn't metter according to the test,
because the aim was to get the ratio of the two times with different
sample rates.

The sample rates
================

I've chosen a low, a middle and a higher sample rate for the test, they
was 20,128 and 255 samples.
Notice in the attached source that every child processes and threads are
terminated right after creation, and only the creation function call is
timed. It was interesting that when I've chosed a _very_ high sample rate,
about 10^8 there was a lot of failures, the kernel could only create about
4K child processes, and after this all the thread creations failed. As I
told it above all the processes are teminated right after creation, but
there were a lot of defunct processes in the system, and they were only
gone when the parent termineted.
With a few number of processes I wasn't able to go over 255 threads,
after the 255th every creation attempt simply failed.

The test outputs
================

Box A, 20 samples:
- ------------------
Fork failures: 0 (success: 20)
Avarage fork time: 0.326800 msecs
Total fork time: 6.536000 msecs
Thread failures: 0 (success: 20)
Avarage thread time: 0.075550 msecs
Total thread time: 1.511000 msecs
Avarage fork/thread ratio: 4.325612
Total fork/thread ratio: 4.325612

Box A, 128 samples:
- ------------------
Fork failures: 0 (success: 128)
Avarage fork time: 0.332773 msecs
Total fork time: 42.595000 msecs
Thread failures: 0 (success: 128)
Avarage thread time: 0.084859 msecs
Total thread time: 10.862000 msecs
Avarage fork/thread ratio: 3.921469
Total fork/thread ratio: 3.921469

Box A, 255 samples:
- -------------------
Fork failures: 0 (success: 255)
Avarage fork time: 0.344827 msecs
Total fork time: 87.931000 msecs
Thread failures: 0 (success: 255)
Avarage thread time: 0.209718 msecs
Total thread time: 53.478000 msecs
Avarage fork/thread ratio: 1.644246
Total fork/thread ratio: 1.644246

Box B, 20 samples:
- ------------------
Fork failures: 0 (success: 20)
Avarage fork time: 0.257900 msecs
Total fork time: 5.158000 msecs
Thread failures: 0 (success: 20)
Avarage thread time: 0.026850 msecs
Total thread time: 0.537000 msecs
Avarage fork/thread ratio: 9.605214
Total fork/thread ratio: 9.605214

Box B, 128 samples:
- -------------------
Fork failures: 0 (success: 128)
Avarage fork time: 0.242633 msecs
Total fork time: 31.057000 msecs
Thread failures: 0 (success: 128)
Avarage thread time: 0.025859 msecs
Total thread time: 3.310000 msecs
Avarage fork/thread ratio: 9.382779
Total fork/thread ratio: 9.382779

Box B, 255 samples:
- -------------------
Fork failures: 0 (success: 255)
Avarage fork time: 0.241678 msecs
Total fork time: 61.628000 msecs
Thread failures: 0 (success: 255)
Avarage thread time: 0.025729 msecs
Total thread time: 6.561000 msecs
Avarage fork/thread ratio: 9.393080
Total fork/thread ratio: 9.393080

Conlusion
=========

It's easy to notice that in case of 2.4 the ratios of the creation times
are converges to 1, so it depends on the load, while in case of a 2.6
kernel the ratios are mostly fix, about 9. This means that creating a new
child process takes much more time than creating a new thread.


Bye,

Gergely Czuczy
mailto: phoemix@harmless.hu
PGP: http://phoemix.harmless.hu/phoemix.pgp

"Wish a god, a star to believe in,
With the realm of king of fantasy..."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsFmObBsEN0U7BV0RAiawAJ93KmDqYwksMNGci11hOdLbr2rXWwCfdcZR
cv1WcImKLpNOfNr9pdqyfm0=
=2yxd
-----END PGP SIGNATURE-----

--8323328-1740234236-1085299076=:15840
Content-Type: TEXT/x-c++src; charset=US-ASCII; name="main.cc"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0405230957560.15840@localhost>
Content-Description: 
Content-Disposition: attachment; filename="main.cc"

LyoNCiAgVGVzdCBob3cgbXVjaCB0aW1lIGlzIG5lZWRlZCBmb3IgYSBwcm9j
ZXNzL3RocmVhZCBjcmVhdGlvbg0KICBBdXRob3I6IEdlcmdlbHkgQ3p1Y3p5
IDxwaG9lbWl4QGhhcm1sZXNzLmh1Pg0KICovDQoNCiNpbmNsdWRlIDxzdGRp
by5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5o
Pg0KI2luY2x1ZGUgPHB0aHJlYWQuaD4NCiNpbmNsdWRlIDx0aW1lLmg+DQoj
aW5jbHVkZSA8c2lnbmFsLmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQoj
aW5jbHVkZSA8c3lzL3RpbWUuaD4NCg0KDQpkb3VibGUgdGltZXZhbDJkb3Vi
bGUoc3RydWN0IHRpbWV2YWwgKl90dik7DQp2b2lkICp0aHJlYWRmdW5jKHZv
aWQgKik7DQoNCi8qDQogID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQogIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pDQogID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogKi8NCmludCBtYWlu
KGludCBhcmdjLCBjaGFyICphcmd2W10pIHsNCiAgdW5zaWduZWQgaW50IGk7
DQogIHVuc2lnbmVkIGludCBzYW1wbGVzOw0KICB1bnNpZ25lZCBpbnQgZm9y
a2ZhaWx1cmVzKDApLCB0aHJlYWRmYWlsdXJlcygwKTsNCiAgZG91YmxlIHRv
dGFsZm9ya3RpbWUoMCksdG90YWx0aHJlYWR0aW1lKDApLCBmb3JrdGltZSwg
dGhyZWFkdGltZTsNCiAgc3RydWN0IHRpbWV2YWwgYmVnaW4sZW5kLGRpZmY7
DQogIHBpZF90IGNoaWxkcGlkOw0KICBwdGhyZWFkX3QgdGhyZWFkOw0KDQog
IGlmICggYXJnYyAhPSAyICkgew0KICAgIHByaW50ZigiVXNhZ2U6XG5cdCVz
IDxudW1iZXIgb2Ygc2FtcGxlcz5cbiIsIGFyZ3ZbMF0pOw0KICAgIHJldHVy
biBFWElUX0ZBSUxVUkU7DQogIH0NCg0KICAvLyB3ZSBnZXQgdGhlIG51bWJl
ciBvZiBzYW1wbGVzIHRvIHRha2UNCiAgc2FtcGxlcyA9IGF0b2koYXJndlsx
XSk7DQoNCiAgLy8gdGVzdCB0aGUgZm9ya3MNCiAgcHJpbnRmKCJcbiIpOw0K
ICBmb3IgKCBpPTA7IGk8c2FtcGxlczsgKytpICkgew0KICAgIHByaW50Zigi
XHJGb3JrIHRlc3Q6ICV1LyV1ICglMy4yZiUlKSIsIGkrMSwgc2FtcGxlcywg
KChpKzEuMCkvc2FtcGxlcykqMTAwKTtmZmx1c2goMCk7DQoNCiAgICBnZXR0
aW1lb2ZkYXkoJmJlZ2luLCAwKTsNCiAgICBjaGlsZHBpZCA9IGZvcmsoKTsN
CiAgICBnZXR0aW1lb2ZkYXkoJmVuZCwgMCk7DQoNCiAgICBpZiAoICFjaGls
ZHBpZCApIF9leGl0KDApOw0KICAgIGlmICggY2hpbGRwaWQ9PS0xICkgKytm
b3JrZmFpbHVyZXM7DQoNCiAgICB0aW1lcnN1YigmZW5kLCAmYmVnaW4sICZk
aWZmKTsNCiAgICB0b3RhbGZvcmt0aW1lICs9IHRpbWV2YWwyZG91YmxlKCZk
aWZmKTsNCiAgICB1c2xlZXAoMSk7DQogIH0NCiAgcHJpbnRmKCJcbiIpOw0K
DQogIHVzbGVlcCgxMDAwMCk7DQoNCiAgLy8gdGVzdCB0aGUgdGhyZWFkcw0K
ICBwcmludGYoIlxuIik7DQogIGZvciAoIGk9MDsgaTxzYW1wbGVzOyArK2kg
KSB7DQogICAgaW50IHJldDsNCg0KICAgIHByaW50ZigiXHJUaHJlYWQgdGVz
dDogJXUvJXUgKCUzLjJmJSUpIiwgaSsxLCBzYW1wbGVzLCAoKGkrMS4wKS9z
YW1wbGVzKSoxMDApO2ZmbHVzaCgwKTsNCg0KICAgIGdldHRpbWVvZmRheSgm
YmVnaW4sIDApOw0KICAgIHJldCA9IHB0aHJlYWRfY3JlYXRlKCZ0aHJlYWQs
IDAsICZ0aHJlYWRmdW5jLCAwKTsNCiAgICBnZXR0aW1lb2ZkYXkoJmVuZCwg
MCk7DQoNCiAgICBpZiAoIHJldCApICsrdGhyZWFkZmFpbHVyZXM7DQoNCiAg
ICB0aW1lcnN1YigmZW5kLCAmYmVnaW4sICZkaWZmKTsNCiAgICB0b3RhbHRo
cmVhZHRpbWUgKz0gdGltZXZhbDJkb3VibGUoJmRpZmYpOw0KICAgIHVzbGVl
cCgxKTsNCiAgfQ0KICBwcmludGYoIlxuXG4iKTsNCg0KDQogIC8vIHByaW50
IHRoZSByZXN1bHRzDQogIGZvcmt0aW1lID0gdG90YWxmb3JrdGltZSAvIChz
YW1wbGVzLWZvcmtmYWlsdXJlcyk7DQogIHByaW50ZigiRm9yayBmYWlsdXJl
czogJXUgKHN1Y2NlczogJXUpXG4iLCBmb3JrZmFpbHVyZXMsIHNhbXBsZXMt
Zm9ya2ZhaWx1cmVzKTsNCiAgcHJpbnRmKCJBdmFyYWdlIGZvcmsgdGltZTog
JTVmIG1zZWNzXG4iLCBmb3JrdGltZSk7DQogIHByaW50ZigiVG90YWwgZm9y
ayB0aW1lOiAlNWYgbXNlY3NcbiIsIHRvdGFsZm9ya3RpbWUpOw0KICB0aHJl
YWR0aW1lID0gdG90YWx0aHJlYWR0aW1lIC8gKHNhbXBsZXMtdGhyZWFkZmFp
bHVyZXMpOw0KICBwcmludGYoIlRocmVhZCBmYWlsdXJlczogJXUgKHN1Y2Nl
c3M6ICV1KVxuIiwgdGhyZWFkZmFpbHVyZXMsIHNhbXBsZXMtdGhyZWFkZmFp
bHVyZXMpOw0KICBwcmludGYoIkF2YXJhZ2UgdGhyZWFkIHRpbWU6ICU1ZiBt
c2Vjc1xuIiwgdGhyZWFkdGltZSk7DQogIHByaW50ZigiVG90YWwgdGhyZWFk
IHRpbWU6ICU1ZiBtc2Vjc1xuIiwgdG90YWx0aHJlYWR0aW1lKTsNCiAgcHJp
bnRmKCJBdmFyYWdlIGZvcmsvdGhyZWFkIHJhdGlvOiAlMmZcbiIsIGZvcmt0
aW1lL3RocmVhZHRpbWUpOw0KICBwcmludGYoIlRvdGFsIGZvcmsvdGhyZWFk
IHJhdGlvOiAlMmZcbiIsIHRvdGFsZm9ya3RpbWUvdG90YWx0aHJlYWR0aW1l
KTsNCg0KICByZXR1cm4gRVhJVF9TVUNDRVNTOw0KfQ0KDQovKg0KICA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQogIHZvaWQgKnRocmVhZGZ1bmMo
dm9pZCAqX2FyZykNCiAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
ICovDQp2b2lkICp0aHJlYWRmdW5jKHZvaWQgKikgew0KICBwdGhyZWFkX2V4
aXQoMCk7DQogIHJldHVybiAwOw0KfQ0KDQovKg0KICA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgZG91YmxlIHRpbWV2
YWwyZG91YmxlKHN0cnVjdCB0aW1ldmFsICpfdHYpDQogID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KICovDQpkb3VibGUg
dGltZXZhbDJkb3VibGUoc3RydWN0IHRpbWV2YWwgKl90dikgew0KICBkb3Vi
bGUgcmV0Ow0KICByZXQgPSBfdHYtPnR2X3VzZWM7DQogIHJldCAvPSAxMDAw
MDAwOw0KICByZXQgKz0gX3R2LT50dl9zZWM7DQogIHJldCAqPSAxMDAwOw0K
ICByZXR1cm4gcmV0Ow0KfQ0K

--8323328-1740234236-1085299076=:15840--
