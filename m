Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270758AbRICA7q>; Sun, 2 Sep 2001 20:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270822AbRICA7g>; Sun, 2 Sep 2001 20:59:36 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:55120
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S270758AbRICA7T>; Sun, 2 Sep 2001 20:59:19 -0400
Date: Sun, 2 Sep 2001 17:59:38 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Editing-in-place of a large file
Message-ID: <20010902175938.D21576@work.bitmover.com>
Mail-Followup-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <20010902233008.Q9870@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010902233008.Q9870@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Sun, Sep 02, 2001 at 11:30:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's needed is a generalisation of sparse files and truncate().
> They both handle similar problems.

how about 

	fzero(int fd, off_t off, size_t len)

which zeros the blocks and if it can creates a holey file?

However, that's not what Bob wants, he wants to remove commercials from
recorded TV.  So what he wants is 

	fdelete(int fd, off_t off, size_t len)

which has the semantics of shifting the rest of the file backwards to "off".

The main problem with this is if the off/len are not block aligned.  If they
are, then this is just block twiddling, if they aren't, then this is a file
rewrite anyway.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
