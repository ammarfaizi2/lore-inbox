Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283277AbRK2Ufu>; Thu, 29 Nov 2001 15:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283281AbRK2Ufk>; Thu, 29 Nov 2001 15:35:40 -0500
Received: from marine.sonic.net ([208.201.224.37]:49180 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S283277AbRK2Ufb>;
	Thu, 29 Nov 2001 15:35:31 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 29 Nov 2001 12:35:22 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 still not making fs dirty when it should
Message-ID: <20011129123522.G7992@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011128231504.A26510@elf.ucw.cz> <3C069291.82E205F1@zip.com.au>, <3C069291.82E205F1@zip.com.au> <20011129120826.F7992@thune.mrc-home.com> <3C069919.E679F1F8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C069919.E679F1F8@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 12:22:49PM -0800, Andrew Morton wrote:
> What happens is that the superblock is altered in-memory
> to say "the filesystem needs checking", but it's not written
> out to disk.
> 
> So other things can come in, alter the fs, get written out *before*
> the superblock and then you crash.  fsck won't be run, and the
> filesystem is left in an inconsistent state.

Ok.  I could see this being a bad thing.

I could also see the easiest thing to implement would be updating the super
block on mount.

However, is this a case where Linux tries not to update the superblock
about being dirty until something has actually changed (ie, be slightly
smarter), and that's not working, or is the superblock simply not being
updated on mount?

Thanks,
mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
