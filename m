Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130929AbRAaHCS>; Wed, 31 Jan 2001 02:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRAaHCJ>; Wed, 31 Jan 2001 02:02:09 -0500
Received: from mail2.bigmailbox.com ([209.132.220.33]:50181 "EHLO
	mail2.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S130929AbRAaHBz>; Wed, 31 Jan 2001 02:01:55 -0500
Date: Tue, 30 Jan 2001 23:01:49 -0800
Message-Id: <200101310701.XAA05732@mail2.bigmailbox.com>
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [24.5.157.48]
From: "Quim K Holland" <qkholland@my-deja.com>
To: linux-kernel@vger.kernel.org
Cc: jukka.santala@kolumbus.fi
Subject: Re: 2.4.X inode cache bug
Content-Type: multipart/mixed; boundary="----------=_980924509-5642-0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_980924509-5642-0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary

In <200101310202.EAA11357@smtp2.kolumbus.fi>, jukka.santala@kolumbus.fi
writes:

> Excuse me for the lack of patch in this mail,...
> In 2.4.x, linux/fs/inode.c has a hash() function with a small
> slip-up.  The inode hash-value is initialized with "unsigned
> long tmp = i_ino | ((unsigned long) sb / L1_CACHE_BYTES);".
> ... I believe this is a
> slip-up, because you should NEVER use bitwise-or in a hash
> formula. This creates a slanted distribution, and depending on
> the address of the superblock block, can cause severe
> inefficiency in the code.
> Just replacing the | with ^ imroves hash-table efficiency
> noticeably,...

Then maybe the attached patch is what you want?  This also replaces
`+' on the next line with `^' to avoid slanted distribution.


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/



------------=_980924509-5642-0
Content-Type: application/octet-stream; name="jukka.patch"
Content-Disposition: inline; filename="jukka.patch"
Content-Transfer-Encoding: base64

LS0tIDIuNC4xL2ZzL2lub2RlLmMJTW9uIEphbiAxNSAxODoyMDoxNCAyMDAx
CisrKyAyLjQuMS9mcy9pbm9kZS5jCVR1ZSBKYW4gMzAgMjI6NTQ6NDIgMjAw
MQpAQCAtNzI4LDggKzcyOCw4IEBACiAKIHN0YXRpYyBpbmxpbmUgdW5zaWdu
ZWQgbG9uZyBoYXNoKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVk
IGxvbmcgaV9pbm8pCiB7Ci0JdW5zaWduZWQgbG9uZyB0bXAgPSBpX2lubyB8
ICgodW5zaWduZWQgbG9uZykgc2IgLyBMMV9DQUNIRV9CWVRFUyk7Ci0JdG1w
ID0gdG1wICsgKHRtcCA+PiBJX0hBU0hCSVRTKSArICh0bXAgPj4gSV9IQVNI
QklUUyoyKTsKKwl1bnNpZ25lZCBsb25nIHRtcCA9IGlfaW5vIF4gKCh1bnNp
Z25lZCBsb25nKSBzYiAvIEwxX0NBQ0hFX0JZVEVTKTsKKwl0bXAgPSB0bXAg
XiAodG1wID4+IElfSEFTSEJJVFMpIF4gKHRtcCA+PiBJX0hBU0hCSVRTKjIp
OwogCXJldHVybiB0bXAgJiBJX0hBU0hNQVNLOwogfQo=

------------=_980924509-5642-0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
