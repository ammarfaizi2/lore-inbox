Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUCDPVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUCDPVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:21:42 -0500
Received: from mxrelay.osnanet.de ([212.95.97.103]:54205 "EHLO
	mxrelay.osnanet.de") by vger.kernel.org with ESMTP id S261862AbUCDPVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:21:32 -0500
Message-ID: <4047490F.8050504@lilymarleen.de>
Date: Thu, 04 Mar 2004 16:19:43 +0100
From: large <large@lilymarleen.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: gerhard@gjaeger.de, Domen Puncer <domen@coderock.org>
Subject: Patch: Plustek scanner driver (pt_drv) port to 2.6, correction for
 2.6.3
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040700090104080408000301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040700090104080408000301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I recently updated from 2.6.0-test4 to 2.6.3 and noticed that my pt_drv
won't work any more. It did not load, telling me something like
missing symbol: kdev_t_to_nr

I investigated and found the problem:
the inline function kdev_t_to_nr does not exist any longer, I think it's
depr. due to the kdev device changes in 2.6.3 (2.6.2?).

ptdrv.c:
255: int minor = MINOR(kdev_t_to_nr(ip->i_rdev));

Anyway, I could not figure out what function might be it's successor, so
I simply removed the function call, leading to:

ptdrv.c:
225: int minor = MINOR(ip->i_rdev);

All kdev_t.h functions existing in 2.6.3 did only bad stuff to the
numbers so think this might be correct.

I just removed it, as it works for me (and should logically, reviewing
how the MINOR inline works now). I could not test it with more than one
scanner device, so it might still be false.

Anyone out there who can proof whether this is OK like this?

Attached the changed patch...

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAR0kO7V+LJJ0V3jwRAmM6AJkBzA2VciANIfuSUsP+8TqZfpvJ0ACfdfGs
+AR+ncqsDvRuqZZXGk4L5a8=
=4DJ7
-----END PGP SIGNATURE-----

--------------040700090104080408000301
Content-Type: application/gzip;
 name="plustek-0.45-2.6.3.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="plustek-0.45-2.6.3.diff.gz"

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
83a+uT6ptWBLza9r5xcbTOz8G2iBIY4QQgAA
--------------040700090104080408000301--
