Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKAGbr>; Wed, 1 Nov 2000 01:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129038AbQKAGbg>; Wed, 1 Nov 2000 01:31:36 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:51725 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129030AbQKAGb0>; Wed, 1 Nov 2000 01:31:26 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14847.47287.401316.961409@wire.cadcamlab.org>
Date: Wed, 1 Nov 2000 00:31:19 -0600 (CST)
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <39FF0A71.FE05FAEB@gromco.com>
	<Pine.LNX.4.10.10010311018180.7083-100000@penguin.transmeta.com>
	<8tn5q9$iu5$1@cesium.transmeta.com>
	<20001031211506.E1041@wire.cadcamlab.org>
	<39FFB429.FA0B58CC@transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[hpa]
> I would tend to agree with Linus on that.  If that's truly what
> you're doing, it would be rather nonobvious.

Well, ok, opinion vs. opinion.  The thing is, userspace code almost
*never* needs to care about link order -- and, not counting boot loader
magic, kernel code didn't care about it either until 2.3.16 or so
(debut of __initcall).  The reason link order suddenly became an issue
is that people started cutting out explicit lists of init code like
net/Space.c and relying on ld.  All in all that was a Good Thing -- it
made code more modular, etc.

My point here is that in most of the world, people are not accustomed
to caring about link order.  So I don't see why it's seen as such a
horrible thing to now say "ok link order is once again something you
ideally should not care about, *but* if there's a really good reason
otherwise, add your entry to LINK_FIRST."  Because the link-order-
*does*-matter paradigm is less than a year old, here.

> But the question, perhaps, is when does ordering matter.  I'm a
> little concerned about things highly dependent on link ordering.

Agreed.  And that is another point: we (Keith, Michael and I wrote all
this expecting link order to usually *not* matter -- LINK_FIRST was
just to cover corner cases.  Then we get Linus back saying the whole
drivers/scsi/ must be ordered *just so* (presumably so people don't
have to use boot flags for their multiple scsi host adapters) which is
either an unproven claim or, since it's Linus, a fiat.  (Which is OK,
don't get me wrong, better him than me making these decisions!)

And as for "rather nonobvious" -- it's not as if our stuff isn't
documented, at least.  Keith's patch includes several paragraphs added
to Documentation/kbuild/makefiles.txt, a file every kernel developer
should read anyway so that they know how to write correct makefiles.

Oh well.  Life goes on.  We can do fine without LINK_FIRST, but
possibly at the cost of increased cruft in the rest of the makefile
system.  (That depends on taste, I suppose.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
