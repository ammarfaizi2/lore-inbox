Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264832AbRFSXZM>; Tue, 19 Jun 2001 19:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264833AbRFSXZD>; Tue, 19 Jun 2001 19:25:03 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:19981 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S264832AbRFSXYr>; Tue, 19 Jun 2001 19:24:47 -0400
Reply-To: <martin.frey@compaq.com>
From: "Martin Frey" <frey@scs.ch>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <zippel@linux-m68k.org>,
        <tigran@veritas.com>, <hch@caldera.de>, <asun@cobaltnet.com>,
        <mikulas@artax.karlin.mff.cuni.cz>, <jffs-dev@axis.com>,
        <dwmw2@infradead.org>, <trond.myklebust@fys.uio.no>,
        <aia21@cus.cam.ac.uk>, <reiserfs-dev@namesys.com>
Cc: <baettig@scs.ch>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] large offset llseek breaks for device special files on ac series
Date: Tue, 19 Jun 2001 19:24:22 -0400
Message-ID: <015e01c0f916$f9e33e30$0100007f@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_015F_01C0F8F5.72D19E30"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <E15CSrl-0006jf-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_015F_01C0F8F5.72D19E30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear all,

The ac-kernel series include a check in default_llseek()
to not set the file position beyond the file systems
maximum file size.
This check should be done only for regular files, e.g. for
a device special file the test does not make sense.

Alan suggested that we remove the check from
the default_llseek method and introduce a
generic_file_llseek() method that checks the maximum
file size. The generic_file_llseek() method needs
to be put in all file systems in order to test
for the maximum file size.

I send the mail with the patch to all maintainers
of file systems, please comment.

Here is the patch. I put the generic_file_llseek
into adfs, affs, bfs, coda, ext2, fat, free_vxfs,
hfs, hpfs, jffs, jffs2, minix, ncpfs, nfs,
ntfs, openpromfs, qnx4, ramfs, reiserfs, smbfs,
sysv, and udf.
hfs got two additional llseek methods for the
metadata, same for openpromfs.

The patch applies to 2.4.5 ac 16.

The cmsfs directory produces an object file with
the wrong name, the patch fixes the cmsfs/Makefile
do produce the right object file.

Especially the hfs and openpromfs modifications
should be checked.

I did not touch the other file systems, there is
either no file read or write, or a fix is not
straight forward. I did not modifiy the proc file system,
the llseek problem should be fixed there in a more
general way.

Regards, Martin
------=_NextPart_000_015F_01C0F8F5.72D19E30
Content-Type: application/x-gzip;
	name="patch-fs.2.4.5.ac16.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="patch-fs.2.4.5.ac16.gz"

