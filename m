Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268977AbUIHCox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268977AbUIHCox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268984AbUIHCow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:44:52 -0400
Received: from holomorphy.com ([207.189.100.168]:12196 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268977AbUIHCo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:44:26 -0400
Date: Tue, 7 Sep 2004 19:43:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040908024319.GU3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hans Reiser <reiser@namesys.com>,
	David Masover <ninja@slaphack.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
	Tonnerre <tonnerre@thundrix.ch>,
	Christer Weinigel <christer@weinigel.se>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200409070206.i8726vrG006493@localhost.localdomain> <413D4C18.6090501@slaphack.com> <413D4ED9.5090206@namesys.com> <20040907062806.GL3106@holomorphy.com> <20040907223801.GS3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20040907223801.GS3106@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 07, 2004 at 03:38:01PM -0700, William Lee Irwin III wrote:
> Okay, sounds like time to run these tests and post the results myself.
> Hans, these things should be part of your standard QA. It would likely
> make a better impression if there were some record of these kinds of
> things having been successfully tested prior to your releases. For
> future reference, Andrew, Christoph, myself, and others can provide
> more detailed references to suites of stress tests and various kinds of
> tests filesystems should pass before being considered stable, and we
> (it's a relatively safe presumption that I speak for all of us when I
> say this) would appreciate this kind of testing in the future.

Step 1, the tools are very broken. This level of nonfunctionality
of the reiser4 toolchain precludes any kind of exposure to the kind of
testing I've asked about. I would very strongly prefer not to have to
become a reiser4 implementor and furthermore fix numerous bugs just to
have the smallest bit of assurance that this thing won't generate bug
reports en masse once merged.

The following is from an UltraSPARC system (64-bit wordsize, big-endian,
8KB pagesize, 32-bit userspace, including 32-bit compiled reiser4 tools)
running 2.6.9-rc1-mm3:


# /usr/local/sbin/mkfs.reiser4 -f -b 4096 /dev/loop0
/usr/local/sioctl32(mkfs.reiser4:1949): Unknown cmd fd(3) cmd(40081272){00} arg(efffc810) on /dev/loop0
4boicnt/lm3k2f(sm.krfesi.sreeri4s e1r.40:.109
 9C)o:p yUrnikgnhotw n( Cc)m d2 0f0d1(,3 )2 0c0m2d,( 420000831,2 7220)0{40 0b}y raHragn(se fRfefics8e1r0,)  loinc e/ndseivn/gl ogoopv0e
 ned by
reiser4progs/COPYING.

Block size 4096 will be used.
Linux 2.6.9-rc1-mm3 is detected.
Reiser4 is going to be created on /dev/loop0.
(Yes/No): Yes
 ioctl32(mkfs.reiser4:1949): Unknown cmd fd(3) cmd(40081272){00} arg(efffc738) on /dev/loop0
i o c t l 3 2 ( m k f s . r e i s e r 4 : 1 9 4 9 ) :   U n k n o w n   c m d   sC r/edaetvi/nlgo orpe0i0 8 1 2 7 2 ) { 0 0 }   a r g ( e f f f c 7 3 8 )
 er4 on /dev/loop0 ... Bus error
#

With the below patch, I get:
# /usr/local/sbin/mkfs.reiser4 -f -b 4096 /dev/loop0                            /usr/local/sbin/mkfs.reiser4 1.0.0
Copyright (C) 2001, 2002, 2003, 2004 by Hans Reiser, licensing governed by
reiser4progs/COPYING.

Block size 4096 will be used.
Linux 2.6.9-rc1-mm3 is detected.
Reiser4 is going to be created on /dev/loop0.
(Yes/No): Yes
Creating reiser4 on /dev/loop0 ... Bus error
#

The S_ISBLK() check is so that other assumptions about the file being
a block device elsewhere won't be tripped up; it's not strictly
necessary, only retained so as not to expose unaudited code to a new
situation for which it's not prepared.

strace(1) before and after the patch is included here. The backtrace
from the core dump is:

