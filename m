Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVCMN4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVCMN4C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 08:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCMN4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 08:56:02 -0500
Received: from hs-grafik.net ([80.237.205.72]:30984 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S261258AbVCMNzm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 08:55:42 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: Fw: 2.6.11-rc5-mm1: reiser4 eating cpu time
Date: Sun, 13 Mar 2005 14:55:39 +0100
User-Agent: KMail/1.7.2
References: <20050303184456.534aedb6.akpm@osdl.org> <200503131424.33498@zodiac.zodiac.dnsalias.org> <1110721491.5056.54.camel@pc7.dolda2000.com>
In-Reply-To: <1110721491.5056.54.camel@pc7.dolda2000.com>
Cc: reiserfs-dev <reiserfs-dev@namesys.com>, linux-kernel@vger.kernel.org
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503131455.39769@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 13. März 2005 14:44 schrieben Sie:
> That seems very much like expected behavior to me. I would expect kwrite
> to start loading the file, and then having pdflush kick in to page out
> parts of kwrite, so that it can allocate more memory. Then kwrite will
> continue to load until more of it needs to be paged out, at which point
> pdflush will engage again, and so on, until the file is loaded.

Well not quite. kwrite uses not so much ram. And I have 1Gig:
alex@t40:/files/ipt$ cat gross > /dev/null
alex@t40:/files/ipt$ free
             total       used       free     shared    buffers     cached
Mem:       1032592     507564     525028          0        868     336072
-/+ buffers/cache:     170624     861968
Swap:       498920          0     498920
alex@t40:/files/ipt$ kwrite gross

[1]+  Stopped                 kwrite gross
# kwrite loaded completely
alex@t40:/files/ipt$ free
             total       used       free     shared    buffers     cached
Mem:       1032592     848900     183692          0        876     651632
-/+ buffers/cache:     196392     836200
Swap:       498920          0     498920

Acording to top:
 PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  CODE DATA COMMAND
18436 alex      16   0 44476  29m  14m S  0.0  2.9   0:11.04    4  13m kwrite

> Of course, I don't know if you may have a gig or so of RAM, but I'm
> having trouble believing that a 150 MB file could be kept in cache,
> especially given that kwrite allocates at least as much anonymous memory
> to hold it internally.

Is there any whay I can be sure a file is cached? cat file > /dev/null takes 
130ms, that should be ok?

> Now, I can't really speak for reiser4, but it doesn't seem too
> incredible that it would be flushing page usage or rebalancing some tree
> or something like that. As long as it is niced down (I dunno if it
> actually is, though...), that shouldn't be a problem.

Well, It's not niced down, and it was doing what so ever while reading, not 
while writing?

regards
Alex

> > regards
> > Alex
> >
> > Am Donnerstag, 10. März 2005 15:22 schrieb E.Gryaznova:
> > > I opened  190Mb textfile with kwrite and tried  to  do  "goto line
> > > number 1 800 000" (file has about 6 000 000 lines). File is placed not
> > > on reiser4 but on ext2 partition. And I see that  kwrite eats about
> > > 90-100% CPU.
> > > Does kwrite work fine for you on so big files on ext2 filesystem?
> > >
> > > I have the following kde version:
> > > grev@flint:~> kwrite --version
> > > Qt: 3.2.1
> > > KDE: 3.1.4
> > > KWrite: 4.1
> > >
> > > Thanks,
> > > Lena.
> > >
> > > >Begin forwarded message:
> > > >
> > > >Date: Fri, 4 Mar 2005 02:24:36 +0100
> > > >From: Alexander Gran <alex@zodiac.dnsalias.org>
> > > >To: linux-kernel@vger.kernel.org
> > > >Subject: 2.6.11-rc5-mm1: reiser4 eating cpu time
> > > >
> > > >
> > > >Hi,
> > > >
> > > >I have a reiser4 partition on a local IDE disk. I opened a 130MB
> > > > textfile with kwrite, and killed it while ot opened the file (took to
> > > > long...) diskio was finished at this point.
> > > >a [ent:hda6.] Process was eating 100% CPU time for several (54)
> > > > seconds. Is this a normal, expected behaviour?
> > > >After trying again, pdflush was eating much cpu time, about the same
> > > > (50+ secs) Note that this happend after reiser4 panic (on an external
> > > > disk as reported several minutes ago).
> > > >
> > > >regards
> > > >Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
