Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289204AbSANLs5>; Mon, 14 Jan 2002 06:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289209AbSANLsr>; Mon, 14 Jan 2002 06:48:47 -0500
Received: from ns.ithnet.com ([217.64.64.10]:7690 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289204AbSANLsh>;
	Mon, 14 Jan 2002 06:48:37 -0500
Date: Mon, 14 Jan 2002 12:47:55 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: alan@lxorguk.ukuu.org.uk, zippel@linux-m68k.org, rml@tech9.net,
        ken@canit.se, arjan@fenrus.demon.nl, landley@trommello.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020114124755.3b2d6a4d.skraw@ithnet.com>
In-Reply-To: <3C42AD48.FCFD6056@zip.com.au>
In-Reply-To: <E16PvKx-00005L-00@the-village.bc.nu>
	<200201140033.BAA04292@webserver.ithnet.com>
	<E16PvKx-00005L-00@the-village.bc.nu>
	<20020114104532.59950d86.skraw@ithnet.com>
	<3C42AD48.FCFD6056@zip.com.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 02:04:56 -0800
Andrew Morton <akpm@zip.com.au> wrote:

> Stephan von Krawczynski wrote:
> > 
> > ...
> > Unfortunately me have neither of those. This would mean I cannot benefit
from> > _these_ patches, but instead would need _others_ 
[...]
> 
> In 3c59x.c, probably the biggest problem will be the call to issue_and_wait()
> in boomerang_start_xmit().  On a LAN which is experiencing heavy collision
rates> this can take as long as 2,000 PCI cycles (it's quite rare, and possibly
an> erratum).  It is called under at least two spinlocks.
> 
> In via-rhine, wait_for_reset() can busywait for up to ten milliseconds.
> via_rhine_tx_timeout() calls it from under a spinlock.
> 
> In eepro100.c, wait_for_cmd_done() can busywait for one millisecond
> and is called multiple times under spinlock.

Did I get that right, as long as spinlocked no sense in conditional_schedule()
?

> Preemption will help _some_ of this, but by no means all, or enough.

Maybe we should really try to shorten the lock-times _first_. You mentioned a
way to find the bad guys?

Regards,
Stephan


