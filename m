Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUAZRkN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 12:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUAZRkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 12:40:13 -0500
Received: from 213-84-216-119.adsl.xs4all.nl ([213.84.216.119]:45698 "EHLO
	morannon.frodo.local") by vger.kernel.org with ESMTP
	id S264546AbUAZRkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 12:40:04 -0500
From: Frodo Looijaard <frodol@dds.nl>
Date: Mon, 26 Jan 2004 18:39:49 +0100
To: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       linux-7110-psion@lists.sourceforge.net
Subject: PATCH to access old-style FAT fs
Message-ID: <20040126173949.GA788@frodo.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I have created and attached a new version of my old-style FAT filesystem
patch, this time for the 2.6.0 kernel. It can also be found on
http://debian.frodo.looijaard.name/. 

Some old implementation of the FAT standard mark the end of the
directory file index by inserting a filename beginning with a byte 00.
All entries after it should be ignored, even though they are not marked
as deleted. At least some EPOC releases (an OS used on Psion PDAs, for
example) still use this policy.

The included patch adds the `oldfat' mount option for FAT-based
filesystems. Without it, doing an 'ls' on old-style FATs will show a lot
of garbage, both old files that have been deleted, and bogus entries
that have never been filled.

If you do not use the `oldfat' mount option, FAT filesystems should work
exactly as before. I have been very careful not to change the logic of
the FAT driver, in order not to break anything. In fact, the patch could
probably be optimized a bit, but I wanted to keep it as risk-free as
possible.

It should be safe to mount a normal FAT filesystem with the `oldfat'
mount option. I have been doing that on and off with some local Win98
filesystems without any trouble. Actually, the only reason I have
introduced the mount option is to keep the new logic strictly seperated
from the old driver.

All feedback would be very welcome. This patch is released under the
GPL. Feel free to include it in stock kernels.

Debian users can install the .deb on http://debian.frodo.looijaard.name
and have the patch applied automatically when compiling 2.6.x kernels.

Thanks,
  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

--ZGiS0Q5IWpPtfppv
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="linux-fat-2.6.0.patch.gz"
Content-Transfer-Encoding: base64

H4sICIdPFUAAA2xpbnV4LWZhdC0yLjYuMC5wYXRjaADNV1tv2zYUfnZ+xWkGpL5Itny/FEnT
Lm5RIGmGJt3LMAiyRMVaZMogqThB6/32nUOKtmM7Xdr1YXqIIvLw47l852LXdeGWCc5SV2a5
CJnbqvfqXj1Lo0YsG3GgGlEi6mGp5Xkd12u6rS60mqO2N+q26559oOY1Pe+gVqvtA3saqDVq
Dkbt/g7Q6Sm4zWHH6UCNXj04PT2AUsIVhNPUgcSBvxxIA6n83AHBJByD9wol0iyOfQWJP8+k
AyH+NTs1fRZtQjVw5eLq7PLKv3pblpOKe5LNVZJxWTfbVlijM67EQwGO8ItpkrJyswJftIZo
CWnY8lrOQGs4D4RkvmBhJqIRyqM+/MaXaaZWepSSGMqFIkdHUI6Ye8KDGfvD+xOOj2F8eea/
O3/zvlIBEi490qK5AlgvV7RYmHGV8JyRD7TAFuzZ+Hx8PS6gSWbjhLakO9SW9LqFJSV6bjKV
FTaRIRq8tNQXPtcKLbzPir1mPLbjeYZsWdLutcmSdr9tWbPLiVcFlwRTP4se0KjCJU8fIJcs
gsWUcQuXSFAiZ1Bt4K1anfDWN0lSrhQ6D7XOHW/lfUT7dcrCW4gzAeR7iJF55Acwd2o08k8i
7/AWYuR3cOt7qKVJ8ImFYx49n12PDpGJHUOwTn+TYFrqN+LXuaXX8v9tRm84IDP6zcFmTRLZ
gjAlxjlUMMnjmAl/yoIIqpwt/Mn0aYZhSXRPEv876xAyWmruhrkQZpm063tDp4/atZtOyyu8
vMQDrjH3w5X/7tN4XC5XI1YxlleIOG6RarUaGkKO0AWrYj25GYqNozvReGY44OtXeEqT2n5N
ip3tuNplypYPMSwoN8Is54oJCDb85uBWIQlV4AwTFMM6C8QtqKlNqCCmY/i9lsw4I8EJg4RL
JhSeC+QG7gZmtnhBKWkWSE10mH/DCkGKsnNEsXImUydijq5FFTjBJre2orTt3KJh0EPK+gnP
IuYjltKIFbtrKjJFml5Y1HKB1UdTxIjonSWwVDK8jaS0e1e06Q2dLtQGXscZ2twE8xSUnsko
k3RzEcIqaor91xTWqrHmQBvyAyy3fXWf00DXbHQa0IXWbaj5/oL3LXpqTxTOcccfL8cfr3Uh
QPLEglka2HK7UWpx6S5Lc/xOgwlLTenVN7/Yx2NS5IVdCZQScARvrq8/+b9fnn++GKMi7r+P
XDrUP2foegKqNersQplRoKtHAXx1DRsu58qX00woss9fJJwrBx4vzpJ7FpnFXMUDn2cbHw9M
OgVMzhP/Pl1vm08S0N884/lMBclaYr2iUWoaxUTcYmYTmaWBYuYAwyQ7gGUx1vR72pZ+39ry
hWQiNslvHDjU78OlY9eT2SxXwSRFqEP5INffJFMzMsXdcGj+2Ti91uMQR5K740nCA/HwDQHF
7vV53R9bfd0fW8N1f8RMke5JiOGbBzcM88mkjpmNJoIFtzq9wwDTeq3aSBPdnF1lYjFz2UO6
iRDzdWKDnLMwiZOQqP0tciY8TPOINVIct+4bpijEsj7d4lanP2o/n6bPBR2Mmp29hO1ovnYs
XQ/gl4jFCdbuzX4O3j3r0pBGlVTqaYqKecRSpuzAlnCwlYNquYWxJQQh8N4VBOMRFlnAKsVC
lWGd2Mag0Q29BhgBqYuGBbRVg1ewhFTphS1Rv3eHkB+IB5bZHe+12yOv+x9DsouLv966o/Zw
fxnpUE9prX67laBI5FHTKZoLuvIsYxQMIRUEaYIBmQZ3GBiSZQIJ+fLv5ktQD3NsxHj0dVF7
IVCBSNZAGuozZsEbWof34wvsO3CH/weUMBSmiyuX1mIdCZe0yShvRs1XpbUiaorDup4PdE5R
kjIhEeE1eMf71k3LX2E5PwGrSGKr1zs79ks0DX/m3MAiUVNDxW0eGvcsaUT8Bz8lOYXWDwAA

--ZGiS0Q5IWpPtfppv--
