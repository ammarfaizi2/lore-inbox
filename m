Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbREXV1l>; Thu, 24 May 2001 17:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262343AbREXV1b>; Thu, 24 May 2001 17:27:31 -0400
Received: from idiom.com ([216.240.32.1]:28684 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S262334AbREXV1S>;
	Thu, 24 May 2001 17:27:18 -0400
Message-ID: <3B0D7BF4.4FE586B8@namesys.com>
Date: Thu, 24 May 2001 14:24:04 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Dying disk and filesystem choice.
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au> <200105240658.f4O6wEWq031945@webber.adilger.int> <20010524103145.A9521@gruyere.muc.suse.de> <3B0D3C99.255B5A24@namesys.com> <20010524214641.E10968@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> 
> On Thu, May 24, 2001 at 09:53:45AM -0700, Hans Reiser wrote:
> > No, reiserfs does have badblock support!!!!
> >
> > You just have to get it as a separate patch from us because it was
> > written after code freeze.
> 
> IMHO we are not that deep into code freeze anymore. Freevxfs got added
> in linux-2.4.5-pre*, so I think that a patch that adds a useful feature
> like badblock support would be OK.
> 
> Erik
> 
> --
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

vxfs is probably a completely separate fs that won't destabilize other
filesystems, or at least I hope so.  ReiserFS is stable code now, we aren't
going to change that by adding features unless they go into the ac series for
six weeks or so first.  ReiserFS is the SuSE recommended FS, and we can't go
destabilizing it.  I am told by sistina.com (maintainers of LVM) that in their
surveys of the users of LVM, 90% use ReiserFS, and the users of LVM tend very
much to be persons with mission critical servers.  We sent Linus a patch to mark
us as stable not experimental.  When we say stable, it means something.  Right
now it means zero (yes, zero) new bug reports that are not user error or old
versions or fsck, since 2.4.4 came out.  

fsck is improving dramatically in stability every week.  I used it myself last
week, and got my data back minus the root directory after trashing the front of
my partition accidentally.  (Which gave me a chance to review its end user
usability, which is also improving.)  We aren't yet ready to pass the zero a
random block and see it recover always excepting what was zero'd test, but we
will be before long.  One of the things we realized recently is that if the user
knows what got trashed, and he can tell this to the FS, it can be very useful
for bitmap blocks.  Sorry, I wander here.

Hans
