Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280964AbRKGUla>; Wed, 7 Nov 2001 15:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280967AbRKGUlU>; Wed, 7 Nov 2001 15:41:20 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6417 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280964AbRKGUlM>; Wed, 7 Nov 2001 15:41:12 -0500
Message-ID: <3BE99B29.354AA18A@zip.com.au>
Date: Wed, 07 Nov 2001 12:35:53 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Ville Herva <vherva@niksula.hut.fi>, James A Sutherland <jas88@cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <20011107213837.F26218@niksula.cs.hut.fi>,
		<E161UYR-0004S5-00@the-village.bc.nu>
		<E161Vbf-0000m9-00@lilac.csi.cam.ac.uk> 
		<20011107213837.F26218@niksula.cs.hut.fi> <1005164667.884.5.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Wed, 2001-11-07 at 14:38, Ville Herva wrote:
> > A stupid question: does ext3 replay the journal before fsck? If not, the
> > inode errors would be expected...
> 
> ext3 will reply the root file systems journal on boot when the kernel
> mounts root.  other ext3 partitions will have their journals replayed
> when they are mounted.
> 
> also, btw, I use RedHat 7.2 and fsck does not run if I don't hit Y.  It
> is there for pedants or seriously screwed disks -- the journal replay
> should be sufficient.
> 

fsck can perform journal replay.  It's the same code, in fact.

So even if one does run fsck against an unclean ext3 partition,
fsck will just replay the journal and then exit.  It won't do
the twenty minute go-grab-a-coffee thing unless it has explicitly
been passed the `-f' option.  Doing that is very, very paraniod.

I normally just leave ext3 at the default check-time settings,
so fsck runs every thirtieth boot or so.  ie: hourly :)

=
