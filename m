Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318900AbSICSYJ>; Tue, 3 Sep 2002 14:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318901AbSICSYJ>; Tue, 3 Sep 2002 14:24:09 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:36245 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318900AbSICSYI>;
	Tue, 3 Sep 2002 14:24:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: ptb@it.uc3m.es, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [RFC] mount flag "direct"
Date: Tue, 3 Sep 2002 20:31:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
References: <200209031641.g83GfnD10219@oboe.it.uc3m.es>
In-Reply-To: <200209031641.g83GfnD10219@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mISM-0005j3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 18:41, Peter T. Breuer wrote:
> > Distributed filesystems have a lot of subtle pitfalls - locking, cache
> 
> Yes, thanks, I know.
> 
> > coherency, journal replay to name a few - which you can hardly solve at 
> > the
> 
> My simple suggestion is not to cache. I am of the opinion that in
> principle that solves all coherency problems, since there would be no
> stored state that needs to "cohere". The question is how to identify
> and remove the state that is currently cached.

Well, for example, you would not be able to have the same file open in two 
different kernels because the inode would be cached.  So you'd have to close 
the root directory on one kernel before the other could access any file.  Not 
only would that be horribly inefficient, you would *still* need to implement
a locking protocol between the two kernels to make it work.

There's no magic way of making this easy.

-- 
Daniel
