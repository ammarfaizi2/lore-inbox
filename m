Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUITK0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUITK0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 06:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUITK0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:26:31 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:25308 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S266195AbUITK0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:26:05 -0400
Date: Mon, 20 Sep 2004 20:26:41 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@magvis2.maths.usyd.edu.au
To: jonathan@jonmasters.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <Pine.LNX.4.58.0409200815420.3644@fb07-calculator.math.uni-giessen.de>
Message-Id: <Pine.LNX.4.58.0409202020370.5797@magvis2.maths.usyd.edu.au>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> 
 <200409161528.19409.andrew@walrond.org> 
 <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de> 
 <200409161619.28742.andrew@walrond.org> 
 <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de> 
 <Pine.LNX.4.58.0409190007530.31971@fb07-calculator.math.uni-giessen.de> 
 <35fb2e59040919130154966337@mail.gmail.com> 
 <Pine.LNX.4.58.0409200737010.3644@fb07-calculator.math.uni-giessen.de>
 <35fb2e5904091915007c02c4b8@mail.gmail.com>
 <Pine.LNX.4.58.0409200815420.3644@fb07-calculator.math.uni-giessen.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811577-1807617825-1095676001=:5797"
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811577-1807617825-1095676001=:5797
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 20 Sep 2004, Sergei Haller (SH) wrote:

SH> On Sun, 19 Sep 2004, Jon Masters (JM) wrote:
SH> 
SH> JM> On Mon, 20 Sep 2004 07:47:20 +1000 (EST), Sergei Haller 
SH> JM> 
SH> JM> > I guess I should write a simple C-program using malloc or something to
SH> JM> > reproduce the crash in the simplest possible way, shouldn't I?


here we go again. that's the program I wrote:
--------------------------------------------------------------
#include <stdlib.h>

int main(int argc, char **argv) {
     unsigned long long int         bytes;
     char *mem;

     if (argc < 2)
          bytes = 0x40000000; // 1gb
     else
          bytes = strtoll(argv[1], NULL, 10);

     printf("allocate %llu: ", bytes);

     if (mem = malloc(bytes))
     {
          printf("ok\n");
          printf("set them to 0... ");

          memset(mem,0,bytes);

          printf("done\n");

     }
     else
          printf("not ok\n");

     return 0;
}
--------------------------------------------------------------

and that's the log:

fang ~sergei> ./memtest 10000
allocate 10000: ok
set them to 0... done
fang ~sergei> ./memtest 100000
allocate 100000: ok
set them to 0... done
fang ~sergei> ./memtest 1000000
allocate 1000000: ok
set them to 0... done
fang ~sergei> ./memtest 10000000
allocate 10000000: ok
set them to 0... done
fang ~sergei> ./memtest 100000000
allocate 100000000: ok
set them to 0... done
fang ~sergei> ./memtest 1000000000
allocate 1000000000: ok

Message from syslogd@fang at Mon Sep 20 18:03:16 2004 ...
fang kernel: Oops: 0000 [1] PREEMPT SMP


Attached is the full OOPS excerpt from /var/log/messages


        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
---1463811577-1807617825-1095676001=:5797
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=messages
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0409202026410.5797@magvis2.maths.usyd.edu.au>
Content-Description: 
Content-Disposition: attachment; filename=messages

