Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWDMDZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWDMDZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 23:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWDMDZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 23:25:21 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:7897 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932436AbWDMDZV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 23:25:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=os85sT3+y3y/m+5t5g2F1R72ychXxlqkHQEP3UFsGVJ8p2w1UxFVs332iYDx0CHOCr9hB6/fWbSROTjw6++PrarEmsnublGFnjGuncacx8N4yhzo01m0havf4Nk1tp7gyT5G7aFOG+k11FPxNOWO3c9I8K/yPkPcvfWv75w2ReI=
Message-ID: <16e19f4b0604122025s310f1989j1c301dd5d90f5059@mail.gmail.com>
Date: Wed, 12 Apr 2006 21:25:19 -0600
From: "jgmtfia Mr" <jgmtfia@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: NFS data corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When transferring from a 2.6.16 nfs client to a 2.6.16.1 server I get
data corruption.  There is no indication of any problems in any log on
the client or server.  It does *not* happen when transferring from
server to client.

The server configuration:
/nfs 192.168.2.0/255.255.255.0(rw,sync,anonuid=1000,anongid=1000)

Client reports (via mount)
192.168.2.28:/nfs on /home/user/mnt type nfs (rw,addr=192.168.2.28)

What information can I provide to be helpful?  The following is a diff
of a 300k that was transferred from client to server:

< 0000b00 6d6a 3b59 b76d 5b2e 1ead 7062 96c4 307e
> 0000b00 6d6a ff6a b76d 5b2e 1ead 7062 96c4 307e

< 0001c50 9856 956f abe8 0e7e bab3 70d4 4be7 486a
> 0001c50 9856 956f abe8 0e7e bab3 fbc7 4be7 486a

< 0002db0 7dac 45ed 761b c413 eebf f78b 1814 04ec
> 0002db0 7dac 8dbf 761b c413 eebf f78b 1814 04ec

< 0003f00 f664 15ca 1dcf 22d8 d71b 6d25 0781 cc4f
> 0003f00 f664 15ca 1dcf 22d8 d71b 0edd 0781 cc4f

< 0004a90 4100 0311 b5c9 eaf6 2aa2 9261 eb0b 1e2c
> 0004a90 4100 0311 b5c9 eaf6 2aa2 d84d eb0b 1e2c

< 0005bf0 2d2d a568 6829 9ad1 175b 5295 5a90 375b
> 0005bf0 2d2d ea35 6829 9ad1 175b 5295 5a90 375b

< 0006d40 1917 9d69 95c6 8659 9689 6bef a84e 027e
> 0006d40 1917 9d69 95c6 8659 9689 1d15 a84e 027e

< 0008b00 5d84 8c34 1a49 6228 c819 5686 d920 5c12
> 0008b00 5d84 691c 1a49 6228 c819 5686 d920 5c12

< 0009c50 fd40 5b80 9bc5 ab59 3feb 4cec c2d6 a56e
> 0009c50 fd40 5b80 9bc5 ab59 3feb 45cf c2d6 a56e

< 000adb0 5233 d96d cd47 eda1 63c7 0996 b529 c63b
> 000adb0 5233 240f cd47 eda1 63c7 0996 b529 c63b

< 000bf00 bb86 792e d6ce fe51 a70e 27fb e93d 90aa
> 000bf00 bb86 792e d6ce fe51 a70e 6ec5 e93d 90aa

< 000ca90 98e1 8b5e 8a92 b769 64f3 a022 1f9a f263
> 000ca90 98e1 8b5e 8a92 b769 64f3 bde9 1f9a f263

< 000dbf0 e9c2 09e5 54fe 3042 d70c 7c28 b649 4e70
> 000dbf0 e9c2 ebb5 54fe 3042 d70c 7c28 b649 4e70

< 000ed40 e41c 65db 5555 96e7 aaaa aaaa 2aaa aaaa
> 000ed40 e41c 65db 5555 96e7 aaaa f617 2aaa aaaa

< 0010b00 348f de0b b494 a54a 4118 4301 cf82 310f
> 0010b00 348f b4e5 b494 a54a 4118 4301 cf82 310f

< 0011c50 aaab 4c57 66cf 2a66 50eb 4c18 b182 b43d
> 0011c50 aaab 4c57 66cf 2a66 50eb 8e45 b182 b43d

< 0012db0 21fa 7596 83bc d26d 583b f301 92dd 2821
> 0012db0 21fa 3a5b 83bc d26d 583b f301 92dd 2821

< 0013f00 0982 aca0 21b5 d08a e108 d2eb bfb1 00b5
> 0013f00 0982 aca0 21b5 d08a e108 9b02 bfb1 00b5

< 0014a90 93c6 8706 e782 f4bc 3407 3465 e88d 742c
> 0014a90 93c6 8706 e782 f4bc 3407 0465 e88d 742c

< 0015bf0 caca 58d0 6045 ec4a 2256 5789 be62 15c4
> 0015bf0 caca bf4c 6045 ec4a 2256 5789 be62 15c4

< 0016d40 ea4c 7471 df05 316a bb27 c1e0 d77f d220
> 0016d40 ea4c 7471 df05 316a bb27 70a5 d77f d220

< 0018b00 7ab9 9387 dddd 10ca 277b 1981 efbf 2eb6
> 0018b00 7ab9 fb6e dddd 10ca 277b 1981 efbf 2eb6

< 0019c50 9093 3b17 dd9a 195e a4dd 1013 062b 0002
> 0019c50 9093 3b17 dd9a 195e a4dd 851e 062b 0002

< 001adb0 d38f c17d 7dd2 0636 28f2 4f7c 6772 d2c1
> 001adb0 d38f 0aea 7dd2 0636 28f2 4f7c 6772 d2c1

< 001b940 8700 0349 3bc6 effe ddcf c7e2 5dbb fb2c
> 001b940 8700 d09f 3bc6 effe ddcf c7e2 5dbb fb2c
