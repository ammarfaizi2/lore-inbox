Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTBTPu3>; Thu, 20 Feb 2003 10:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbTBTPu3>; Thu, 20 Feb 2003 10:50:29 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:40369 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265675AbTBTPu2>; Thu, 20 Feb 2003 10:50:28 -0500
Date: Thu, 20 Feb 2003 13:00:12 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Dejan Muhamedagic <dejan@hello-penguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
In-Reply-To: <20030220150559.A27331@smp.colors.kwc>
Message-ID: <Pine.LNX.4.50L.0302201258070.2329-100000@imladris.surriel.com>
References: <20030219171432.A6059@smp.colors.kwc>
 <Pine.LNX.4.50L.0302192004410.2329-100000@imladris.surriel.com>
 <20030220124833.GB4051@lilith.homenet> <Pine.LNX.4.50L.0302201019250.2329-100000@imladris.surriel.com>
 <20030220150559.A27331@smp.colors.kwc>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Dejan Muhamedagic wrote:
> On Thu, Feb 20, 2003 at 10:21:50AM -0300, Rik van Riel wrote:
> > On Thu, 20 Feb 2003, Dejan Muhamedagic wrote:
> >
> > > # mem | grep Cache
> > > Cached:        4569128 kB
> > > SwapCached:     829668 kB
> > > ActiveCache:    136728 kB
> >
> > The "problem" here is that a lot of the memory in Cached: is
> > mapped into process address space, so in effect it is process
> > memory.
>
> Is there a way to split the statistics?  It also sounds confusing :)

ActiveAnon is the active memory mapped into user processes,
plus swap cache.  ActiveCache is the active memory that's
only caching files and not mapped into user memory.

Note that this isn't always correct since a page can start
in one cache and become mapped by user processes, or be
unmapped.  Linux moves the pages lazily.

> > > > In that case you're probably familiar with the cache size
> > > > tuning, since AIX has the exact same tuning knob as rmap ;)
> > >
> > > AIX vmtune -P is equivalent to the Linux cache-max, but cache-max
> > > is not implemented.

> http://publibn.boulder.ibm.com/doc_link/en_US/a_doc_lib/cmds/aixcmds6/vmtune.htm

OK, vmtune -p is equivalent to cache-min, vmtune -P is
equivalent to cache-borrow ...

It looks like AIX doesn't have a cache-max, either.

kind regards,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
