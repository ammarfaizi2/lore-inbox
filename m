Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288452AbSADCPu>; Thu, 3 Jan 2002 21:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288453AbSADCPl>; Thu, 3 Jan 2002 21:15:41 -0500
Received: from mail2.mx.voyager.net ([216.93.66.201]:64266 "EHLO
	mail2.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S288452AbSADCPb>; Thu, 3 Jan 2002 21:15:31 -0500
Message-ID: <3C351012.9B4D4D6@megsinet.net>
Date: Thu, 03 Jan 2002 20:14:42 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: andihartmann@freenet.de, riel@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com>
		<3C2F04F6.7030700@athlon.maya.org>
		<3C309CDC.DEA9960A@megsinet.net> <20011231185350.1ca25281.skraw@ithnet.com>
Content-Type: multipart/mixed;
 boundary="------------BDE2712DB11BD9E434658221"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BDE2712DB11BD9E434658221
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stephan von Krawczynski wrote:
> 
> On Mon, 31 Dec 2001 11:14:04 -0600
> "M.H.VanLeeuwen" <vanl@megsinet.net> wrote:
> 
> > [...]
> > vmscan patch:
> >
> > a. instead of calling swap_out as soon as max_mapped is reached, continue to
> try>    to free pages.  this reduces the number of times we hit
> try_to_free_pages() and>    swap_out().
> 
> I experimented with this some time ago, but found out it hit performance and
> (to my own surprise) did not do any good at all. Have you tried this
> stand-alone/on top of the rest to view its results?
> 
> Regards,
> Stephan

Stephan,

Here is what I've run thus far.  I'll add nfs file copy into the mix also...

System: SMP 466 Celeron 192M RAM, running KDE, xosview, and other minor apps.

Each run after clean & cache builds has 1 more setiathome client running upto a
max if 8 seti clients.  No, this isn't my normal way of running setiathome, but
each instance uses a nice chunk of memory.

Note: this is a single run for each of the columns using "make -j2 bzImage" each time.

I will try to run aa and rmap this evening and/or tomorrow.

Martin

----------------------------------------------------------------------------

                STOCK KERNEL    MH KERNEL       STOCK + SWAP    MH + SWAP
                (no swap)       (no swap)

CLEAN
BUILD   real    7m19.428s       7m19.546s       7m26.852s       7m26.256s
        user    12m53.640s      12m50.550s      12m53.740s      12m47.110s
        sys     0m47.890s       0m54.960s       0m58.810s       1m1.090s
                                                1.1M swp        0M swp

CACHE
BUILD   real    7m3.823s        7m3.520s        7m4.040s        7m4.266s
        user    12m47.710s      12m49.110s      12m47.640s      12m40.120s
        sys     0m46.660s       0m46.270s       0m47.480s       0m51.440s
                                                1.1M swp        0M swp

SETI 1
        real    9m51.652s       9m50.601s       9m53.153s       9m53.668s
        user    13m5.250s       13m4.420s       13m5.040s       13m4.470s
        sys     0m49.020s       0m50.460s       0m51.190s       0m50.580s
                                                1.1M swp        0M swp

SETI 2
        real    13m9.730s       13m7.719s       13m4.279s       13m4.768s
        user    13m16.810s      13m15.150s      13m15.950s      13m13.400s
        sys     0m50.880s       0m50.460s       0m50.930s       0m52.520s
                                                5.8M swp        1.9M swp

SETI 3
        real    15m49.331s      15m41.264s      15m40.828s      15m45.551s
        user    13m22.150s      13m21.560s      13m14.390s      13m20.790s
        sys     0m49.250s       0m49.910s       0m49.850s       0m50.910s
                                                16.2M swp       3.1M swp

SETI 4
        real    OOM KILLED      19m8.435s       19m5.584s       19m3.618s
        user    kdeinit         13m24.570s      13m24.000s      13m22.520s
        sys                     0m51.430s       0m50.320s       0m51.390s
                                                18.7M swp       8.3M swp
SETI 5
        real    NA              21m35.515s      21m48.543s      22m0.240s
        user                    13m9.680s       13m22.030s      13m28.820s
        sys                     0m49.910s       0m50.850s       0m52.270s
                                                31.7M swp       11.3M swp

SETI 6
        real    NA              24m37.167s      25m5.244s       25m13.429s
        user                    13m7.650s       13m26.590s      13m32.640s
        sys                     0m51.390s       0m51.260s       0m52.790s
                                                35.3M swp       17.1M swp

SETI 7
        real    NA              28m40.446s      28m3.612s       28m12.981s
        user                    13m16.460s      13m26.130s      13m31.520s
        sys                     0m57.940s       0m52.510s       0m53.570s
                                                38.8M swp       25.4M swp

SETI 8
        real    NA              29m31.743s      31m16.275s      32m29.534s
        user                    13m37.610s      13m27.740s      13m33.630s
        sys                     1m4.450s        0m52.100s       0m54.140s
                                                41.5M swp       49.7M swp (hmmm?)
--------------BDE2712DB11BD9E434658221
Content-Type: application/octet-stream;
 name="vmscan.patch.2.4.17.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="vmscan.patch.2.4.17.c"

LS0tIGxpbnV4LnZpcmdpbi9tbS92bXNjYW4uYwlNb24gRGVjIDMxIDEyOjQ2OjI1IDIwMDEK
KysrIGxpbnV4L21tL3Ztc2Nhbi5jCVRodSBKYW4gIDMgMTk6NDM6MDIgMjAwMgpAQCAtMzk0
LDkgKzM5NCw5IEBACiAJCWlmIChQYWdlRGlydHkocGFnZSkgJiYgaXNfcGFnZV9jYWNoZV9m
cmVlYWJsZShwYWdlKSAmJiBwYWdlLT5tYXBwaW5nKSB7CiAJCQkvKgogCQkJICogSXQgaXMg
bm90IGNyaXRpY2FsIGhlcmUgdG8gd3JpdGUgaXQgb25seSBpZgotCQkJICogdGhlIHBhZ2Ug
aXMgdW5tYXBwZWQgYmVhdXNlIGFueSBkaXJlY3Qgd3JpdGVyCisJCQkgKiB0aGUgcGFnZSBp
cyB1bm1hcHBlZCBiZWNhdXNlIGFueSBkaXJlY3Qgd3JpdGVyCiAJCQkgKiBsaWtlIE9fRElS
RUNUIHdvdWxkIHNldCB0aGUgUEdfZGlydHkgYml0ZmxhZwotCQkJICogb24gdGhlIHBoaXNp
Y2FsIHBhZ2UgYWZ0ZXIgaGF2aW5nIHN1Y2Nlc3NmdWxseQorCQkJICogb24gdGhlIHBoeXNp
Y2FsIHBhZ2UgYWZ0ZXIgaGF2aW5nIHN1Y2Nlc3NmdWxseQogCQkJICogcGlubmVkIGl0IGFu
ZCBhZnRlciB0aGUgSS9PIHRvIHRoZSBwYWdlIGlzIGZpbmlzaGVkLAogCQkJICogc28gdGhl
IGRpcmVjdCB3cml0ZXMgdG8gdGhlIHBhZ2UgY2Fubm90IGdldCBsb3N0LgogCQkJICovCkBA
IC00ODAsMTEgKzQ4MCwxNCBAQAogCiAJCQkvKgogCQkJICogQWxlcnQhIFdlJ3ZlIGZvdW5k
IHRvbyBtYW55IG1hcHBlZCBwYWdlcyBvbiB0aGUKLQkJCSAqIGluYWN0aXZlIGxpc3QsIHNv
IHdlIHN0YXJ0IHN3YXBwaW5nIG91dCBub3chCisJCQkgKiBpbmFjdGl2ZSBsaXN0LgorCQkJ
ICogTW92ZSByZWZlcmVuY2VkIHBhZ2VzIHRvIHRoZSBhY3RpdmUgbGlzdC4KIAkJCSAqLwot
CQkJc3Bpbl91bmxvY2soJnBhZ2VtYXBfbHJ1X2xvY2spOwotCQkJc3dhcF9vdXQocHJpb3Jp
dHksIGdmcF9tYXNrLCBjbGFzc3pvbmUpOwotCQkJcmV0dXJuIG5yX3BhZ2VzOworCQkJaWYg
KFBhZ2VSZWZlcmVuY2VkKHBhZ2UpKSB7CisJCQkJZGVsX3BhZ2VfZnJvbV9pbmFjdGl2ZV9s
aXN0KHBhZ2UpOworCQkJCWFkZF9wYWdlX3RvX2FjdGl2ZV9saXN0KHBhZ2UpOworCQkJfQor
CQkJY29udGludWU7CiAJCX0KIAogCQkvKgpAQCAtNTIxLDYgKzUyNCw5IEBACiAJfQogCXNw
aW5fdW5sb2NrKCZwYWdlbWFwX2xydV9sb2NrKTsKIAorCWlmIChtYXhfbWFwcGVkIDw9IDAg
JiYgbnJfcGFnZXMgPiAwKQorCQlzd2FwX291dChwcmlvcml0eSwgZ2ZwX21hc2ssIGNsYXNz
em9uZSk7CisKIAlyZXR1cm4gbnJfcGFnZXM7CiB9CiAK
--------------BDE2712DB11BD9E434658221--

