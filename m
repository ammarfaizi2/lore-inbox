Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVKNTJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVKNTJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVKNTJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:09:47 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:20505 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751243AbVKNTJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:09:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=DdNMLG565Akbt7kOAOZKR90jw6AQ/8oweDYnRZLJXJmB1Ozbmx0zemOPCPR5mEDYmiY6tCMW4ZbmuPHNMzlGe68d4rPEMIY5K2LZqd3qXHoxGIeNZjbBsIJ8Mmbe+DoCpVXQ+65BSjo3jofZ23FsvhSIRzjuyF1Br2Pf4SBsiDI=
Message-ID: <4378B48E.6010006@gmail.com>
Date: Mon, 14 Nov 2005 17:00:14 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [BUG] Softlockup detected with linux-2.6.14-rt6
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I found this softlockup bug involving arts daemon using a
linux-2.6.14-rt6 kernel (with "Complete Preemption" and "Detect Soft
Lockups" compiled in).
This bug does not happen everytime: I was able to reproduce it only
three times in a week. Here is the oops message (obtained from my
printer because system is frozen):

BUG: artsd:4177, possible softlockup detected on CPU#0!
[<c0146db4>] softlockup_detected+0x34/0x40 (8)
[<c0146e69>] softlockup_tick+0xa9/axb0 (20)
[<c01388a1>] timer_interrupt+0x21/0x40 (12)
[<c014724e>] handle_IRQ_event+0x63/0xf0 (12)
[<c01476a3>] __do_IRQ+0xa3/0x150 (48)
[<c0105594>] do_IRQ+0x34/0x70 (40)
[<c0103d42>] common_interrupt+0x1a/0x20 (8)
[<c0103d42>] common_interrupt+0x1a/0x20 (20)
[<c01bfcc0>] __delay+0x20/0x30 (44)
[<c91f16a4>] snd_timer_close+0x1b4/0x2b0 [snd_timer] (12)
[<c0a7f36a>] fasync_helper+0x7a/0x100 (12)
[<c91f307c>] snd_timer_user_release+0x4c/0x80 [snd_timer] (28)
[<c016c14d>] __fput+0xad/0x1a0 (24)
[<c0a6a632>] filp_close+0x52/0x90 (40)
[<c016a6e0>] sys_close+0x70/0xc0 (24)
[<c01032fd>] syscall_call+0x7/0xb (28)

Regards,
- --
					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQ3i0ipK+HIH6ZZ2zAQJ6mwf/QfAY+f+JFfb2cjLIoBrnY6rFsDBFE9XR
KeJQmYuRRRmesI/lgNdAH7Wnb3QIqw62AKncWRj3JQj5IOhfQoexnf9IYg08XJoS
oDD1mQI5udDJBeGfIUg2AUiPYbtvAdtAZnJQ3QWs9PcN4G6Zi2y9+WfHTFqF/x+P
J9vMQa8mSmt3jAQ8E3th/i+njGekk/O7lp86A6CSKfLqhuxPvMJtwYTtZams7kRV
xyfKEQ7nkMmWNTYu/Beuxdes2ME70ZBLVSg54OJluhWfKBjviuJCbUT0itGRDTaL
RZ7Uev1OE7QiVY6g55xYRCwB/QO3un93iQy4N1rXNyIGS2koVGsq5Q==
=u9dF
-----END PGP SIGNATURE-----

