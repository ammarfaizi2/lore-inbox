Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269418AbRHGGlO>; Tue, 7 Aug 2001 02:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270070AbRHGGlF>; Tue, 7 Aug 2001 02:41:05 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:16655 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S269418AbRHGGky>; Tue, 7 Aug 2001 02:40:54 -0400
Date: Tue, 7 Aug 2001 02:41:01 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010807024101.B2399@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0108070106390.7542-100000@localhost.localdomain> <Pine.LNX.4.33.0108062239550.5316-100000@mackman.net> <200108070624.f776Ofl21096@www.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108070624.f776Ofl21096@www.2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Tue, Aug 07, 2001 at 10:27:20AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 07/08/01 10:27 +0400 - John Polyakov:
> Hello.
> 
> On Mon, 6 Aug 2001 22:55:19 -0700 (PDT)
> Ryan Mack <rmack@mackman.net> wrote:
> 
> RM> Apparently some of you have missed the point.  Currently, the only way
> to
> RM> write any form of encryption application is to have it run setuid root
> so
> RM> it can lock pages in RAM.  Otherwise, files (or keys) that are
> encrypted
> RM> on disk may be left in an unencrypted state on swap, allowing for
> RM> potential recovery by anyone with hardware access.  Encrypted swap
> makes
> RM> locking pages unnecessary, which relieves many sysadmins from the
> anxiety
> RM> of having yet-another-setuid application installed on their server in
> RM> addition to freeing up additional pages to be swapped.
> 
> Hmmm, let us suppose, that i copy your crypted partition per bit to my
> disk.
> After it I will disassemble your decrypt programm and will find a key....
> 
> In any case, if anyone have crypted data, he MUST decrypt them.
> And for it he MUST have some key.
> If this is a software key, it MUST NOT be encrypted( it's obviously,
> becouse in other case, what will decrypt this key?) and anyone, who have
> PHYSICAL access to the machine, can get this key.
> Am I wrong?

Yes, you are wrong. The encryption key for the swap space can be created
at boot time. We can wait for the hardware to give us enough entropy
into the random number gen, and make a key. Then we mount the swap
space, and all reads/writes go through that key. But the key is never
recorded. The swap data is gone, even to legitimate users of the system,
after a reboot.

It is thus perfectly reasonable to wish to encrypt swap. In addition,
there are good reasons to move in the direction of a non-All-Powerful
root user. This is what the work in capabilities begins to approach.
So simply waving your hands and saying that root can see it, so what
does it matter, is not a long term solution to the problem.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
