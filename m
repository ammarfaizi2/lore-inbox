Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289135AbSAWEKO>; Tue, 22 Jan 2002 23:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289652AbSAWEKE>; Tue, 22 Jan 2002 23:10:04 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:11915 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S289135AbSAWEJr>; Tue, 22 Jan 2002 23:09:47 -0500
Date: Wed, 23 Jan 2002 07:09:27 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre3 (resending with .config info) -- pcilynx.c:638: In function `mem_open': invalid operands to binary &
Message-Id: <20020123070927.3cf792e5.johnpol@2ka.mipt.ru>
In-Reply-To: <1011750497.24309.27.camel@stomata.megapathdsl.net>
In-Reply-To: <1011750497.24309.27.camel@stomata.megapathdsl.net>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__23_Jan_2002_07:09:27_+0300_08325850"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__23_Jan_2002_07:09:27_+0300_08325850
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 22 Jan 2002 17:48:17 -0800
Miles Lane <miles@megapathdsl.net> wrote:

> Oops.  Forgot to include the relevant .config info last time.
> Here it is.
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
> pcilynx.o pcilynx.c pcilynx.c: In function `mem_open':
> pcilynx.c:638: invalid operands to binary &
> pcilynx.c:650: `num_of_cards' undeclared (first use in this function)
> pcilynx.c:650: (Each undeclared identifier is reported only once
> pcilynx.c:650: for each function it appears in.)
> pcilynx.c:650: `cards' undeclared (first use in this function)
> pcilynx.c: In function `aux_poll':
> pcilynx.c:721: `cards' undeclared (first use in this function)
> make[2]: *** [pcilynx.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'
> 
> CONFIG_IEEE1394=m
> CONFIG_IEEE1394_PCILYNX=m
> CONFIG_IEEE1394_PCILYNX_LOCALRAM=y
> CONFIG_IEEE1394_PCILYNX_PORTS=y

Try this patch, but it is given WITHOUT ANY WARRANTY.
I even cann't test to compile it.
And there is not ieee card here.
So, it was wrote with luck and common sense.
I hope it will help you.

P.S. Here is also patch for video1394 and remap_page_range.

P.P.S. If this is full bullshit... then i apologize and go learning Linux
kernel again...

	Evgeniy Polyakov ( s0mbre ).


--Multipart_Wed__23_Jan_2002_07:09:27_+0300_08325850
Content-Type: application/octet-stream;
 name="ieee1394_video1394.patch"
Content-Disposition: attachment;
 filename="ieee1394_video1394.patch"
Content-Transfer-Encoding: base64

LS0tIC4vZHJpdmVycy9pZWVlMTM5NC92aWRlbzEzOTQuY34JVHVlIEphbiAyMiAwNToxMTowOCAy
MDAyCisrKyAuL2RyaXZlcnMvaWVlZTEzOTQvdmlkZW8xMzk0LmMJV2VkIEphbiAyMyAwNzowNDo1
OCAyMDAyCkBAIC04NDQsOCArODQ0LDkgQEAKIAlyZWdfd3JpdGUob2hjaSwgT0hDSTEzOTRfSXNv
WG1pdEludE1hc2tTZXQsIDE8PGQtPmN0eCk7CiB9CiAKLXN0YXRpYyBpbnQgZG9faXNvX21tYXAo
c3RydWN0IHRpX29oY2kgKm9oY2ksIHN0cnVjdCBkbWFfaXNvX2N0eCAqZCwgCi0JCSAgICAgICBj
b25zdCBjaGFyICphZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkKK3N0YXRpYyBpbnQgZG9faXNvX21t
YXAoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHN0cnVjdCB0aV9vaGNpICpvaGNpLCAKKwkJ
CXN0cnVjdCBkbWFfaXNvX2N0eCAqZCwgCisJCSAJY29uc3QgY2hhciAqYWRyLCB1bnNpZ25lZCBs
b25nIHNpemUpCiB7CiAgICAgICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQ9KHVuc2lnbmVkIGxvbmcp
IGFkcjsKICAgICAgICAgdW5zaWduZWQgbG9uZyBwYWdlLHBvczsKQEAgLTg2NSw3ICs4NjYsNyBA
QAogICAgICAgICBwb3M9KHVuc2lnbmVkIGxvbmcpIGQtPmJ1ZjsKICAgICAgICAgd2hpbGUgKHNp
emUgPiAwKSB7CiAgICAgICAgICAgICAgICAgcGFnZSA9IGt2aXJ0X3RvX3BhKHBvcyk7Ci0gICAg
ICAgICAgICAgICAgaWYgKHJlbWFwX3BhZ2VfcmFuZ2Uoc3RhcnQsIHBhZ2UsIFBBR0VfU0laRSwg
UEFHRV9TSEFSRUQpKQorICAgICAgICAgICAgICAgIGlmIChyZW1hcF9wYWdlX3JhbmdlKHZtYSwg
c3RhcnQsIHBhZ2UsIFBBR0VfU0laRSwgUEFHRV9TSEFSRUQpKQogICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FQUdBSU47CiAgICAgICAgICAgICAgICAgc3RhcnQrPVBBR0VfU0laRTsK
ICAgICAgICAgICAgICAgICBwb3MrPVBBR0VfU0laRTsKQEAgLTE0MDYsNyArMTQwNyw3IEBACiAJ
aWYgKHZpZGVvLT5jdXJyZW50X2N0eCA9PSBOVUxMKSB7CiAJCVBSSU5UKEtFUk5fRVJSLCBvaGNp
LT5pZCwgIkN1cnJlbnQgaXNvIGNvbnRleHQgbm90IHNldCIpOwogCX0gZWxzZQotCQlyZXMgPSBk
b19pc29fbW1hcChvaGNpLCB2aWRlby0+Y3VycmVudF9jdHgsIAorCQlyZXMgPSBkb19pc29fbW1h
cCh2bWEsIG9oY2ksIHZpZGVvLT5jdXJyZW50X2N0eCwgCiAJCQkgICAoY2hhciAqKXZtYS0+dm1f
c3RhcnQsIAogCQkJICAgKHVuc2lnbmVkIGxvbmcpKHZtYS0+dm1fZW5kLXZtYS0+dm1fc3RhcnQp
KTsKIAl1bmxvY2tfa2VybmVsKCk7Cg==

--Multipart_Wed__23_Jan_2002_07:09:27_+0300_08325850
Content-Type: application/octet-stream;
 name="ieee1394_pcilynx.patch"
Content-Disposition: attachment;
 filename="ieee1394_pcilynx.patch"
Content-Transfer-Encoding: base64

LS0tIC90bXAvcGNpbHlueC5jCVdlZCBKYW4gMjMgMDU6NTQ6MzggMjAwMgorKysgLi9wY2lseW54
LmMJV2VkIEphbiAyMyAwNjo0OTo1MCAyMDAyCkBAIC01NSw5ICs1NSwxNSBAQAogI2RlZmluZSBQ
UklOVEQobGV2ZWwsIGNhcmQsIGZtdCwgYXJncy4uLikgZG8ge30gd2hpbGUgKDApCiAjZW5kaWYK
IAorI2RlZmluZSBNQVhfTlVNX09GX0NBUkRTCTEwIC8qIAorCQkJCSAgICAqICBIb3cgZG8geW91
IHRoaW5rLCAKKwkJCQkgICAgKiBjYW4gYW55b25lIGhhcyBzdWNoIGFtb3VudCBvZiBjYXJkcyAK
KwkJCQkgICAgKiBpbiBvbmUgY29tcHV0ZXI/IAorCQkJCSAgICAqLwogCiBzdGF0aWMgc3RydWN0
IGhwc2JfaG9zdF9kcml2ZXIgKmx5bnhfZHJpdmVyOwotc3RhdGljIHVuc2lnbmVkIGludCBjYXJk
X2lkOworc3RhdGljIHVuc2lnbmVkIGludCBjYXJkX2lkLCBudW1fb2ZfY2FyZHM7CitzdHJ1Y3Qg
dGlfbHlueCBjYXJkc1tNQVhfTlVNX09GX0NBUkRTXTsKIAogLyoKICAqIFBDTCBoYW5kbGluZyBm
dW5jdGlvbnMuCkBAIC0xNTA5LDYgKzE1MTUsMTEgQEAKIAogICAgICAgICBocHNiX2FkZF9ob3N0
KGhvc3QpOwogICAgICAgICBseW54LT5zdGF0ZSA9IGlzX2hvc3Q7CisJCisJaWYgKG51bV9vZl9j
YXJkcyA8IE1BWF9OVU1fT0ZfQ0FSRFMpCisJCWNhcmRzW251bV9vZl9jYXJkcysrXSA9IGhvc3Qt
Pmhvc3RkYXRhOworCWVsc2UKKwkJRkFJTCgiVG9vIG1hbnkgY2FyZHNbICVkIF0uLi4gSW1wb3Nz
aWJsZS4uLlxuIiwgbnVtX29mX2NhcmRzKTsKIAogICAgICAgICByZXR1cm4gMDsKICN1bmRlZiBG
QUlMCg==

--Multipart_Wed__23_Jan_2002_07:09:27_+0300_08325850--
