Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271129AbRH2A1S>; Tue, 28 Aug 2001 20:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRH2A1J>; Tue, 28 Aug 2001 20:27:09 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28689 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271129AbRH2A1A>; Tue, 28 Aug 2001 20:27:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Wed, 29 Aug 2001 02:33:52 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108280732560.8585-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108280732560.8585-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010829002715Z16351-32384+944@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 28, 2001 05:14 pm, Linus Torvalds wrote:
> I'll show you a real example from drivers/acorn/scsi/acornscsi.c:
> 
> 	min(host->scsi.SCp.this_residual, DMAC_BUFFER_SIZE / 2);
> 
> this_residual is "int", and "DMAC_BUFFER_SIZE" is just a #define for
> an integer constant. So the above is actually a signed comparison, and
> I'll bet you that was not what the author intended.
> 
> Now, this_residual is hopefully never negative, so it doesn't matter.

    min(host->scsi.SCp.this_residual, (unsigned) DMAC_BUFFER_SIZE / 2);

--
Daniel
