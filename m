Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSDHReH>; Mon, 8 Apr 2002 13:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313712AbSDHReG>; Mon, 8 Apr 2002 13:34:06 -0400
Received: from mark.mielke.cc ([216.209.85.42]:9743 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S313711AbSDHReG>;
	Mon, 8 Apr 2002 13:34:06 -0400
Date: Mon, 8 Apr 2002 13:08:49 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Andrew Morton <akpm@zip.com.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, nahshon@actcom.co.il,
        Pavel Machek <pavel@suse.cz>, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020408130849.A30751@mark.mielke.cc>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not really thinking about how hard it would be to implement, I suggest
that the appropriate place for this to be, would be a mount option.

Just as 'noatime', or 'sync', perhaps a 'delaywrite' option would be a
good choice. An advantage of this approach, is that I could make /tmp
be 'delaywrite+journal' in an effort to improve the efficiency of
/tmp, as I could care less what I lost in /tmp between reboots under
extreme situations.

mark


On Sun, Apr 07, 2002 at 06:14:51PM -0700, Andrew Morton wrote:
> Richard Gooch wrote:
> > 
> > But I *want* to write while the drive is spun down. And leave it spun
> > down until the system is RAM starved (or some threshold is reached).
> > 
> 
> Yes.  The desirable behaviour for laptops is to defer writes
> for a very long time, or until the user says "sync".
> 
> Mechanisms need to be put in place so that if there are pending
> writes and the disk happens to be spun up for a read, we take
> advantage of that spinup to push out the pending writes at
> the same time.
> 
> This behaviour should be all be enabled by a special "laptop mode"
> switch.
> 
> There's nothing particularly hard in all this...  I'll do a 2.5
> version at some stage.
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

