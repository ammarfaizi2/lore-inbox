Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274684AbRJFOoi>; Sat, 6 Oct 2001 10:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275041AbRJFOo2>; Sat, 6 Oct 2001 10:44:28 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:270 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S274684AbRJFOoV>; Sat, 6 Oct 2001 10:44:21 -0400
Date: Sat, 6 Oct 2001 16:44:43 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.4.33L.0110061103000.12110-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.3.96.1011006164044.29342B-200000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-741352904-1002379483=:29342"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1908636959-741352904-1002379483=:29342
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 6 Oct 2001, Rik van Riel wrote:

> On Sat, 6 Oct 2001, Mikulas Patocka wrote:
> 
> > Buddy allocator is broken - kill it. Or at least do not misuse it for
> > anything except kernel or driver initialization.
> 
> Please send patches to get rid of the buddy allocator while
> still making it possible to allocate contiguous chunks of
> memory.
> 
> If you have any idea on how to fix things, this would be a
> good time to let us know.

Here goes the fix. (note that I didn't try to compile it so there may be
bugs, but you see the point). 

kmalloc should be fixed too (used badly for example in select.c - and yes
- I have seen real world bugreports for poll randomly failing with
ENOMEM), but it will be hard to audit all drivers that they do not try to
use dma on kmallocated memory. 

Mikulas

--1908636959-741352904-1002379483=:29342
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="vmalloc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1011006164443.29342C@artax.karlin.mff.cuni.cz>
Content-Description: 

