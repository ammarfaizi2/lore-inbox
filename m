Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314645AbSEBQiB>; Thu, 2 May 2002 12:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314642AbSEBQiA>; Thu, 2 May 2002 12:38:00 -0400
Received: from unthought.net ([212.97.129.24]:28307 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S314645AbSEBQh7>;
	Thu, 2 May 2002 12:37:59 -0400
Date: Thu, 2 May 2002 18:37:58 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Bernd Eckenfels <ecki-news2002-04@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid1 performance
Message-ID: <20020502183758.Q31556@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Bernd Eckenfels <ecki-news2002-04@lina.inka.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020501130127.A10936@borg.org> <E1731ZL-0005Bl-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 11:23:23PM +0200, Bernd Eckenfels wrote:
> In article <20020501130127.A10936@borg.org> you wrote:
> >  1. Does the OS even know where the heads are in a modern IDE disk?
> 
> >  2. Is "closer" any more finely grained than a binary
> >     positioned/not-positioned?
> 
> > And I guess another question: How much does RAID 1 help and under what
> > kinds of usage?
> 
> No, you just distribute the ready round robin, this means each disk has only
> half the seeks it had before. 

No, this is the way it was done a long time ago.

It turns out to be an incredibly bad idea.  In fact, it is the most CPU-efficient
way of guaranteeing the largest average seek times on your disks  ;)

The RAID-1 code now looks at which disk worked closest to the wanted position
last, and picks that disk for the seek.

> As long as you do not spread continous blocks
> (readahead) stats are good you actually reduce overall seeks. This helps
> actually even if no seek is involved because of the fact that you need to
> wait for the begin of a track to read it.

The "new" code (which is not that new anymore) will allow one disk to keep
on a single sequential read for a long time (eventually it will kick in the
idle disk(s) though).

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
