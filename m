Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135664AbQLaBsz>; Sat, 30 Dec 2000 20:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135665AbQLaBsp>; Sat, 30 Dec 2000 20:48:45 -0500
Received: from slc779.modem.xmission.com ([166.70.6.17]:3079 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S135664AbQLaBsZ>; Sat, 30 Dec 2000 20:48:25 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.LNX.4.10.10012301441350.1477-100000@penguin.transmeta.com>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 30 Dec 2000 17:26:58 -0700
In-Reply-To: Linus Torvalds's message of "Sat, 30 Dec 2000 14:44:56 -0800 (PST)"
Message-ID: <m1pui9ph9p.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 30 Dec 2000, Eric W. Biederman wrote:
> > 
> > One other thing to think about for the VFS/MM layer is limiting the
> > total number of dirty pages in the system (to what disk pressure shows
> > the disk can handle), to keep system performance smooth when swapping.
> 
> This is a separate issue,  and I think that it is most closely tied in to
> the "RSS limit" kind of patches because of the memory mapping issues. If
> you've seen the RSS rlimit patch (it's been posted a few times this week),
> then you could think of that modified by a "Resident writable pages Set
> Size" approach. 

Building on the RSS limit approach sounds much simpler then they way
I was thinking.

> Not just for shared mappings - this is also an issue with
> limiting swapout.
> 
> (I actually don't think that RSS is all that interesting, it's really the
> "potentially dirty RSS" that counts for VM behaviour - everything else can
> be dropped easily enough)

Definitely.

Now the only tricky bit is how do we sense when we are overloading
the swap disks.  Well that is the next step.  I'll take a look
and see what it takes to keep statistics on dirty mapped pages.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
