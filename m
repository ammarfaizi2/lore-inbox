Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbRFUQ77>; Thu, 21 Jun 2001 12:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265034AbRFUQ7t>; Thu, 21 Jun 2001 12:59:49 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:45060 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S265033AbRFUQ7c>;
	Thu, 21 Jun 2001 12:59:32 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200106211658.UAA14133@ms2.inr.ac.ru>
Subject: Re: softirq in pre3 and all linux ports
To: davem@redhat.com (David S. Miller)
Date: Thu, 21 Jun 2001 20:58:07 +0400 (MSK DST)
Cc: andrea@suse.de, paulus@samba.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <15153.8005.551628.544731@pizda.ninka.net> from "David S. Miller" at Jun 20, 1 03:10:13 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> TUX also has per-cpu timers patch of Ingo as well.
> Did you forget this? :-)

If I remember correctly, it has threaded timer pool, but timers still acquire
global bh lock, so that the things become only worse. Apparently,
it is invisible at first sight because bulk work typical for tux and triggered
by timers, is moved to cpu local tasklets (garbage collection: time wait etc.).


> It is equivalent to some old dumb code doing cli() right?

Sort of.


> The only interesting global BHs left right now are:
> 
> 1) Timers
> 2) SCSI BH

In generic server case, yes.

But also add BH_IMMEDIATE and BHs, used by hordes of devices.


> Timers have no hard technical reason for not being a softirq
> either.  However, this would be work requiring real thought,
> not just mindless edits.

Yes.

But, in any case, global BHs are not a pathalogy: they were handy tool,
allowing to hide lots of spinlocks. And not plain spinlocks, but
asynchronous ones. It was pretty light, but had latency up to 1/HZ
in the worst case. Now they have unreasonably strict latency
(useless, as rule) but eat cpu instead.

Alexey
