Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSEVKQY>; Wed, 22 May 2002 06:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315535AbSEVKQX>; Wed, 22 May 2002 06:16:23 -0400
Received: from pc-62-31-74-121-ed.blueyonder.co.uk ([62.31.74.121]:11649 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316923AbSEVKQV>; Wed, 22 May 2002 06:16:21 -0400
Date: Wed, 22 May 2002 11:16:10 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jon Hedlund <JH_ML@invtools.com>, sct@redhat.com, akpm@zip.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel - Ext3 & Raid patches
Message-ID: <20020522111610.A3180@redhat.com>
In-Reply-To: <3CEA7866.23557.390B7FFC@localhost> <20020522012133.GE13211@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 21, 2002 at 07:21:33PM -0600, Andreas Dilger wrote:
> On May 21, 2002  16:40 -0500, Jon Hedlund wrote:
> > Last September Stephan told someone on the linux-kernel list that 
> > Ext3 and Raid 1 didn't work together on the 2.2 kernel. 
> > Has this been fixed or have I just been lucky?
> 
> You've just been lucky.  I forget the exact scenario, but it is
> something like if journal replay is happening while the RAID is being 
> reconstructed after a crash you can get garbage written to your disk.

Right --- the raid resync code in 2.2 uses the normal buffer cache,
which results in writes being scheduled for clean buffers, behind
ext3's back.  That's not allowed --- it violates the write ordering
requirements that make ext3 work, and trips up debugging assert
failures in the ext3 write checking code.

You might get away with it, but a raid resync on ext3 on 2.2 is
basically not safe.  If you wait until after the resync before
mounting the ext3 filesystem, you'll be OK.

It should work on 2.4.

Cheers,
 Stephen
