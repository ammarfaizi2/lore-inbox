Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284136AbRLKVai>; Tue, 11 Dec 2001 16:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284117AbRLKVa3>; Tue, 11 Dec 2001 16:30:29 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:57871 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284088AbRLKVaL>;
	Tue, 11 Dec 2001 16:30:11 -0500
Date: Wed, 12 Dec 2001 08:28:02 +1100
From: Anton Blanchard <anton@samba.org>
To: Jens Axboe <axboe@suse.de>
Cc: Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Scsi problems in 2.5.1-pre9
Message-ID: <20011211212802.GA30520@krispykreme>
In-Reply-To: <1008065277.25964.5.camel@plars.austin.ibm.com> <20011211164744.GC13498@suse.de> <20011211165426.GD13498@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011211165426.GD13498@suse.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jens,

> > > Incorrect number of segments after building list
> > > counted 11, received 7
> > 
> > Attached patch should fix it.

I just booted 2.5.1-pre10 on ppc64 and still get the errors:

 Incorrect number of segments after building list
 counted 3, received 2
 req nr_sec 24, cur_nr_sec 8

This seems to be happening because we now allow sg merging through
the BIOVEC_MERGEABLE macro. On ppc64 (and sparc64) we can coalesce two
sg entries if the first one ends on a page boundary and the next one
starts on a page boundary because we have an IO MMU. (I know that you
know this, Im just explaining it for those who dont :)

Should we just remove the warning now?

Anton
