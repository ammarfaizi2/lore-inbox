Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279902AbRKNAjg>; Tue, 13 Nov 2001 19:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279901AbRKNAj1>; Tue, 13 Nov 2001 19:39:27 -0500
Received: from mailg.telia.com ([194.22.194.26]:47045 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S279893AbRKNAjP>;
	Tue, 13 Nov 2001 19:39:15 -0500
Message-Id: <200111140038.fAE0ctq11703@mailg.telia.com>
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: linux readahead setting?
Date: Wed, 14 Nov 2001 01:37:05 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net>
Cc: Andre Hedrick <andre@linux-ide.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TPLRJJPFNRPIZSC0DEI8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_TPLRJJPFNRPIZSC0DEI8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tuesday 13 November 2001 16:21, Roy Sigurd Karlsbakk wrote:
> Hi
>
> I heard linux does <= 32 page readahead from block devices
> (scsi/ide/que?). Is there a way to double this? I want to read 256kB
> chunks from the SCSI drives, as to get the best speed. These numbers are
> based on some testing and information I've got from Compaq's storage guys.
>
> roy

Note that the interface to /proc/ide/hdX/settings still is buggy...

i.e you should be able to do (in pages):
echo "file_readahead:64" > /proc/ide/hdX/settings
but the result will be a readahead of 128*1024 PAGES... and that
is too much... (even 1024 PAGES is too much)

(after patch, in kB)
echo "file_readahead:256" > /proc/ide/hdX/settings

It is likely that there are more settings in the ide subsystem that is
has this fault... (Andre, I keep repeating myself...)

/RogerL
-- 
Roger Larsson
Skellefteå
Sweden

--------------Boundary-00=_TPLRJJPFNRPIZSC0DEI8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.4.11-pre2-ide_settings"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-2.4.11-pre2-ide_settings"

KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgpQYXRjaCBwcmVwYXJl
ZCBieTogcm9nZXIubGFyc3NvbkBub3JyYW4ubmV0Ck5hbWUgb2YgZmlsZTogL2hvbWUvcm9nZXIv
cGF0Y2hlcy9wYXRjaC0yLjQuMTEtcHJlMi1pZGVfc2V0dGluZ3MKCi0tLSBsaW51eC9kcml2ZXJz
L2lkZS9pZGUtZGlzay5jLm9yaWcJVHVlIE9jdCAgMiAwMTowNTo0MSAyMDAxCisrKyBsaW51eC9k
cml2ZXJzL2lkZS9pZGUtZGlzay5jCVRodSBPY3QgIDQgMjE6MTU6MzYgMjAwMQpAQCAtNjkwLDcg
KzY5MCw3IEBACiAJaWRlX2FkZF9zZXR0aW5nKGRyaXZlLAkibXVsdGNvdW50IiwJCWlkID8gU0VU
VElOR19SVyA6IFNFVFRJTkdfUkVBRCwJCQlIRElPX0dFVF9NVUxUQ09VTlQsCUhESU9fU0VUX01V
TFRDT1VOVCwJVFlQRV9CWVRFLAkwLAlpZCA/IGlkLT5tYXhfbXVsdHNlY3QgOiAwLAkxLAkyLAkm
ZHJpdmUtPm11bHRfY291bnQsCQlzZXRfbXVsdGNvdW50KTsKIAlpZGVfYWRkX3NldHRpbmcoZHJp
dmUsCSJub3dlcnIiLAkJU0VUVElOR19SVywJCQkJCUhESU9fR0VUX05PV0VSUiwJSERJT19TRVRf
Tk9XRVJSLAlUWVBFX0JZVEUsCTAsCTEsCQkJCTEsCTEsCSZkcml2ZS0+bm93ZXJyLAkJCXNldF9u
b3dlcnIpOwogCWlkZV9hZGRfc2V0dGluZyhkcml2ZSwJImJyZWFkYV9yZWFkYWhlYWQiLAlTRVRU
SU5HX1JXLAkJCQkJQkxLUkFHRVQsCQlCTEtSQVNFVCwJCVRZUEVfSU5ULAkwLAkyNTUsCQkJCTEs
CTIsCSZyZWFkX2FoZWFkW21ham9yXSwJCU5VTEwpOwotCWlkZV9hZGRfc2V0dGluZyhkcml2ZSwJ
ImZpbGVfcmVhZGFoZWFkIiwJU0VUVElOR19SVywJCQkJCUJMS0ZSQUdFVCwJCUJMS0ZSQVNFVCwJ
CVRZUEVfSU5UQSwJMCwJSU5UX01BWCwJCQkxLAkxMDI0LAkmbWF4X3JlYWRhaGVhZFttYWpvcl1b
bWlub3JdLAlOVUxMKTsKKwlpZGVfYWRkX3NldHRpbmcoZHJpdmUsCSJmaWxlX3JlYWRhaGVhZCIs
CVNFVFRJTkdfUlcsCQkJCQlCTEtGUkFHRVQsCQlCTEtGUkFTRVQsCQlUWVBFX0lOVEEsCTAsCTQw
OTYsCQkJUEFHRV9TSVpFLAkxMDI0LAkmbWF4X3JlYWRhaGVhZFttYWpvcl1bbWlub3JdLAlOVUxM
KTsKIAlpZGVfYWRkX3NldHRpbmcoZHJpdmUsCSJtYXhfa2JfcGVyX3JlcXVlc3QiLAlTRVRUSU5H
X1JXLAkJCQkJQkxLU0VDVEdFVCwJCUJMS1NFQ1RTRVQsCQlUWVBFX0lOVEEsCTEsCTI1NSwJCQkJ
MSwJMiwJJm1heF9zZWN0b3JzW21ham9yXVttaW5vcl0sCU5VTEwpOwogCWlkZV9hZGRfc2V0dGlu
Zyhkcml2ZSwJImx1biIsCQkJU0VUVElOR19SVywJCQkJCS0xLAkJCS0xLAkJCVRZUEVfSU5ULAkw
LAk3LAkJCQkxLAkxLAkmZHJpdmUtPmx1biwJCQlOVUxMKTsKIAlpZGVfYWRkX3NldHRpbmcoZHJp
dmUsCSJmYWlsdXJlcyIsCQlTRVRUSU5HX1JXLAkJCQkJLTEsCQkJLTEsCQkJVFlQRV9JTlQsCTAs
CTY1NTM1LAkJCQkxLAkxLAkmZHJpdmUtPmZhaWx1cmVzLAkJTlVMTCk7Cg==

--------------Boundary-00=_TPLRJJPFNRPIZSC0DEI8--
