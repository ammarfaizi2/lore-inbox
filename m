Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbRFTWL1>; Wed, 20 Jun 2001 18:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263536AbRFTWLW>; Wed, 20 Jun 2001 18:11:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13697 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262829AbRFTWK6>;
	Wed, 20 Jun 2001 18:10:58 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15153.8005.551628.544731@pizda.ninka.net>
Date: Wed, 20 Jun 2001 15:10:13 -0700 (PDT)
To: kuznet@ms2.inr.ac.ru
Cc: andrea@suse.de (Andrea Arcangeli), paulus@samba.org,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: softirq in pre3 and all linux ports
In-Reply-To: <200106201806.WAA19422@ms2.inr.ac.ru>
In-Reply-To: <20010620060753.B849@athlon.random>
	<200106201806.WAA19422@ms2.inr.ac.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kuznet@ms2.inr.ac.ru writes:
 > Actually, now I do not understand why TUX still works with Ingo's patch.
 > As soon as bulk work is made in thread context, it should die pretty
 > fastly doing no progress. :-)

TUX also has per-cpu timers patch of Ingo as well.
Did you forget this? :-)

 > Let's look at different angle: f.e. with Ingo's patch, as soon as
 > one cpu processes some global BH, all the rest of cpus will spin
 > waiting for global bh release. Is this good? I am afraid this is not
 > quite good.

It is equivalent to some old dumb code doing cli() right?

The only interesting global BHs left right now are:

1) Timers
2) SCSI BH

SCSI may be transformed right now in 15 minutes of boring editing to a
softirq, it has all the appropriate locking already.

Timers have no hard technical reason for not being a softirq
either.  However, this would be work requiring real thought,
not just mindless edits.

Later,
David S. Miller
davem@redhat.com
