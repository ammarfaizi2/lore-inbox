Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbTA1OAQ>; Tue, 28 Jan 2003 09:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbTA1OAQ>; Tue, 28 Jan 2003 09:00:16 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:28576 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S265402AbTA1OAP>;
	Tue, 28 Jan 2003 09:00:15 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301281409.RAA28740@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
To: benoit-lists@fb12.de (Sebastian Benoit)
Date: Tue, 28 Jan 2003 17:09:09 +0300 (MSK)
Cc: dada1@cosmosbay.com, cgf@redhat.com, davem@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
In-Reply-To: <20030128133606.A21796@turing.fb12.de> from "Sebastian Benoit" at Jan 28, 3 01:36:06 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>   http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D103641051419994&w=3D2

Thank you. Christopher also gave something similar.

Dave, look:

23:24:05.617819 trixie.bosbc.com.32793 > sources.redhat.com.22: P [bad tcp cksum 3770!] 5136:5136(0) ack 32369 win 45144 <nop,nop,timestamp 122553 80640703> (DF) [tos 0x10]  (ttl 64, id 9958, len 52)
23:24:06.093754 trixie.bosbc.com.32793 > sources.redhat.com.22: P [bad tcp cksum 5b6e!] 5136:5136(0) ack 32369 win 45144 <nop,nop,timestamp 123029 80640703> (DF) [tos 0x10]  (ttl 64, id 9959, len 52)
23:24:07.045603 trixie.bosbc.com.32793 > sources.redhat.com.22: P [bad tcp cksum a36a!] 5136:5136(0) ack 32369 win 45144 <nop,nop,timestamp 123981 80640703> (DF) [tos 0x10]  (ttl 64, id 9960, len 52)


We apparently have segment of zero length in queue. :-)

Well, that chunk cannot be responsible for this directly, I am afraid
we somewhat arrived to attempt to retransmit already acked segment.
It is weird enough to be good hint. :-)

Alexey