U2VwIDIwIDE4OjAzOjE2IGZhbmcga2VybmVsOiBVbmFibGUgdG8gaGFuZGxl
IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgMDAwMDAwMDAw
MDAwMGU3MCBSSVA6IA0KU2VwIDIwIDE4OjAzOjE2IGZhbmcga2VybmVsOiA8
ZmZmZmZmZmY4MDE2YThlMT57cHRlX2FsbG9jX21hcCsxOTN9DQpTZXAgMjAg
MTg6MDM6MTYgZmFuZyBrZXJuZWw6IFBNTDQgMTNmN2EwMDY3IFBHRCAxM2I0
MzkwNjcgUE1EIDAgDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6IE9v
cHM6IDAwMDAgWzFdIFBSRUVNUFQgU01QIA0KU2VwIDIwIDE4OjAzOjE2IGZh
bmcga2VybmVsOiBDUFUgMSANClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5l
bDogTW9kdWxlcyBsaW5rZWQgaW46IHNnIGFmX3BhY2tldCByYXcgaWRlX2Zs
b3BweSBpZGVfdGFwZSBpZGVfY2QgZmxvcHB5IGlwdF9UT1MgaXB0X1JFSkVD
VCBpcHRfTE9HIGlwdF9zdGF0ZSBpcF9uYXRfaXJjIGlwX25hdF90ZnRwIGlw
X25hdF9mdHAgaXBfY29ubnRyYWNrX2lyYyBpcF9jb25udHJhY2tfdGZ0cCBp
cF9jb25udHJhY2tfZnRwIGlwdF9tdWx0aXBvcnQgaXB0X2Nvbm50cmFjayBp
cHRhYmxlX2ZpbHRlciBpcHRhYmxlX21hbmdsZSBpcHRhYmxlX25hdCBpcF9j
b25udHJhY2sgaXBfdGFibGVzIG9oY2kxMzk0IGllZWUxMzk0IHJ0Yw0KU2Vw
IDIwIDE4OjAzOjE2IGZhbmcga2VybmVsOiBQaWQ6IDMyNjQsIGNvbW06IG1l
bXRlc3QgTm90IHRhaW50ZWQgMi42LjguMQ0KU2VwIDIwIDE4OjAzOjE2IGZh
bmcga2VybmVsOiBSSVA6IDAwMTA6WzxmZmZmZmZmZjgwMTZhOGUxPl0gPGZm
ZmZmZmZmODAxNmE4ZTE+e3B0ZV9hbGxvY19tYXArMTkzfQ0KU2VwIDIwIDE4
OjAzOjE2IGZhbmcga2VybmVsOiBSU1A6IDAwMDA6MDAwMDAxMDEzYmM3ZGRj
OCAgRUZMQUdTOiAwMDAxMDIxMw0KU2VwIDIwIDE4OjAzOjE2IGZhbmcga2Vy
bmVsOiBSQVg6IGZmZmZmZmZmN2ZmZmZmZmYgUkJYOiAwMDAwMDAyYWM3MDAw
MDAwIFJDWDogMDAwMDAwMDAwMDAwMDAxOA0KU2VwIDIwIDE4OjAzOjE2IGZh
bmcga2VybmVsOiBSRFg6IDAwMDAwMTAxMDljOTcwMDAgUlNJOiAwMDAwMDAw
MDAwMDAwMDAwIFJESTogMDAwMDAxMDEwOWM5ODAwMA0KU2VwIDIwIDE4OjAz
OjE2IGZhbmcga2VybmVsOiBSQlA6IDAwMDAwMTAxM2YwMGQwMDAgUjA4OiAw
MDAwMDEwMDAwMDBlMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMA0KU2VwIDIw
IDE4OjAzOjE2IGZhbmcga2VybmVsOiBSMTA6IDAwMDAwMDJhOTU2NmNhODgg
UjExOiAwMDAwMDAyYTk1NmYwODIwIFIxMjogMDAwMDAwMDAwMDAwMDAwMA0K
U2VwIDIwIDE4OjAzOjE2IGZhbmcga2VybmVsOiBSMTM6IDAwMDAwMTAxMTBj
NWUxYzAgUjE0OiAwMDAwMDEwMTEwYzVlMWMwIFIxNTogMDAwMDAxMDEzZWMx
ZWRiMA0KU2VwIDIwIDE4OjAzOjE2IGZhbmcga2VybmVsOiBGUzogIDAwMDAw
MDJhOTU4YmY0YzAoMDAwMCkgR1M6ZmZmZmZmZmY4MDZiYmM0MCgwMDAwKSBr
bmxHUzowMDAwMDAwMDAwMDAwMDAwDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBr
ZXJuZWw6IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAw
MDAwODAwNTAwM2INClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5lbDogQ1Iy
OiAwMDAwMDAwMDAwMDAwZTcwIENSMzogMDAwMDAwMDEzZmY5YTAwMCBDUjQ6
IDAwMDAwMDAwMDAwMDA2ZTANClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5l
bDogUHJvY2VzcyBtZW10ZXN0IChwaWQ6IDMyNjQsIHRocmVhZGluZm8gMDAw
MDAxMDEzYmM3YzAwMCwgdGFzayAwMDAwMDEwMTNlYzFlZGIwKQ0KU2VwIDIw
IDE4OjAzOjE2IGZhbmcga2VybmVsOiBTdGFjazogMDAwMDAxMDEzZjAwZDAw
MCAwMDAwMDEwMTNmN2EwNTU4IDAwMDAwMTAxM2YwMGQwMDAgMDAwMDAwMmFj
NzAwMDAwMCANClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5lbDogICAgICAg
IDAwMDAwMTAxM2JjN2RmNTggZmZmZmZmZmY4MDE2YWIxMiAwMDAwMDAyYTk1
NmYwODIwIDAwMDAwMDJhOTU2NmNhODggDQpTZXAgMjAgMTg6MDM6MTYgZmFu
ZyBrZXJuZWw6ICAgICAgICAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAw
MDAwMDAgDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6IENhbGwgVHJh
Y2U6PGZmZmZmZmZmODAxNmFiMTI+e2hhbmRsZV9tbV9mYXVsdCsyNTh9IDxm
ZmZmZmZmZjgwMTIzMTc0Pntkb19wYWdlX2ZhdWx0KzQ1Mn0gDQpTZXAgMjAg
MTg6MDM6MTYgZmFuZyBrZXJuZWw6ICAgICAgICA8ZmZmZmZmZmY4MDRjMGIz
Yj57c2NoZWR1bGUrMjE5fSA8ZmZmZmZmZmY4MDMzZGI0OT57dHR5X3dyaXRl
Kzc3N30gDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6ICAgICAgICA8
ZmZmZmZmZmY4MDExMTM2MT57ZXJyb3JfZXhpdCswfSANClNlcCAyMCAxODow
MzoxNiBmYW5nIGtlcm5lbDogDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJu
ZWw6IENvZGU6IDQ4IDhiIDhlIDcwIDBlIDAwIDAwIDc2IDA3IGI4IDAwIDAw
IDAwIDgwIGViIDBhIDQ4IGI4IDAwIDAwIA0KU2VwIDIwIDE4OjAzOjE2IGZh
bmcga2VybmVsOiBSSVAgPGZmZmZmZmZmODAxNmE4ZTE+e3B0ZV9hbGxvY19t
YXArMTkzfSBSU1AgPDAwMDAwMTAxM2JjN2RkYzg+DQpTZXAgMjAgMTg6MDM6
MTYgZmFuZyBrZXJuZWw6IENSMjogMDAwMDAwMDAwMDAwMGU3MA0KU2VwIDIw
IDE4OjAzOjE2IGZhbmcga2VybmVsOiAgPDE+VW5hYmxlIHRvIGhhbmRsZSBr
ZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IDAwMDAwMDAwMDAw
MDBlNzAgUklQOiANClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5lbDogPGZm
ZmZmZmZmODAxNmEwNWM+e3VubWFwX3ZtYXMrODYwfQ0KU2VwIDIwIDE4OjAz
OjE2IGZhbmcga2VybmVsOiBQTUw0IDEzZjdhMDA2NyBQR0QgMTNiNDM5MDY3
IFBNRCAwIA0KU2VwIDIwIDE4OjAzOjE2IGZhbmcga2VybmVsOiBPb3BzOiAw
MDAwIFsyXSBQUkVFTVBUIFNNUCANClNlcCAyMCAxODowMzoxNiBmYW5nIGtl
cm5lbDogQ1BVIDEgDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6IE1v
ZHVsZXMgbGlua2VkIGluOiBzZyBhZl9wYWNrZXQgcmF3IGlkZV9mbG9wcHkg
aWRlX3RhcGUgaWRlX2NkIGZsb3BweSBpcHRfVE9TIGlwdF9SRUpFQ1QgaXB0
X0xPRyBpcHRfc3RhdGUgaXBfbmF0X2lyYyBpcF9uYXRfdGZ0cCBpcF9uYXRf
ZnRwIGlwX2Nvbm50cmFja19pcmMgaXBfY29ubnRyYWNrX3RmdHAgaXBfY29u
bnRyYWNrX2Z0cCBpcHRfbXVsdGlwb3J0IGlwdF9jb25udHJhY2sgaXB0YWJs
ZV9maWx0ZXIgaXB0YWJsZV9tYW5nbGUgaXB0YWJsZV9uYXQgaXBfY29ubnRy
YWNrIGlwX3RhYmxlcyBvaGNpMTM5NCBpZWVlMTM5NCBydGMNClNlcCAyMCAx
ODowMzoxNiBmYW5nIGtlcm5lbDogUGlkOiAzMjY0LCBjb21tOiBtZW10ZXN0
IE5vdCB0YWludGVkIDIuNi44LjENClNlcCAyMCAxODowMzoxNiBmYW5nIGtl
cm5lbDogUklQOiAwMDEwOls8ZmZmZmZmZmY4MDE2YTA1Yz5dIDxmZmZmZmZm
ZjgwMTZhMDVjPnt1bm1hcF92bWFzKzg2MH0NClNlcCAyMCAxODowMzoxNiBm
YW5nIGtlcm5lbDogUlNQOiAwMDAwOjAwMDAwMTAxM2JjN2RhYjggIEVGTEFH
UzogMDAwMTAyMTcNClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5lbDogUkFY
OiAwMDAwMDAwMDAwMDAwMGUwIFJCWDogMDAwMDAwMDAwMDA3ZDAwMCBSQ1g6
IDAwMDAwMDAwMDAwMDAwMDANClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5l
bDogUkRYOiAwMDAwMDAwMDAwMTA5YzAwIFJTSTogMDAwMDAwMDAwMDAwMDAw
MCBSREk6IDAwMDAwMTAwMDRhM2RmYzgNClNlcCAyMCAxODowMzoxNiBmYW5n
IGtlcm5lbDogUkJQOiAwMDAwMDEwMTBhMjk2YjQ4IFIwODogMDAwMDAxMDAw
MDAwZTQwMCBSMDk6IDAwMDAwMTAxM2JjN2RiOTANClNlcCAyMCAxODowMzox
NiBmYW5nIGtlcm5lbDogUjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogMDAw
MDAwMDAwMGFhYWFhYSBSMTI6IDAwMDAwMDAwMDAxMTQwMDANClNlcCAyMCAx
ODowMzoxNiBmYW5nIGtlcm5lbDogUjEzOiAwMDAwMDAwMDAwMDAwMDIwIFIx
NDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDANClNl
cCAyMCAxODowMzoxNiBmYW5nIGtlcm5lbDogRlM6ICAwMDAwMDAyYTk1OGJm
NGMwKDAwMDApIEdTOmZmZmZmZmZmODA2YmJjNDAoMDAwMCkga25sR1M6MDAw
MDAwMDAwMDAwMDAwMA0KU2VwIDIwIDE4OjAzOjE2IGZhbmcga2VybmVsOiBD
UzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUw
MDNiDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6IENSMjogMDAwMDAw
MDAwMDAwMGU3MCBDUjM6IDAwMDAwMDAxM2ZmOWEwMDAgQ1I0OiAwMDAwMDAw
MDAwMDAwNmUwDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6IFByb2Nl
c3MgbWVtdGVzdCAocGlkOiAzMjY0LCB0aHJlYWRpbmZvIDAwMDAwMTAxM2Jj
N2MwMDAsIHRhc2sgMDAwMDAxMDEzZWMxZWRiMCkNClNlcCAyMCAxODowMzox
NiBmYW5nIGtlcm5lbDogU3RhY2s6IDAwMDAwMDJiMDZlZWMwMDAgMDAwMDAw
MmFjNzBlNjAwMCAwMDAwMDEwMTEwYzVlMWI4IDAwMDAwMDJhYzZlZWMwMDAg
DQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6ICAgICAgICAwMDAwMDEw
MTNmN2EwNTU4IDAwMDAwMDJhYzcwZTYwMDAgMDAwMDAxMDAwNTY0YjEwMCAw
MDAwMDAwMDAwMWZhMDAwIA0KU2VwIDIwIDE4OjAzOjE2IGZhbmcga2VybmVs
OiAgICAgICAgMDAwMDAwMmFkMTI2ZDAwMCAwMDAwMDAwOTAwMDAwMDAwIA0K
U2VwIDIwIDE4OjAzOjE2IGZhbmcga2VybmVsOiBDYWxsIFRyYWNlOjxmZmZm
ZmZmZjgwMTZjZThhPntleGl0X21tYXArMTg2fSA8ZmZmZmZmZmY4MDEzNzhh
MD57bW1wdXQrMTI4fSANClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5lbDog
ICAgICAgIDxmZmZmZmZmZjgwMTNjY2U1Pntkb19leGl0KzU5N30gPGZmZmZm
ZmZmODAxMTFmZWE+e29vcHNfZW5kKzc0fSANClNlcCAyMCAxODowMzoxNiBm
YW5nIGtlcm5lbDogICAgICAgIDxmZmZmZmZmZjgwMTIzNDdiPntkb19wYWdl
X2ZhdWx0KzEyMjd9IDxmZmZmZmZmZjgwMTMyMjg4PntyZWNhbGNfdGFza19w
cmlvKzQ0MH0gDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6ICAgICAg
ICA8ZmZmZmZmZmY4MDE1Y2RmND57X19ybXF1ZXVlKzIyOH0gPGZmZmZmZmZm
ODAxMTEzNjE+e2Vycm9yX2V4aXQrMH0gDQpTZXAgMjAgMTg6MDM6MTYgZmFu
ZyBrZXJuZWw6ICAgICAgICA8ZmZmZmZmZmY4MDE2YThlMT57cHRlX2FsbG9j
X21hcCsxOTN9IDxmZmZmZmZmZjgwMTZhODg1PntwdGVfYWxsb2NfbWFwKzEw
MX0gDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJuZWw6ICAgICAgICA8ZmZm
ZmZmZmY4MDE2YWIxMj57aGFuZGxlX21tX2ZhdWx0KzI1OH0gPGZmZmZmZmZm
ODAxMjMxNzQ+e2RvX3BhZ2VfZmF1bHQrNDUyfSANClNlcCAyMCAxODowMzox
NiBmYW5nIGtlcm5lbDogICAgICAgIDxmZmZmZmZmZjgwNGMwYjNiPntzY2hl
ZHVsZSsyMTl9IDxmZmZmZmZmZjgwMzNkYjQ5Pnt0dHlfd3JpdGUrNzc3fSAN
ClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5lbDogICAgICAgIDxmZmZmZmZm
ZjgwMTExMzYxPntlcnJvcl9leGl0KzB9IA0KU2VwIDIwIDE4OjAzOjE2IGZh
bmcga2VybmVsOiANClNlcCAyMCAxODowMzoxNiBmYW5nIGtlcm5lbDogQ29k
ZTogNDggMmIgOTEgNzAgMGUgMDAgMDAgNDggOGQgMDQgZDUgMDAgMDAgMDAg
MDAgNDggMjkgZDAgNDggOGIgDQpTZXAgMjAgMTg6MDM6MTYgZmFuZyBrZXJu
ZWw6IFJJUCA8ZmZmZmZmZmY4MDE2YTA1Yz57dW5tYXBfdm1hcys4NjB9IFJT
UCA8MDAwMDAxMDEzYmM3ZGFiOD4NClNlcCAyMCAxODowMzoxNiBmYW5nIGtl
cm5lbDogQ1IyOiAwMDAwMDAwMDAwMDAwZTcwDQpTZXAgMjAgMTg6MDM6MTYg
ZmFuZyBrZXJuZWw6ICA8Nj5ub3RlOiBtZW10ZXN0WzMyNjRdIGV4aXRlZCB3
aXRoIHByZWVtcHRfY291bnQgMQ0KU2VwIDIwIDE4OjAzOjE2IGZhbmcga2Vy
bmVsOiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UgYXQgMDAwMDAwMDAwMDAwMDAyOCBSSVA6IA0KU2VwIDIwIDE4
OjA2OjAxIGZhbmcgc3lzbG9nZCAxLjQuMTogcmVzdGFydC4NCg==

---1463811577-1807617825-1095676001=:5797--
