Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269773AbRHIL6q>; Thu, 9 Aug 2001 07:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269771AbRHIL6h>; Thu, 9 Aug 2001 07:58:37 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:58642 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269772AbRHIL60>; Thu, 9 Aug 2001 07:58:26 -0400
Date: Thu, 9 Aug 2001 13:58:35 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: don't feed the trolls (was: intermediate summary of ext3-2.4-0.9.4 thread)
Message-ID: <20010809135835.D14108@emma1.>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010804053018.D16516@emma1.emma.line.org> <200108042122.f74LMR313894@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200108042122.f74LMR313894@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Aug 2001, Albert D. Cahalan wrote:

> Seriously, consider:
> 
> 1. there are MTA authors that actively promote BSD over Linux
> 2. Linux users and distributions promote their MTA software

I do not endorse this behaviour (particularly, qmail not supporting
softupdates is rather ridiculous), but I understand that MTA authors
would rather want to rely on fsync() also bringing related meta data do
disk (as ext3 and reiserfs for Linux 2.4 already do even across a
rename()!) than to add dir=open("directory"); fsync(dir); close(dir) all
over the place.

> Getting back on topic... while non-inherited ext2 attributes might

What would they be good for? Make MTA that have in the past achieved
reliable behaviour with chattr +S unreliable?

> be nice, I'm sure the ext2/VFS authors don't need to be pestered
> about it, and certainly not because of some lame software making
> non-standard assumptions about filesystem behavior.

Well, the software documents its requirements and assumptions. I don't
see anything nonstandard with relying on fsync(). If ext2fs doesn't meet
the assumptions without chattr +S or mount -o sync, but allows to
enforce this behaviour chattr +S, deliberately breaking ext2 attributes
inheritance will make Linux deliberately unsuitable for this MTA -- or
at least, slow it down through the need to use mount -o sync.

Deliberately breaking things just to show somebody else "you cannot even
rely that chattr behaviour is invariant" is ridiculous and definitely
not the right way to go.

If the MTA author chooses chattr +S over fsync-directory, what's wrong
with that?

-- 
Matthias Andree