ZGlmZiAtdSAtciBsaW51eC1vcmlnL2luY2x1ZGUvYXNtLWkzODYvcHJvY2Vz
c29yLmggbGludXgvaW5jbHVkZS9hc20taTM4Ni9wcm9jZXNzb3IuaA0KLS0t
IGxpbnV4LW9yaWcvaW5jbHVkZS9hc20taTM4Ni9wcm9jZXNzb3IuaAlTYXQg
T2N0ICA2IDE2OjIxOjUwIDIwMDENCisrKyBsaW51eC9pbmNsdWRlL2FzbS1p
Mzg2L3Byb2Nlc3Nvci5oCVNhdCBPY3QgIDYgMTY6MzE6MTUgMjAwMQ0KQEAg
LTQ0OCw3ICs0NDgsNyBAQA0KICNkZWZpbmUgS1NUS19FU1AodHNrKQkoKCh1
bnNpZ25lZCBsb25nICopKDQwOTYrKHVuc2lnbmVkIGxvbmcpKHRzaykpKVsx
MDIyXSkNCiANCiAjZGVmaW5lIFRIUkVBRF9TSVpFICgyKlBBR0VfU0laRSkN
Ci0jZGVmaW5lIGFsbG9jX3Rhc2tfc3RydWN0KCkgKChzdHJ1Y3QgdGFza19z
dHJ1Y3QgKikgX19nZXRfZnJlZV9wYWdlcyhHRlBfS0VSTkVMLDEpKQ0KKyNk
ZWZpbmUgYWxsb2NfdGFza19zdHJ1Y3QoKSAoKHN0cnVjdCB0YXNrX3N0cnVj
dCAqKSBfX2dldF9mcmVlX3BhZ2VzKEdGUF9LRVJORUwgfCBfX0dGUF9WTUFM
TE9DLDEpKQ0KICNkZWZpbmUgZnJlZV90YXNrX3N0cnVjdChwKSBmcmVlX3Bh
Z2VzKCh1bnNpZ25lZCBsb25nKSAocCksIDEpDQogI2RlZmluZSBnZXRfdGFz
a19zdHJ1Y3QodHNrKSAgICAgIGF0b21pY19pbmMoJnZpcnRfdG9fcGFnZSh0
c2spLT5jb3VudCkNCiANCmRpZmYgLXUgLXIgbGludXgtb3JpZy9pbmNsdWRl
L2xpbnV4L21tLmggbGludXgvaW5jbHVkZS9saW51eC9tbS5oDQotLS0gbGlu
dXgtb3JpZy9pbmNsdWRlL2xpbnV4L21tLmgJU2F0IE9jdCAgNiAxNjoyMTo1
OSAyMDAxDQorKysgbGludXgvaW5jbHVkZS9saW51eC9tbS5oCVNhdCBPY3Qg
IDYgMTY6Mjg6MTIgMjAwMQ0KQEAgLTU1MCw2ICs1NTAsNyBAQA0KICNkZWZp
bmUgX19HRlBfSU8JMHg0MAkvKiBDYW4gc3RhcnQgbG93IG1lbW9yeSBwaHlz
aWNhbCBJTz8gKi8NCiAjZGVmaW5lIF9fR0ZQX0hJR0hJTwkweDgwCS8qIENh
biBzdGFydCBoaWdoIG1lbSBwaHlzaWNhbCBJTz8gKi8NCiAjZGVmaW5lIF9f
R0ZQX0ZTCTB4MTAwCS8qIENhbiBjYWxsIGRvd24gdG8gbG93LWxldmVsIEZT
PyAqLw0KKyNkZWZpbmUgX19HRlBfVk1BTExPQwkweDIwMAkvKiBDYW4gdm1h
bGxvYyBwYWdlcyBpZiBidWRkeSBhbGxvY2F0b3IgZmFpbHMgKi8NCiANCiAj
ZGVmaW5lIEdGUF9OT0hJR0hJTwkoX19HRlBfSElHSCB8IF9fR0ZQX1dBSVQg
fCBfX0dGUF9JTykNCiAjZGVmaW5lIEdGUF9OT0lPCShfX0dGUF9ISUdIIHwg
X19HRlBfV0FJVCkNCmRpZmYgLXUgLXIgbGludXgtb3JpZy9tbS9wYWdlX2Fs
bG9jLmMgbGludXgvbW0vcGFnZV9hbGxvYy5jDQotLS0gbGludXgtb3JpZy9t
bS9wYWdlX2FsbG9jLmMJU2F0IE9jdCAgNiAxNjoyMTo0NyAyMDAxDQorKysg
bGludXgvbW0vcGFnZV9hbGxvYy5jCVNhdCBPY3QgIDYgMTY6MzY6MjggMjAw
MQ0KQEAgLTE4LDYgKzE4LDcgQEANCiAjaW5jbHVkZSA8bGludXgvYm9vdG1l
bS5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxp
bnV4L2NvbXBpbGVyLmg+DQorI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4N
CiANCiBpbnQgbnJfc3dhcF9wYWdlczsNCiBpbnQgbnJfYWN0aXZlX3BhZ2Vz
Ow0KQEAgLTQyMSw5ICs0MjIsOSBAQA0KIAlzdHJ1Y3QgcGFnZSAqIHBhZ2U7
DQogDQogCXBhZ2UgPSBhbGxvY19wYWdlcyhnZnBfbWFzaywgb3JkZXIpOw0K
LQlpZiAoIXBhZ2UpDQotCQlyZXR1cm4gMDsNCi0JcmV0dXJuICh1bnNpZ25l
ZCBsb25nKSBwYWdlX2FkZHJlc3MocGFnZSk7DQorCWlmIChwYWdlKSByZXR1
cm4gKHVuc2lnbmVkIGxvbmcpIHBhZ2VfYWRkcmVzcyhwYWdlKTsNCisJaWYg
KGdmcF9tYXNrICYgX19HRlBfVk1BTExPQykgcmV0dXJuICh1bnNpZ25lZCBs
b25nKV9fdm1hbGxvYyhQQUdFX1NJWkUgPDwgb3JkZXIsIGdmcF9tYXNrLCBQ
QUdFX0tFUk5FTCk7DQorCXJldHVybiAwOw0KIH0NCiANCiB1bnNpZ25lZCBs
b25nIGdldF96ZXJvZWRfcGFnZSh1bnNpZ25lZCBpbnQgZ2ZwX21hc2spDQpA
QCAtNDQ3LDYgKzQ0OCwxMCBAQA0KIA0KIHZvaWQgZnJlZV9wYWdlcyh1bnNp
Z25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGludCBvcmRlcikNCiB7DQorCWlm
IChhZGRyID49IFZNQUxMT0NfU1RBUlQgJiYgYWRkciA8IFZNQUxMT0NfRU5E
KSB7DQorCQl2ZnJlZSgodm9pZCAqKWFkZHIpOw0KKwkJcmV0dXJuOw0KKwl9
DQogCWlmIChhZGRyICE9IDApDQogCQlfX2ZyZWVfcGFnZXModmlydF90b19w
YWdlKGFkZHIpLCBvcmRlcik7DQogfQ0K
--1908636959-741352904-1002379483=:29342--
