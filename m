Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129391AbQK3OE0>; Thu, 30 Nov 2000 09:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129555AbQK3OEQ>; Thu, 30 Nov 2000 09:04:16 -0500
Received: from eax.student.umd.edu ([129.2.228.67]:41480 "EHLO
        eax.student.umd.edu") by vger.kernel.org with ESMTP
        id <S129391AbQK3OEI>; Thu, 30 Nov 2000 09:04:08 -0500
Date: Thu, 30 Nov 2000 09:34:37 -0500 (EST)
From: Adam <adam@eax.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Marc Mutz <Marc@mutz.com>, linux-kernel@vger.kernel.org
Subject: Re: 'holey files' not holey enough.
In-Reply-To: <200011292334.eATNYNB09518@webber.adilger.net>
Message-ID: <Pine.LNX.4.21.0011300929330.1152-200000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="42025956-1601409947-975594877=:1152"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--42025956-1601409947-975594877=:1152
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 29 Nov 2000, Andreas Dilger wrote:

> What people who have the problem should be doing is:
> [desc snipped]
> > ls -li holed.file        # find inode number
> 10732 -rw-r--r--    1 root     root      6000000 Nov 29 16:17 holed.file
> > du -sk holed.file        # see what "stat" thinks
> 983k    holed.file
> > debugfs /dev/XXX
> debugfs> stats           # find out ext2 block size
> ...
> Block size = 1024, fragment size = 1024
> ...
> debugfs> stat <10732>  # (with < and >)
> Inode: 10732   Type: regular    Mode:  0644   Flags: 0x0   Generation:
> 4048594821
> User:     0   Group:     0   Size: 6000000
> File ACL: 0    Directory ACL: 0
> Links: 1   Blockcount: 1966
>                        ^^^^ these are 512-byte blocks, so / 2 for ~kB
> 		            they include indirect blocks and such
> Fragment:  Address: 0    Number: 0    Size: 0
> ctime: 0x3a258e82 -- Wed Nov 29 16:17:22 2000
> atime: 0x3a258e82 -- Wed Nov 29 16:17:22 2000
> mtime: 0x3a258e82 -- Wed Nov 29 16:17:22 2000
> BLOCKS:
> 47512 47513 47514 47515 47516 47517 47518 47519 47520 ... 48723 48724
> TOTAL: 983
>        ^^^ these are ext2fs sized blocks, not necessarily kB
> 
> If what debugfs says doesn't match du, then it is du/libc/stat that is
> broken.  If debugfs says the file actually has 6000000 bytes of data,
> then it is the filesystem that is broken.

I just did what suggested, and it seems that DU reports correct values,
I have attached 'sript' log of the above example on my filesystem.
Here are some highlights:

[adam@pepsi /tmp]$ ls -lis holed.file
3085069 5872 -rw-rw-r--    1 adam     adam      6000000 Nov 30 09:11 holed.file

Block size = 4096, fragment size = 4096
Links: 1   Blockcount: 11744
TOTAL: 1468

so it seems DU reports correct values as :
	1966/2 =983
	11744/2=5872
and
	4096*1468=6012928
	1024*983 =1006592



-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


--42025956-1601409947-975594877=:1152
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="holey.scr2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0011300934370.1152@eax.student.umd.edu>
Content-Description: 
Content-Disposition: attachment; filename="holey.scr2"

U2NyaXB0IHN0YXJ0ZWQgb24gVGh1IE5vdiAzMCAwOToxMTo0MCAyMDAwDQpb
YWRhbUBwZXBzaSAvdG1wXSQgZGQgaWY9L2Rldi96ZXJvIG9mPWhvbGVkLmZp
bGUgYnM9MTAwMCBzZWVrPTUwMDAgY291bnQ9MTAwMA0KMTAwMCswIHJlY29y
ZHMgaW4NCjEwMDArMCByZWNvcmRzIG91dA0KW2FkYW1AcGVwc2kgL3RtcF0k
IGxzIC1saXMgaG9sZWQuZmlsZQ0KMzA4NTA2OSA1ODcyIC1ydy1ydy1yLS0g
ICAgMSBhZGFtICAgICBhZGFtICAgICAgNjAwMDAwMCBOb3YgMzAgMDk6MTEg
aG9sZWQuZmlsZQ0KW2FkYW1AcGVwc2kgL3RtcF0kIGR1IC1zaCBob2xlZC5m
aWxlDQo1LjdNCWhvbGVkLmZpbGUNClthZGFtQHBlcHNpIC90bXBdJCBkZiAu
DQpGaWxlc3lzdGVtICAgICAgICAgICAxay1ibG9ja3MgICAgICBVc2VkIEF2
YWlsYWJsZSBVc2UlIE1vdW50ZWQgb24NCi9kZXYvaGRlMyAgICAgICAgICAg
ICAyNTQ3NDcyOCAgMTY5ODY0ODggICA3MTczMTgwICA3MCUgLw0KW2FkYW1A
cGVwc2kgL3RtcF0kIHN1DQpQYXNzd29yZDogDQpyb290QHBlcHNpIC90bXBd
IyAvdXNyL3NiaW4vZGVidWdmIC9kZXYvaGRlMw0KZGVidWdmcyAxLjE5LCAx
My1KdWwtMjAwMCBmb3IgRVhUMiBGUyAwLjViLCA5NS8wOC8wOQ0KZGVidWdm
czogIHN0YXRzDQpGaWxlc3lzdGVtIGlzIHJlYWQtb25seQ0KVm9sdW1lIG5h
bWUgPSAobm9uZSkNCkxhc3QgbW91bnRlZCBkaXJlY3RvcnkgPSAobm9uZSkN
CkZpbGVzeXN0ZW0gVVVJRCA9IGRhY2FiOGI2LWNiYWUtMTFkMy04NjdkLTAw
MjAwMDg0ZmRiNA0KRmlsZXN5c3RlbSBmZWF0dXJlczoobm9uZSkNCkxhc3Qg
bW91bnQgdGltZSA9IFRodSBOb3YgMjMgMjM6MTg6MDUgMjAwMA0KTGFzdCB3
cml0ZSB0aW1lID0gVGh1IE5vdiAzMCAwOToxMjo1NiAyMDAwDQpNb3VudCBj
b3VudHMgPSAxIChtYXhpbWFsID0gMjApDQpGaWxlc3lzdGVtIE9TIHR5cGUg
PSBMaW51eA0KU3VwZXJibG9jayBzaXplID0gMTAyNA0KQmxvY2sgc2l6ZSA9
IDQwOTYsIGZyYWdtZW50IHNpemUgPSA0MDk2DQpJbm9kZSBzaXplID0gMTI4
DQo2NTc5OTM2IGlub2RlcywgNjAxNDAzNiBmcmVlDQo2NTc1MzEwIGJsb2Nr
cywgMjEyMjA2MCBmcmVlLCAzMjg3NjUgcmVzZXJ2ZWQsIGZpcnN0IGJsb2Nr
ID0gMA0KMzI3NjggYmxvY2tzIHBlciBncm91cA0KMzI3NjggZnJhZ21lbnRz
IHBlciBncm91cA0KMzI3MzYgaW5vZGVzIHBlciBncm91cA0KMjAxIGdyb3Vw
cyAoMiBkZXNjcmlwdG9ycyBibG9ja3MpDQogR3JvdXAgIDA6IGJsb2NrIGJp
dG1hcCBhdCAzLCBpbm9kZSBiaXRtYXAgYXQgNCwgaW5vZGUgdGFibGUgYXQg
NQ0KICAgICAgICAgICAwIGZyZWUgYmxvY2tzLCAzMDExOCBmcmVlIGlub2Rl
cywgMTA2IHVzZWQgZGlyZWN0b3JpZXMNCiBbLi4uLl0NCiBHcm91cCAyMDA6
IGJsb2NrIGJpdG1hcCBhdCA2NTUzNjAzLCBpbm9kZSBiaXRtYXAgYXQgNjU1
MzYwNCwgaW5vZGUgdGFibGUgYXQgNjU1MzYwNQ0KICAgICAgICAgICAxMzE1
MSBmcmVlIGJsb2NrcywgMjk4ODcgZnJlZSBpbm9kZXMsIDMzNCB1c2VkIGRp
cmVjdG9yaWVzDQpkZWJ1Z2ZzOiAgc3RhdCA8MzA4NTA2OT4NCklub2RlOiAz
MDg1MDY5ICAgVHlwZTogcmVndWxhciAgICBNb2RlOiAgMDY2NCAgIEZsYWdz
OiAweDAgICBHZW5lcmF0aW9uOiA2NjYwNjU4DQpVc2VyOiAgIDUwMCAgIEdy
b3VwOiAgIDUwMCAgIFNpemU6IDYwMDAwMDANCkZpbGUgQUNMOiAwICAgIERp
cmVjdG9yeSBBQ0w6IDANCkxpbmtzOiAxICAgQmxvY2tjb3VudDogMTE3NDQN
CkZyYWdtZW50OiAgQWRkcmVzczogMCAgICBOdW1iZXI6IDAgICAgU2l6ZTog
MA0KY3RpbWU6IDB4M2EyNjYwMjMgLS0gVGh1IE5vdiAzMCAwOToxMTo0NyAy
MDAwDQphdGltZTogMHgzYTI0M2M1MSAtLSBUdWUgTm92IDI4IDE4OjE0OjI1
IDIwMDANCm10aW1lOiAweDNhMjY2MDIzIC0tIFRodSBOb3YgMzAgMDk6MTE6
NDcgMjAwMA0KQkxPQ0tTOg0KMjEzMjI2IFsuLi4uXSAxNjc0OTMgDQpUT1RB
TDogMTQ2OA0KZGVidWdmczogICBxdWl0DQphZGFtQHBlcHNpOiAvdG1wB1ty
b290QHBlcHNpIC90bXBdIyBleGl0DQpleGl0DQphZGFtQHBlcHNpOiAvdG1w
B1thZGFtQHBlcHNpIC90bXBdJCBleGl0DQpleGl0DQpTY3JpcHQgZG9uZSBv
biBUaHUgTm92IDMwIDA5OjE2OjI3IDIwMDANCg==
--42025956-1601409947-975594877=:1152--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
