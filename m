Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVCMNpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVCMNpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 08:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVCMNpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 08:45:05 -0500
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:55970 "EHLO
	pc18.dolda2000.com") by vger.kernel.org with ESMTP id S261251AbVCMNo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 08:44:57 -0500
Subject: Re: Fw: 2.6.11-rc5-mm1: reiser4 eating cpu time
From: Fredrik Tolf <fredrik@dolda2000.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: reiserfs-dev <reiserfs-dev@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200503131424.33498@zodiac.zodiac.dnsalias.org>
References: <20050303184456.534aedb6.akpm@osdl.org>
	 <4230582F.2050503@namesys.com>
	 <200503131424.33498@zodiac.zodiac.dnsalias.org>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Mar 2005 14:44:51 +0100
Message-Id: <1110721491.5056.54.camel@pc7.dolda2000.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-13 at 14:24 +0100, Alexander Gran wrote:
> Hi, 
> 
> Well, of course it cannot handle that large files (I wouldn't expect that, 
> either). My Problem is that when I open the file, it's not just kwrite but 
> other processes that need so much cpu time. That kwrite is eating cpu is ok. 
> I cannot reproduce the behaviour for some reason however. 
> So for short what's now (2.6.11-mm3) hapening:
> I open a file of 150MB with kwrite. Kwrite start using all cpu it can get
> After some seconds pdflush kicks in. Kwrite seems to wait, and pdflush is 
> eating cpu cyles. These 2 alternate for some time, until file is loaded. 

That seems very much like expected behavior to me. I would expect kwrite
to start loading the file, and then having pdflush kick in to page out
parts of kwrite, so that it can allocate more memory. Then kwrite will
continue to load until more of it needs to be paged out, at which point
pdflush will engage again, and so on, until the file is loaded.

> Please note that this happens when the file is in cache too. No Idea what 
> kwrite is doing here, though.

Of course, I don't know if you may have a gig or so of RAM, but I'm
having trouble believing that a 150 MB file could be kept in cache,
especially given that kwrite allocates at least as much anonymous memory
to hold it internally.

> In the case described earlier ent:hda6. was eating my cpu cyles, even after 
> kwrite was killed!

Now, I can't really speak for reiser4, but it doesn't seem too
incredible that it would be flushing page usage or rebalancing some tree
or something like that. As long as it is niced down (I dunno if it
actually is, though...), that shouldn't be a problem.

HTH
Fredrik Tolf

> regards
> Alex
> 
> Am Donnerstag, 10. März 2005 15:22 schrieb E.Gryaznova:
> > I opened  190Mb textfile with kwrite and tried  to  do  "goto line
> > number 1 800 000" (file has about 6 000 000 lines). File is placed not
> > on reiser4 but on ext2 partition. And I see that  kwrite eats about
> > 90-100% CPU.
> > Does kwrite work fine for you on so big files on ext2 filesystem?
> >
> > I have the following kde version:
> > grev@flint:~> kwrite --version
> > Qt: 3.2.1
> > KDE: 3.1.4
> > KWrite: 4.1
> >
> > Thanks,
> > Lena.
> >
> > >Begin forwarded message:
> > >
> > >Date: Fri, 4 Mar 2005 02:24:36 +0100
> > >From: Alexander Gran <alex@zodiac.dnsalias.org>
> > >To: linux-kernel@vger.kernel.org
> > >Subject: 2.6.11-rc5-mm1: reiser4 eating cpu time
> > >
> > >
> > >Hi,
> > >
> > >I have a reiser4 partition on a local IDE disk. I opened a 130MB textfile
> > > with kwrite, and killed it while ot opened the file (took to long...)
> > > diskio was finished at this point.
> > >a [ent:hda6.] Process was eating 100% CPU time for several (54) seconds.
> > >Is this a normal, expected behaviour?
> > >After trying again, pdflush was eating much cpu time, about the same (50+
> > >secs) Note that this happend after reiser4 panic (on an external disk as
> > >reported several minutes ago).
> > >
> > >regards
> > >Alex
> 

