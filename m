Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277203AbRJZCCB>; Thu, 25 Oct 2001 22:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277316AbRJZCBv>; Thu, 25 Oct 2001 22:01:51 -0400
Received: from zero.tech9.net ([209.61.188.187]:14858 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S277203AbRJZCBk>;
	Thu, 25 Oct 2001 22:01:40 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
From: Robert Love <rml@tech9.net>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
Cc: "Michael F. Robbins" <compumike@compumike.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <6693w4ds.wl@nisaaru.dvs.cs.fujitsu.co.jp>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins>
	<7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004060759.11258.12.camel@phantasy> 
	<6693w4ds.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.24.21.44 (Preview Release)
Date: 25 Oct 2001 22:02:20 -0400
Message-Id: <1004061741.11366.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-25 at 21:56, Tachino Nobuhiro wrote:
> Robert Love wrote:
> > Hm, I don't think so.  The last area is marked zero so code can know
> > when it ends.  This is common practice.
> 
> But the code does not use the last area. this is the code in
> ac97_probe_codec().

ARRAY_SIZE(x) returns the number of elements in x, but since everything
is 0-referenced going from 0 to i < ARRAY_SIZE isn't a problem.

ie int x[3];
ARRAY_SIZE(x) = 3;
but x[2] is last element... so no issue here.

> 	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
> 	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
> 	for (i = 0; i < ARRAY_SIZE(ac97_codec_ids); i++) {
> 		if (ac97_codec_ids[i].id == ((id1 << 16) | id2)) {
> 			codec->type = ac97_codec_ids[i].id;
> 			codec->name = ac97_codec_ids[i].name;
> 			codec->codec_ops = ac97_codec_ids[i].ops;
> 			break;
> 		}
> 	}
>   
> If id1 and id2 happen to be 0, it matches the last entry and codec_ops
> is set to uncertain value(maybe 0). it may cause the oops in ac97_init_mixer().

	Robert Love

