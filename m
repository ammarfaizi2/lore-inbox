Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbUBYHPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbUBYHPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:15:37 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:15835 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262646AbUBYHPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:15:25 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Date: Wed, 25 Feb 2004 12:45:07 +0530
User-Agent: KMail/1.5
Cc: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20040218225010.GH321@elf.ucw.cz> <20040224235725.GL1052@smtp.west.cox.net> <20040225000819.GE9209@elf.ucw.cz>
In-Reply-To: <20040225000819.GE9209@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402251245.07602.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 Feb 2004 5:38 am, Pavel Machek wrote:
> Hi!
>
> > > I'll try to import kgdb into quilt to make working with it
> > > easier. [But don't expect miracles.]
> >
> > Just let us know what it takes to do so. :)
>
> This is what I did to get it under quilt. (Then, patches directory
> should be put under CVS and replace what we have in the CVS now).

Quilt is a great tool!

I follow a slightly different procedure.
I manually copy files from patches directory to cvs tree and back.

I trash my tree too many times, perhaps because I am new to quilt. Above 
procedure saves my cvs tree. While cvs is meant for precisely this purpose 
(save repository in a separate place where it can't be trashed), cvs sync can 
take a long time when done over internet.

-Amit

>
> root@amd:/usr/src# cp -a clean.2.5/ linux-mm
> root@amd:/usr/src/linux-mm# exit
> pavel@amd:/usr/src$ cd linux-mm
> pavel@amd:/usr/src/linux-mm$ mkdir patches
> pavel@amd:/usr/src/linux-mm$ mkdir txt
> pavel@amd:/usr/src/linux-mm$ mkdir .pc
> pavel@amd:/usr/src/linux-mm$ quilt import -n core-lite
> ~/sf/kgdb-2/core-lite.patch Importing patch core-lite (stored as
> patches/core-lite)
> pavel@amd:/usr/src/linux-mm$ quilt import -n i386-lite
> ~/sf/kgdb-2/i386-lite.patch Importing patch i386-lite (stored as
> patches/i386-lite)
> pavel@amd:/usr/src/linux-mm$ quilt import -n 8250 ~/sf/kgdb-2/8250.patch
> Importing patch 8250 (stored as patches/8250)
> pavel@amd:/usr/src/linux-mm$ quilt import -n x86_64
> ~/sf/kgdb-2/x86_64.patch Importing patch x86_64 (stored as patches/x86_64)
> pavel@amd:/usr/src/linux-mm$ quilt import -n ppc ~/sf/kgdb-2/ppc.patch
> Importing patch ppc (stored as patches/ppc)
> pavel@amd:/usr/src/linux-mm$ quilt import -n core ~/sf/kgdb-2/core.patch
> Importing patch core (stored as patches/core)
> pavel@amd:/usr/src/linux-mm$ quilt import -n i386 ~/sf/kgdb-2/i386.patch
> Importing patch i386 (stored as patches/i386)
> pavel@amd:/usr/src/linux-mm$ quilt import -n eth ~/sf/kgdb-2/eth.patch
> Importing patch eth (stored as patches/eth)
> pavel@amd:/usr/src/linux-mm$
>
> At this point project is controlled with quilt. If I do
>
> pavel@amd:/usr/src/linux-mm$ quilt push 5
> Applying eth
> ...
>
> It applies all -lite patches and non-conflicting patches. I can modify
> them as I wish. At the end I need to do quilt refresh <whatever patch
> I changed>.
>
> If I wanted my changes to go into the non-lite version, instead, I'd
> have to begin with quilt push 7.
>
> > > > - All of the function pointer games (of which the weak symbols, but
> > > > not all of them) are a part of.
> > > > - kgdb_schedule/process_breakpoint, required for kgdboe, harmless to
> > > > use on serial.
> > > >
> > > >
> > > > There's still a lot of stuff I checked into linux-2.6-kgdb that's
> > > > non-trivially important
> > > > (http://ppc.bkbits.net:8080/linux-2.6-kgdb/ChangeSet@-4w?nav=index.ht
> > > >ml)
> > >
> > > Hmm, I'm not allowed to use bt :-(.
> >
> > You can look at it all via the web 'tho.  There's nothing to agree to,
> > to view the web page :)
>
> Well, I took a look at the web page, but could not find all the
> kgdb-related changes easily...
> 							Pavel

