Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSFZQwo>; Wed, 26 Jun 2002 12:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSFZQwn>; Wed, 26 Jun 2002 12:52:43 -0400
Received: from fmr03.intel.com ([143.183.121.5]:43233 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S316679AbSFZQwm>; Wed, 26 Jun 2002 12:52:42 -0400
Message-Id: <200206261652.g5QGqcP27590@unix-os.sc.intel.com>
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fwd: [Lse-tech] Block IO write performance (ext2 data) WAS  : Ext3 performance bottleneck as the number of spindles gets large
Date: Wed, 26 Jun 2002 10:00:22 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_M8GBNLXOOHZB3B1DFQZV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_M8GBNLXOOHZB3B1DFQZV
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

I origanaly started this "EXT3 scaling to large numbers of drives" thread on both the LSE and the LKM lists. 

I forgot to CC the LKML when I posted this yesterday.  The LSE is likely the better place for this type of thing so take this as 
just an FYI to close out some of the open quiestions that where made durring that thread.

--mgross

----------  Forwarded Message  ----------

Subject: [Lse-tech] Block IO write performance (ext2 data) WAS  : Ext3 performance bottleneck as the number of spindles gets large
Date: Tue, 25 Jun 2002 17:32:56 -0400
From: mgross <mgross@unix-os.sc.intel.com>
To: lse-tech@lists.sourceforge.net
Cc: "'Andrew Morton'" <akpm@zip.com.au>, "Griffiths, Richard A" <richard.a.griffiths@intel.com>, "'Jens Axboe'"  <axboe@suse.de>

I've just finished getting some EXT2 block throughput data as requested by
this list for the  "Ext3 performance bottleneck as the number of spindles
gets large" email thread that I started last week.

Recall the system is a dual PCI/66 box with 4 good SCSI cards with up to 6
15KRPM ST318452LC drives per card.  (dual 1.2Ghz Pentium 3 with 2 Gig RAM
running kernels high mem support == OFF )

http://www.intel.com/design/servers/scb2/index.htm?iid=ipp_browse+motherbd_s
cb2&

http://www.adaptec.com/worldwide/product/proddetail.html?sess=no&prodkey=ASC
-39160&cat=Products

The benchmark we are using is bonnie++ version 1.02h
ttp://www.coker.com.au/bonnie++

Running on 2.4.18 base, 8KB writes to 300MB files I get the following data
when run on the ext 2 file system.

2 adapters (on separate PCI buses)
Drives per card	 Total system throughput EXT2          EXT3
          1                      73357 KB/sec                   92095 KB/sec
          2                    115953 KB/sec                   110956 KB/sec
          3                    132176 KB/sec
          4                    139578 KB/sec
          5                    139085 KB/sec
          6                    140033 KB/sec                   106883 KB/sec

4 adapters
Drives per card	 Total system throughput EXT2          EXT3
          1                     125282 KB/sec                   121125 KB/sec
          2                     146632 KB/sec                   117575 KB/sec
          3                     146622 KB/sec
          4                     142472 KB/sec
          5                     142560 KB/sec
          6                     138835 KB/sec                   116570 KB/sec

This performance still isn't very competitive and we see very little evidence
of scaling.

I think that there we should be getting closer to 300,000KB/sec for max
throughput.  I'll get some lock meter data tomorrow, as well as run with some
of those patches I've been sent and perhaps even some other kernels ( any
recomendations?).

>From this data I conclude that the BKL that ext3 is abusing using is only
part of the problem.

Comments? Ideas? Recommendations?

Attached is the script I'm using to do the 4 addapter runs.  Its not pritty,
but if you have questions regarding the tests it may help clarify things.

--mgross

-------------------------------------------------------



--------------Boundary-00=_M8GBNLXOOHZB3B1DFQZV
Content-Type: application/x-shellscript;
  charset="iso-8859-15";
  name="run4xn"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="run4xn"

IyEvYmluL2Jhc2gKCgljbGVhbj1gZmluZCBjKiAtbmFtZSB0WzAtNV0gLXByaW50YDsKCWZvciBp
IGluICRjbGVhbjsKCWRvCgkJcm0gLXJmIC4vJGkvKjsKCWRvbmU7CgoJcm0gLWYgZXh0Ml8zKjsK
CmZvciBudW1kcml2ZXMgaW4gMCAxIDIgMyA0IDUgOyBkbwoJCQoJc3luYzsKCWVjaG8gJG51bWRy
aXZlcwoJZWNobyAic3RhcnRpbmcgcnVuIHdpdGggNCBhZGRhcHRlcnMgYW5kICRudW1kcml2ZXMg
IgoJZWNobyAkbnVtZHJpdmVzCgoKCWlmIFsgJG51bWRyaXZlcyAtZ3QgMCBdOyB0aGVuCgkJbD1g
ZmluZCBjKiAtbmFtZSB0WzAtJG51bWRyaXZlc10gLXByaW50YDsKCWVsc2UKCQlsPWBmaW5kIGMq
IC1uYW1lIHQ1IC1wcmludGA7CglmaQoKCWVjaG8gJGw7CgoJZm9yIGkgaW4gJGw7IGRvCgkJY2Qg
JGk7IAoJCWJvbm5pZSsrIC1kIC4gLXIgMCAtbiAwIC11IHJvb3QgLWYgLW0gYGhvc3RuYW1lYCAt
cyAzMDAgPiJleHQyXzMwME1CLiRudW1kcml2ZXMiICYgY2QgLi4vLi47IAoJZG9uZTsKCglzbGVl
cCAzMAoJcHJvZ3JhbT1gcHMgLWF1eCB8IGdyZXAgLWMgYm9ubmllYDsKCgl3aGlsZSBbICRwcm9n
cmFtIC1ndCAxIF07CglkbwoJCWVjaG8gJHByb2dyYW07CgkJc2xlZXAgMzAKCQlwcm9ncmFtPWBw
cyAtYXV4IHwgZ3JlcCAtYyBib25uaWVgOwoJZG9uZTsKCglzbGVlcCAzMAoJCglqdW5rPWBmaW5k
IGMqIC1uYW1lICJleHQyXzMwME1CLiRudW1kcml2ZXMiICAtcHJpbnRgOwoJZWNobyAkanVuazsK
CQoJZm9yIGkgaW4gJGp1bms7IAoJZG8gCgkJY2F0ICRpID4+ICJleHQyXzMwME1CLiRudW1kcml2
ZXMiCglkb25lOwoJCglib24gPCAiZXh0Ml8zMDBNQi4kbnVtZHJpdmVzIiA+ICJleHQyXzMwME1C
XyRudW1kcml2ZXMiLmh0bWw7CgkKCWVjaG8gImZpbmlzaGluZyBydW4gd2l0aCA0IGFkZGFwdGVy
cyBhbmQgJG51bWRyaXZlcyAiCgllY2hvICJmaW5pc2hpbmcgcnVuIHdpdGggNCBhZGRhcHRlcnMg
YW5kICRudW1kcml2ZXMgIgoJZWNobyAiZmluaXNoaW5nIHJ1biB3aXRoIDQgYWRkYXB0ZXJzIGFu
ZCAkbnVtZHJpdmVzICIKCmRvbmU7Cgo=

--------------Boundary-00=_M8GBNLXOOHZB3B1DFQZV--