#0  0x7005e464 in cde40_insert_units () from /usr/local/lib/libreiser4-1.0.so.0
(gdb) bt
#0  0x7005e464 in cde40_insert_units () from /usr/local/lib/libreiser4-1.0.so.0
#1  0x7004fa44 in node40_modify () from /usr/local/lib/libreiser4-1.0.so.0
#2  0x7003c608 in cb_node_insert () from /usr/local/lib/libreiser4-1.0.so.0
#3  0x7003c58c in reiser4_node_modify ()
   from /usr/local/lib/libreiser4-1.0.so.0
#4  0x7003ee7c in reiser4_tree_modify ()
   from /usr/local/lib/libreiser4-1.0.so.0
#5  0x7006bc10 in obj40_insert () from /usr/local/lib/libreiser4-1.0.so.0
#6  0x7006d9e8 in dir40_create () from /usr/local/lib/libreiser4-1.0.so.0
#7  0x70041610 in reiser4_object_create ()
   from /usr/local/lib/libreiser4-1.0.so.0
#8  0x00012160 in main ()


-- wli

Index: libaal-1.0.0/src/file.c
===================================================================
--- libaal-1.0.0.orig/src/file.c	2004-01-08 06:49:40.000000000 -0800
+++ libaal-1.0.0/src/file.c	2004-09-07 19:36:49.593844072 -0700
@@ -193,59 +193,31 @@
 	return !aal_strncmp(file1, file2, aal_strlen(file1));
 }
 
