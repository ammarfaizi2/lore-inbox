Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSEPAw1>; Wed, 15 May 2002 20:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316536AbSEPAw0>; Wed, 15 May 2002 20:52:26 -0400
Received: from mta3n.bluewin.ch ([195.186.1.212]:51671 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S316535AbSEPAwZ>;
	Wed, 15 May 2002 20:52:25 -0400
Date: Thu, 16 May 2002 02:51:57 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Urban Widmark <urban@teststation.com>
Cc: "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA Rhine stalls: TxAbort handling
Message-ID: <20020516005157.GB13388@k3.hellgate.ch>
In-Reply-To: <20020514035318.GA20088@k3.hellgate.ch> <Pine.LNX.4.33.0205141928410.20379-100000@cola.enlightnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre8 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002 19:47:02 +0200, Urban Widmark wrote:
> The backoff algorithm bits have different names (and possibly different
> meaning) for the vt86c100a.

Not according to my data sheet. You may have been confused by the names I
picked: BackAMD should really be MBA. My upcoming patch will change the
names, i.e. AMD becomes MBA.

> My vt86c100a eeprom sets all backoff bits to 0000, but my vt6102 sets it
> to 0010. Since the eeprom is reloaded when the driver opens, why force it
> to "amd"?

You just answered your question. I did it because on my system that is the
way to trigger aborts and I suspected some cards might come up with a
different default value. VIA is clearing that bit in their driver so I
wouldn't be too surprised if even some newer cards did it, too.

> A module parameter would be nice for testing.

For testing the current solution should do. A parameter would make sense if
we come to the conclusion that it would be beneficial for regular users to
make a selection. It just might be. Maybe somebody who is more opinionated
that me would like to step forward and make that call!?

> Ivan, have you tried playing with these bits?

Have _you_?

> Donalds suggestion is that the TxAborts is simply too much collisions.
> Perhaps the eeprom selection of backoff algorithm isn't working well in
> your environment.

No, it works just great. The problem is that the unmodified driver breaks
down as soon as a TxAbort happens. From my limited experience, MBA seems to
be rather aggressive which is a good thing in some situations (e.g. if
nobody cares that you're monopolizing the network).

Roger
