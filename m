Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSKCTIW>; Sun, 3 Nov 2002 14:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbSKCTIW>; Sun, 3 Nov 2002 14:08:22 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:22291 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262326AbSKCTIV>; Sun, 3 Nov 2002 14:08:21 -0500
Date: Sun, 3 Nov 2002 11:14:44 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [lkcd-general] Re: What's left over.
Message-ID: <20021103191444.GA18238@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021103170823.10591.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103170823.10591.qmail@science.horizon.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 05:08:23PM -0000, linux@horizon.com wrote:
> Just to complicate things, consider this setup:
> 
> # cat /proc/swaps
> Filename			Type		Size	Used	Priority
> /dev/md5                        partition	999864	16904	0
> /dev/md6                        partition	999864	16924	0
> /dev/md7                        partition	999864	16920	0
> 
> Those are all RAID-1 mirrors, a measure whose ass-saving value I have
> enjoyed.
> 
> While a crash dump to just half of one of those mirrors is fine, finding it
> might be a little bit tricky.  And the fact that the kernel reassembles
> the mirrors automatically on boot might make retrieving the data a little
> bit tricky, too.
> 
> (After a crash, the mirrors will be inconsistent, so one will get copied
> over the other, but I'm not too clear on which direction it'll happen in.)
> 
> I can't NOT reassemble at least some mirrors on boot because / is mirrored!
> 
> Now, to that, add the case that each of those is significantly smaller than
> main memory.  (2/3 size would still allow swap = 2*ram.)

You would want a dump2disk that could span devices.
Probably a module that would put a header on each part with
a dumpID and sequence#.  Compression would also help here as
well.  The right compression would actually accelerate the
process.

Early userspace would locate and assemble the pieces and put
the dump somewhere.  This might happen between mounting /
and assembling the other mirrors.  That would be up to you.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