-#if defined(__linux__) && defined(_IOR) && !defined(BLKGETSIZE64)
-#   define BLKGETSIZE64 _IOR(0x12, 114, uint64_t)
-#endif
-
 /* Handler for "len" operation for use with file device. See bellow for
    understanding where it is used. */
 static count_t file_len(
 	aal_device_t *device)	    /* file device, lenght will be obtained from */
 {
-	uint64_t size;
-	off_t max_off = 0;
+	off_t off, size;
+	struct stat stat_buf;
+	int fd;
 
-	if (!device) 
+	if (!device)
 		return INVAL_BLK;
-    
-#ifdef BLKGETSIZE64
-	if ((int)ioctl(*((int *)device->entity), BLKGETSIZE64, &size) >= (int)0) {
-		uint32_t block_count;
-		
-		size = (size / 4096) * 4096 / device->blksize;
-		block_count = size;
-		
-		if ((uint64_t)block_count != size) {
-			aal_fatal("The partition size is too big.");
-			return INVAL_BLK;
-		}
-		
-		return (count_t)block_count;
-	}
-    
-#endif
-
-#ifdef BLKGETSIZE    
-	{
-		unsigned long l_size;
-		
-		if (ioctl(*((int *)device->entity), BLKGETSIZE, &l_size) >= 0) {
-			size = l_size;
-			return (count_t)((size * 512 / 4096) * 4096 / 
-				device->blksize);
-		}
-	}
-    
-#endif
-    
-	if ((max_off = lseek(*((int *)device->entity), 
-			     0, SEEK_END)) == (off_t)-1) 
-	{
-		file_error(device);
+	fd = *(int *)device->entity;
+	if (fstat(fd, &stat_buf))
+		return INVAL_BLK;
+	if (!S_ISBLK(stat_buf.st_mode))
+		return INVAL_BLK;
+	off = lseek(fd, 0, SEEK_CUR);
+	size = lseek(fd, 0, SEEK_END);
+	if (lseek(fd, off, SEEK_SET) == (off_t)-1)
+		errno = 0;
+	if (size == (off_t)-1) {
+		errno = 0;
 		return INVAL_BLK;
 	}
-    
-	return (count_t)(max_off / device->blksize);
+	return (size & ~4096ULL)/device->blksize;
 }
 
 /* Initializing the file device operations. They are used when any operation of

--UPT3ojh+0CqEDtpF
Content-Type: application/octet-stream
Content-Description: mkfs.reiser4.log.1.gz
Content-Disposition: attachment; filename="mkfs.reiser4.log.1.gz"
Content-Transfer-Encoding: base64

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

--UPT3ojh+0CqEDtpF
Content-Type: application/octet-stream
Content-Description: mkfs.reiser4.log.2.gz
Content-Disposition: attachment; filename="mkfs.reiser4.log.2.gz"
Content-Transfer-Encoding: base64

H4sIAEtqPkEAA+1bbXPiOBL+nl+hyt5cwQ4vkt/Zq1RdQsgMNwRyQHYmRaYoY0TiirEp22SS
S+a/n1o2YMAmMZhk926TAsnQeroldT9Sy4Y+UOOe5g7LU88tW46hW2VvYNrl8d3IK7nU9Kgr
HRZQ7yWBw+KIvw/gXcIVBcrykN6zNs4EH35nGOVfEZHQve566Nfy9zw6QvhgautjmnvyHr2j
w4ZpTx9YO9sZ0qND3datR980TP+RfVYqlX4GLQbuXQ7n0Yt/TPZB0DDGB7phUM9jfaS+UbaG
Jc8p2c7tD0OfMOCzfutLftaiSFCt2ao1uyjXdJA3NW7RyLQoclw0NF1q+I77mD9wJtReQpu4
1HL0IUNr9dunrWbjKr8F3mKALXNQvq9AEQ5wkZQwKMJLKl6L7/m6r0gxGhgafqAj9idI+PV4
sfa+bKx44FJ9mBOZY1wTVa01zq7JtcBeOOZfZC8hrAcSIlEPmRcUkEwEgGPFwSjsGsN88vz+
GByn06+ftWufnrEqywXEPvXM/9AjUVOIiKN+NB7rk1zzstEoIAljiSgFdNFudfvt2vHpM6/V
vtWqBXR+fNG/aNd/P+7WCogp4gOFH1SMBQO8i+PwaxWuC0gVVUFbA/varndrCbjPUD+rf6ud
BhoemEF4oYfjHhiW49Gc+KLnQ9+SZkjXrf3Mzt+uBRnvMj2yiNWE2dEqDCv15FQwn5yJ6/jM
b4MJqih8ghSpIs5mu9lq1vJooZLL6ZjLCZKsrntFmomcW8MRM5lCmCXLtCnMobQVHazRl6Eb
t3SVvBD3iY0zqEjSYgYFRVHkhBkMv5sP5KZ507W0I7Unen/FeO/KaFhKFzJLA04qzJ2lxBFX
ZRBOGTSDmKAZBqymqaKANwUNxVmxn7DEfjSz0LGNqetRD2ZS3ipy9utpiebt6mnkl2sxLTsv
x3YFa8CEsa4myqok4dSuNpLWXI2IAnchgkVJ05Z8bcnViChxuYom4nUfT+VqYtTVAtxMXM2A
WVT+gE4WY9i8O7s5GdugKbvQmVAhmpC0QyOiQlQx9RaNSMaal/GcgHsZJsoGLxO0gPikCpHX
tx+pvIwsuVkAHFFU0QKDNGVbb+a1Y9aJq/PWZafAPCMyCAF+KreO7r5IJaH367YkW6DzHk/t
xRYr6DPfGayatF2Wx1s8SDof6RdacKlUOoIWpmP4Vo51rVvt1LrHZxBqneZptdvod8/b/U6t
Uat250mVVtFmYV9v/n7cQLm6fa9b5hDp7s10TG0/Eu2u4/jlkk/dsWmPnPJ9+d5nHsoCtc1D
fiv2SERbIq8EyaSNjsgYoQDBL7M3FSJfgeC/FlibIPBZ3M/FOdozfy/q4+chNRC/QLkfZX14
rweMIUnQTpIiamabpDj2iX5GmFqBQHOBRJuDNYlzy2xcyF4ASrAfgzdVjX8FkNxQEjV0JoBD
QpRmY8MGCv/9GpfWQZlwyJRB2s2KCCBAudBI7H0wP0zIh+E/PkyED8PwM/EmKD/D279mjCsH
jCsvcDYOQOAAS7IbIgFk09BHECZChmGSElF4LSIOs21NlWAtCNvrAs6v9ydetgLWx8tqgaz6
suzmXj2dQOKKnInj+cj0zBtkGrrt2Igat05kvZyf80BEm/Zk6rvG4YsLr6qR6KIbIYUFxNpm
YWW78AuKNkBFdGM5A91Csw8CL2WaQAcrUnnTvFsBRS6sms22gVMdt/1wTZ+CL20800SkFAap
KL8kV8IHnCXlhZ+ue4qhDqJetdE5FyZWncmja97c+qy/lfnF2rgdoUqkEYJ4RhvZbyGcq+aZ
uMiKhAYw01tis/08KbAGMq/ENmKstQO6MEMX9oEuztDFfaDDaYIEZXwTth5uCz6AE3Nh8Jgk
ztbKbaE/67YHdkOZud1tHlIw6GpYjWnICGRbfMs0qO2Z9g0E0/wiy2C6ce6pa1O4FaDN6utN
j5D2B5zaaxukD5KRo8Ih+7HE6sYrV1sXV/XmpxLfisV+E2w5BfImtr1CONV+YiCOUuxQ1pl/
IIlaeuY/YQvOHfAPr2TNP7D0QxxDmXkch/f/JCgzB/9hWhaAQ5k9c1IeXglDslN4TT06hAiR
eSXr+XyFz6e/1foniJJZR2ReyXyVLimlStE1SHE8FqGhuPRJfrnh1tskE5ZUwUxYUHfyuiGF
g6/A8yrziyyXvFd43nwHv3geYCUtOWl8YWmJgnla4jKxo7F+R1mZg+wpX4jLcjIFW8U4rbdX
blECmf1f2DHyOBxbwCHJgoP4p1Hff5wworhot6r9zuVFrd0/P/5Ur7LvR/0BNys4J2RXsFp5
R5jXRy6lYVW/100rqENOFkqMFhIjzxwePUHi/BMugawsah8J0Hf2rTvXso9+h1kv9Lk8dqa2
7yVnvRvPtKVoap10mp3FmWp4o3SegkNyPPJQGYUV9wfCCF/bfHjgsyCZJVjgR1iiKs5HMGgx
T6gNWVk+C0r9nMlcZTxkWrzQExOsS4/HVsBN3U2Nx7o78TMcP388ydQ+27FpluPHvLdEFK1E
SuS38q0zXgXfyl9YdEyoWx6OE8JYigljQRZXA3n5SFNIyK3TH2nG3LuAKI5ZSPHB1DfHNDxD
G/s6PBIHcR8ruw8Wi+iNoTCU+skOtfKGPLbkXGPbL4/KVLxjwzMwdZvRW3jDgGcWbF+kVuLd
crXlji76FwX9RUHbUFByBrxfCgqZIEoqQAVf28+tfuO4/al2Vm/U8puZIAXx9C3Lo/QOIJh4
D38voE6t9qVfvWznV01bkSVYFVWJaII0a1RrnubjZee4LBtdw/0TJKvt+ePS4flm3PK0w/nm
HvPIGyc4NpV5Jes823fAcN/Zg+F7PNExWKT7/KxXDavZTqcDq5bg2HswfcEMcDBASOR6lejJ
Pg9tXdhj3MDqOta9u1yn/ql/0mhVv7Bgrze78KMB9tKip1Gxd2EHwuDVd2GTZbO5C7s/uG+t
ZjWuYTFsWczKkiTAmNliwOfHnS/BRIW7wqiwbvimY4Mom0+mi69eBh0ZRtAEkv0nADo9a/ws
BA9tqSMMz/XheJxurX2eCdC/L+vZWHTcyMiibqd7kQ1Qt3WZEVC9mQnQ13qz+nmONMIV6bVI
kTvVV9QrN538b5yF8OJybTNJYn01ZJbAS0NiWezYWJwcXm1+aGaZ3rjw1UYu3MoImsYILpy4
uG1vhJfGCC6cuOvY3ohr98WnuPa/2mRFnq8g8jdZUDIg8UW8xjLD60l8d6CQxHcHCkk8g64F
JJ4BUEDiWQBxEt8daEbia0jLfB6DlCo5M1SMX0zO/keyVn5UGHs6uEZfbIwV9tJIKgUBQYaP
1G7xv3zeBmVUfXAzqgfFuhH7Vx8cQPageA/1RBDg9liPl6sGvIF6RdQg7Hj59uoFLGngfrx8
B/XBrzN7vHwH9Zqigu/x8u3Vi4IK6W+Pl++gXuE/Vunx8u3VwzUOeecdXE+SscxpD8p3UB/8
IqnHy7dXL4uCBK7Hy3dQr4pwd6rHy7dXrxD+a8ceL99IfbFYRGzPdXLZQbmTqYeo6zpuHv0T
YQQ/YGJfH3z8+BHdmZZFh2jwOBNmHx78Fw8SKizhQwAA

--UPT3ojh+0CqEDtpF--
