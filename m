Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSATWLz>; Sun, 20 Jan 2002 17:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288579AbSATWLp>; Sun, 20 Jan 2002 17:11:45 -0500
Received: from ns.suse.de ([213.95.15.193]:26130 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288051AbSATWLg>;
	Sun, 20 Jan 2002 17:11:36 -0500
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of O_DIRECT on md/lvm
In-Reply-To: <p734rlg90ga.fsf@oldwotan.suse.de.suse.lists.linux.kernel> <m16SPj2-000OVeC@amadeus.home.nl.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Jan 2002 23:11:35 +0100
In-Reply-To: arjan@fenrus.demon.nl's message of "20 Jan 2002 22:46:12 +0100"
Message-ID: <p73ofjoisfc.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@fenrus.demon.nl writes:

> In article <p734rlg90ga.fsf@oldwotan.suse.de> you wrote:
> 
> > I think an optional readahead mode for O_DIRECT would be useful. 
> 
> I disagree. O_DIRECT says "do not cache. period. I know what I'm doing"
> and the kernel should respect that imho. After all we have sys_readahead for
> the other part...

Problem with sys_readahead is that it doesn't work for big IO sizes. 
e.g. you read in big blocks. You have to do readahead(next block); 
read(directfd, ..., big-block); 
The readahead comes to early in this case; it would be better if it is
done in the middle of read of big-block based on the request size.
Otherwise you risk additional seeks when you overflow the 'read window',
which is all to easy this way. 

-Andi
