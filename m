Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277161AbRJZB4a>; Thu, 25 Oct 2001 21:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277203AbRJZB4U>; Thu, 25 Oct 2001 21:56:20 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:13471 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S277161AbRJZB4E>; Thu, 25 Oct 2001 21:56:04 -0400
Date: Fri, 26 Oct 2001 10:56:31 +0900
Message-ID: <6693w4ds.wl@nisaaru.dvs.cs.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Robert Love <rml@tech9.net>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        "Michael F. Robbins" <compumike@compumike.com>,
        linux-kernel@vger.kernel.org
Subject: Re: SiS/Trident 4DWave sound driver oops
In-Reply-To: <1004060759.11258.12.camel@phantasy>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins>
	<7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<1004060759.11258.12.camel@phantasy>
User-Agent: Wanderlust/2.7.5 (Too Funky) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.7 () APEL/10.3 MULE XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At 25 Oct 2001 21:45:58 -0400,
Robert Love wrote:
> 
> On Thu, 2001-10-25 at 21:37, Tachino Nobuhiro wrote:
> >   Following patch may fix your oops. Please try.
> 
> Hm, I don't think so.  The last area is marked zero so code can know
> when it ends.  This is common practice.

But the code does not use the last area. this is the code in
ac97_probe_codec().


	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
	for (i = 0; i < ARRAY_SIZE(ac97_codec_ids); i++) {
		if (ac97_codec_ids[i].id == ((id1 << 16) | id2)) {
			codec->type = ac97_codec_ids[i].id;
			codec->name = ac97_codec_ids[i].name;
			codec->codec_ops = ac97_codec_ids[i].ops;
			break;
		}
	}
  
If id1 and id2 happen to be 0, it matches the last entry and codec_ops
is set to uncertain value(maybe 0). it may cause the oops in ac97_init_mixer().