H4sICETZLzsAA3BhdGNoLWZzLjIuNC41LmFjMTYA5Zvrc6M4EsA/23+FdvdqK4kfMRj8IJPUpGYm
c9ndJHtJ9nbuE4WxGDMx4AWciW8r//u1JB4CI5DzuLq5daXAkZqW0E9qtVry3HUc1Fuj3iXqzVAv
REvXXz/01L7W1/uWrYwOnejQmsPFcZe4b2/l91dWbC/wvCTX7vV6Tbpav+M5usErpI6RMjI0xRgO
kToYDNqdTke2oNbtGqOf1j5SpkiZGNrYGIyJEqX99i3qqdPuCHXgOkZv37bRD65vL9dzjL4nGvqL
79uojaI4XNsxIurMYIVDK3YDP0JEwiwnHqM/253WchlhfGe0Wp+xj0PXZmIstdtGrRBb83IuSSN5
nmetynkkjeQ50ca3IZMm0n+67bkUIEcSkCMBKJdpnYUuOl2F0J5ooBg6tO2ItW0jIKcGkDrKAWk6
AQRXBiiKoaFt5PoxIirSpltiK8J7CSjXD4DgAb11eXroAK6r/aM6qM6rQP0aujGGzFw9TannLUV2
Jgd21sw1F2ldBD56j22ENKSqxkA1NF1u3M1qqGocVYUOOyUbdtiHl63BMmuigmqh1DEp5JWoPBWK
7UVwvbDuMO12dS1WFBXCKYoVGlc3FMVQJ3LjrkbPxBhOC5DGQKczThHBH7oMYozU79DtAqN3Z7+c
frxBc1Dku8ngCTHyg68wAFEMEp4FX7ykqD7Q7V2Zt6fXHz/cIuMYQU36QbtTSnJIIvSDYPalt0Hw
SZPvWQ5J95L0v+2lD+9LYgnmlsxg4eTEQHIZOk1RK6hDQxrQkLomSYNTUhovEwNsaj5NDUd0noIb
w/FYM1iI1le0Ybn6l7Jh+CFWZbhwckIunMz2KBmqclxESiiXIec+DKkdG6Z2DB3Qjk8ep1SiTRRj
r08yDoW4iPQr4qq2b25gx0vIpYXTfyRZOVYsgyoXE5LKRSpASQ4ggQ7gNDUGCjd+NDp8tNSYUauF
0a8hOBJ3ew/7aEW/oYeaYQVlPQ9TpqCMKMt4qQHlhBjfP8AXcjGpI9TEq+oJMboq6QqKuiTFRnUU
qDrk3MIxdQvT2Qm6MQ59xDuAPCam1/Pw3Iw2HlTlDvr8KkocQepRCqDTJ6up9xlgdCzk3iegSX71
CO0TotvZibP/eCTHeiHnAOZiQqq5CG37MzxDyhApY0MZJg5gM8qSjgK/guFUqeFUE36HB8elD/q4
DGbWEt1boWvNwJSisgQxqcLBuniuG7/IFxfFwbp4aQ8+bTLTtlaSEJloI0gm9nyYnJ4cqD4wBjpn
YYln0oHrpLiQfkMLOKStBgvqE8KsgvZZEH61wjm4k/bSyoBtE++1O8mAXQaOY8aIfqB+YDacIMG4
V1jzdRPRbruDmj8wDZAFYlIIqXb4NcQxlJQVQnpEuQh7YYVwh94An+QxK/wMpaYVPWhSS/vTll5o
hzjTzi2IR685crI6iUdPqcm5kVNop4LjWHhTUTyDvONkSN5xonfVKX1JOuhW69j0l3vkq2fGgbmI
XQ/vYT8ON70TGwqLsTmHy34XeTi2eieOa9pEhjR8swYvgNG62dLgVWl499v19YfLW/P2/OJDV9CR
Mg3rREPnsd0p997ajkuuWfeBa4ShN5HIRxC6n11/v92hRAL/M6IX6E/31vKIlNKKvrowjNFeIkrZ
AYAIlm8G+dpi+lDnmBYGFTXnSUPM2QzcO3HNyP03PqLiM2jfu6NMiSJSsgoiIgWv2mLVgX7T+3B+
+c/TX0i660CV6EMnxwP044/Ja705/vvZjXl2df2zeXH6KaltLou+KxSQ5Le4JCiFiR4VckgPtCBv
UEy+x2EEfRoyOh18D69Ns0md80rn6pJ3WYN/kbYwW34dHuxo4BfzUNbAU9FmA0/FXsDA53o4A6+A
qsJSB/4lax1FKzrR11fvr27OzdPfPt3+69cP5vvzazR4GMCDr2Lroar1Zr7GhJNna6z3Tnab6JIw
2WRCYPUW6X4VC05qJzbeeRvyHk/SOAVnJ33JOms91AbUmdOUzF63Elsys+y79YoaVahD7K2IIW2x
KSY2PSu8M+duGG+YEaZm9jExlEkTiXD/hYxjQx3+78zlCi4ya1ZeUGwqOaGKFarkdoVQCzWTwwkX
2aYLGyVd2DStL4nidKECWNovFvbJFb/UOuWLk7ZB714dNrApCwv5lAUrGEmGtms1ASfVULmIkKJP
aEyI3uVYfancGyoiqyKGoOujJFhADDfjh9A2PzJPgCwNG1BJRhNVxPCYJP3ORFlEj1WSBfQ4ZxRE
aRoRlYYtFZPlBWshi6OymmRUVqiFwtU4X0WnaHUerJBoRexVbhTCE345l6Q9JzArxcZzffdBhg0v
KGTDC1WwmcqxEWqhbHQu8qPQnQwlXb+SKZs+bBKHgjZG2aFK/mXTH0lIHDwhVqbvvx1Sf6Z59e2V
XCSPFxRS5YXoLj1ZHyDgoRnq1NAkw+sFLSWqQ0OZcuEfZk3VSeOYA51PHXEJm0xDmUuWsbXNQXJ2
2eXwJVFIgCg24IW1QaqKFJiMRtKHJfwaCHxQVaO+h6Zun5VAfv1ZidIxidrR5T83tOqLQqu+yGXJ
MnYZTzFptaiJYColBphKbBtHfSjJr1IF2SbOugDDx0J7ql7c5K3zSYjqMg3TD9jOwk5QiKIEyA+u
A2t79O7q8uz8o3l5e3ZjXv/OcyKyCSM63Y5oxfXR6HkVf3qN605NVb+NVB8i0/kqDDzJBcm2uLBX
bYu2bqBf0CjOhBy60aaGLhnFqdC11c/SDVWCi9EaZdHVIqh0ms21mssggFW8yGSkD8yzNTxneDgt
a59svCF5NVkMgEj6a++vHgeY/u+v9GnoJutQpGU4fNuRNwaPhcpmayePliVP2sHa56JlK/KOxFWg
RkcfdRUVrM44i0hKmB2uP8JtxVbdu1gd8hQO483W5JVlZJNXMtUa/DM0he3u7lLXtAkrqlscHLx9
5Jo9LVHK6v3hP2gy3g8nJ7RznEzrxoqpgSPHO8FxGSYHcZtPFfJKSpZNrzvmUXfqhuhs9EMb+kLl
KqE43fzj8pNWnj6fvvILLdmpqCAppFOQqvBvxnITkFgNJaRwLupoRLf2yC1xFSQGAtX/ra3nSCFM
WRMqTlBMihOqACUZIhNqoZw0nQ+PseBY+Vz8GyvyDteWbeMo3c0XQEvbLQxMZ2cru+vJeOhFyfgn
hxDSWqezE8ytN+/Pr5NAdC+ZTmCUWutl/ESvIsmreI0dNUGzoAr/BLGtFXrMaTjJNlYe2VuVfAYk
3litc1xmvZPI9KyH2SbG0TfiXHRehN437BOiE2jZfdpr6mEhISxUDUvSrLkRDuXCIyXZGuNWkGvd
LtbsPPUIkc1szVAGsvatpKho4kaGOuV3algkUpU5U51qrp6FiMtatwPQpkF48W8RyKfu5wj0YBIL
ZWUV2SWcFXmSPxPhBYW4eKEsqKXo9CdaA+lV65aWAqh0T4AZQToZkVtDbBF0PjO2mGko+whZxlZs
keTsBGMT3UuxyOXEKHKZbfdak/yxHK9kC4TO7W2qCnWvleJpdztYyB92J2V9a57ceu7I8MrFhLhy
ERrt+cnykToh40adGAPJnRZORwnWuHheR52wI7YTCfMGSpuoNC6Gqsmko6TVImUk4yTbPGOp5B/6
VLf9H9BDFodvOgAA

------=_NextPart_000_015F_01C0F8F5.72D19E30--

