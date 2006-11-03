Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWKCIXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWKCIXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWKCIXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:23:40 -0500
Received: from pop-siberian.atl.sa.earthlink.net ([207.69.195.71]:17537 "EHLO
	pop-siberian.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751445AbWKCIXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:23:39 -0500
Date: Fri, 3 Nov 2006 03:23:35 -0500 (EST)
From: Brent Baccala <cosine@freesoft.org>
X-X-Sender: baccala@debian.freesoft.org
To: linux-kernel@vger.kernel.org
Subject: async I/O seems to be blocking on 2.6.15
Message-ID: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-619161319-1162542215=:25096"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-619161319-1162542215=:25096
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello -

I'm running 2.6.15 (Debian) on a Pentium M laptop, PCI attached ext3
filesystem.

I'm writing my first asynchronous I/O program, and for a while I
thought I was really doing something wrong, but more and more I'm
starting to conclude that the problem might be in the kernel.

Basically, I've narrowed things down to a test program which opens a
large (700 MB) file in O_DIRECT mode and fires off 100 one MB async
reads for the first 100 MB of data.  The enqueues take about 5 seconds
to complete, which is also about the amount of time this disk needs to
read 100 MB, so I suspect that it's blocking.

I've gotten the POSIX AIO interface at least tolerably running using
the GLIBC thread-based implementation, but I really want the native
interface working.

I whittled the test program down to use system calls instead of the
POSIX AIO library, and I'm attaching a copy.  You put a big file at
'testfile' (it just reads it) and run the program:


baccala@debian ~/src/endgame$ time ./testaio
Enqueues starting
Enqueues complete

real    0m5.327s
user    0m0.004s
sys     0m0.740s
baccala@debian ~/src/endgame$


Of that five seconds, it's almost all spent between the two "enqueues"
messages.

If anybody can shed any light on this, I'd appreciate your feedback
direct to cosine@freesoft.org (I don't read the list).

Thank you.



 					-bwb

 					Brent Baccala
 					cosine@freesoft.org
--8323329-619161319-1162542215=:25096
Content-Type: TEXT/x-csrc; charset=US-ASCII; name=testaio.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0611030323350.25096@debian.freesoft.org>
Content-Description: 
Content-Disposition: attachment; filename=testaio.c

DQojZGVmaW5lIF9HTlVfU09VUkNFCQkvKiB0byBnZXQgT19ESVJFQ1QgKi8N
Cg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQoj
aW5jbHVkZSA8c3RyaW5nLmg+CS8qIGZvciBtZW1zZXQoKSAqLw0KI2luY2x1
ZGUgPHVuaXN0ZC5oPgkvKiBmb3IgX1BDX1JFQ19YRkVSX0FMSUdOICovDQoj
aW5jbHVkZSA8YXNtL3VuaXN0ZC5oPg0KI2luY2x1ZGUgPGZjbnRsLmg+DQoj
aW5jbHVkZSA8bGludXgvYWlvX2FiaS5oPg0KI2luY2x1ZGUgPGVycm5vLmg+
DQoNCl9zeXNjYWxsMihpbnQsIGlvX3NldHVwLCBpbnQsIG1heGV2ZW50cywg
YWlvX2NvbnRleHRfdCAqLCBjdHhwKQ0KX3N5c2NhbGwzKGludCwgaW9fc3Vi
bWl0LCBhaW9fY29udGV4dF90LCBjdHgsIGxvbmcsIG5yLCBzdHJ1Y3QgaW9j
YiAqKiwgaW9jYnMpDQoNCiNkZWZpbmUgTlVNQUlPUyAxMDANCg0KI2RlZmlu
ZSBCVUZGRVJfQllURVMgKDE8PDIwKQ0KDQpzdHJ1Y3QgaW9jYiBpb2NiW05V
TUFJT1NdOw0Kdm9pZCAqYnVmZmVyW05VTUFJT1NdOw0KDQphaW9fY29udGV4
dF90IGFpb19kZWZhdWx0X2NvbnRleHQ7DQoNCm1haW4oKQ0Kew0KICAgIGlu
dCBmZDsNCiAgICBpbnQgaTsNCiAgICBpbnQgYWxpZ25tZW50Ow0KICAgIHN0
cnVjdCBpb2NiICogaW9jYnBbMV07DQoNCiAgICBmZCA9IG9wZW4oInRlc3Rm
aWxlIiwgT19SRE9OTFkgfCBPX0RJUkVDVCk7DQogICAgYWxpZ25tZW50ID0g
ZnBhdGhjb25mKGZkLCBfUENfUkVDX1hGRVJfQUxJR04pOw0KDQogICAgZm9y
IChpPTA7IGk8TlVNQUlPUzsgaSsrKSB7DQoJaWYgKHBvc2l4X21lbWFsaWdu
KCZidWZmZXJbaV0sIGFsaWdubWVudCwgQlVGRkVSX0JZVEVTKSAhPSAwKSB7
DQoJICAgIGZwcmludGYoc3RkZXJyLCAiQ2FuJ3QgcG9zaXhfbWVtYWxpZ25c
biIpOw0KCX0NCiAgICB9DQoNCiAgICBpb19zZXR1cCgxMDI0LCAmYWlvX2Rl
ZmF1bHRfY29udGV4dCk7DQoNCiAgICBmcHJpbnRmKHN0ZGVyciwgIkVucXVl
dWVzIHN0YXJ0aW5nXG4iKTsNCg0KICAgIGZvciAoaT0wOyBpPE5VTUFJT1M7
IGkrKykgew0KDQoJbWVtc2V0KCZpb2NiW2ldLCAwLCBzaXplb2Yoc3RydWN0
IGlvY2IpKTsNCg0KCWlvY2JbaV0uYWlvX2xpb19vcGNvZGUgPSBJT0NCX0NN
RF9QUkVBRDsNCglpb2NiW2ldLmFpb19maWxkZXMgPSBmZDsNCglpb2NiW2ld
LmFpb19idWYgPSAodW5zaWduZWQgbG9uZykgYnVmZmVyW2ldOw0KCWlvY2Jb
aV0uYWlvX25ieXRlcyA9IEJVRkZFUl9CWVRFUzsNCglpb2NiW2ldLmFpb19v
ZmZzZXQgPSBCVUZGRVJfQllURVMgKiBpOw0KCS8qIGFpb2NiW2ldLmFpb19v
ZmZzZXQgPSAwOyAqLw0KDQoJaW9jYnBbMF0gPSAmaW9jYltpXTsNCglpZiAo
aW9fc3VibWl0KGFpb19kZWZhdWx0X2NvbnRleHQsIDEsIGlvY2JwKSAhPSAx
KSB7DQoJICAgIHBlcnJvcigiIik7DQoJICAgIGZwcmludGYoc3RkZXJyLCAi
Q2FuJ3QgZW5xdWV1ZSBhaW9fcmVhZCAlZFxuIiwgaSk7DQoJfQ0KICAgIH0N
Cg0KICAgIGZwcmludGYoc3RkZXJyLCAiRW5xdWV1ZXMgY29tcGxldGVcbiIp
Ow0KfQ0K

--8323329-619161319-1162542215=:25096--
