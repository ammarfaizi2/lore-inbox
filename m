Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264674AbSIWBeh>; Sun, 22 Sep 2002 21:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264675AbSIWBeh>; Sun, 22 Sep 2002 21:34:37 -0400
Received: from packet.digeo.com ([12.110.80.53]:62454 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264674AbSIWBeg>;
	Sun, 22 Sep 2002 21:34:36 -0400
Message-ID: <3D8E70D5.5C52985E@digeo.com>
Date: Sun, 22 Sep 2002 18:39:33 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38-mm1
References: <3D8D5F2A.BC057FC4@digeo.com> <20020923004036.GA13921@www.kroptech.com> <3D8E6647.8B02E613@digeo.com> <20020923012557.GA69900@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 01:39:33.0603 (UTC) FILETIME=[1167BB30:01C262A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> 
> On Sun, Sep 22, 2002 at 05:54:31PM -0700, Andrew Morton wrote:
> 
> > It found a bug.  Someone is calling kmem_cache_create() in an
> > atomic region.
> 
> And kmem_cache_alloc() has jumped to the top of the profile (checked
> with readprofile) in 2.3.38-linus.
> 

Linus disabled the cpu-local caches if slab debugging is
enabled.  This is because they were not being poisoned,
and so SMP machines were not getting the full debug benefit
of slab poisoning.

If you disable kernel debugging (either in config, or locally
in slab) then it should be fine.

Slab performance has always been sucky with debug enabled,
so no real loss there.
