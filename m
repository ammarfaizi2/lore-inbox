Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313568AbSEARBa>; Wed, 1 May 2002 13:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSEARB3>; Wed, 1 May 2002 13:01:29 -0400
Received: from borg.org ([208.218.135.231]:29484 "HELO borg.org")
	by vger.kernel.org with SMTP id <S313568AbSEARB3>;
	Wed, 1 May 2002 13:01:29 -0400
Date: Wed, 1 May 2002 13:01:27 -0400
From: Kent Borg <kentborg@borg.org>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        Arjan van de Ven <arjanv@redhat.com>,
        Jaime Medrano <overflow@eurielec.etsit.upm.es>,
        linux-kernel@vger.kernel.org
Subject: Re: raid1 performance
Message-ID: <20020501130127.A10936@borg.org>
In-Reply-To: <Pine.LNX.4.33.0204301411210.4658-100000@cuatro.eurielec.etsit.upm.es> <3CCE9038.F4C830B4@redhat.com> <20020430102148.D4470@borg.org> <20020501183553.D31556@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 06:35:53PM +0200, Jakob Østergaard wrote:
> This is *not* as simple as it sounds.  Believe me, I spent a week trying...
> 
> However, with ext2 (and other filesystems as well), a large sequential file
> read is *not* sequential on the disk.  You should actually see better performance
> on RAID-1 than on a single disk for very large reads, becuase some of the lookups
> needed (block indirection or whatever) will be run by the "best" disk in the given
> situation.

Lemme see if I am getting closer.  

When reading the disk there will be head seeks necessary.  When there
are two disks, each with its own complete copy of all the data, there
is no reason to keep the two disks' heads in the same place.  If their
heads are in different places, a read can be issued to the disk whose
heads are closer to the desired location.

This then brings up two more questions:

  1. Does the OS even know where the heads are in a modern IDE disk?

  2. Is "closer" any more finely grained than a binary
     positioned/not-positioned?

And I guess another question: How much does RAID 1 help and under what
kinds of usage?


Thanks,

-kb, the Kent who is getting smarter.
