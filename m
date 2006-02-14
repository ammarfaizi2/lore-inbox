Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422860AbWBNWvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422860AbWBNWvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422861AbWBNWvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:51:11 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54677
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1422860AbWBNWvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:51:09 -0500
From: Rob Landley <rob@landley.net>
To: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 17:51:01 -0500
User-Agent: KMail/1.8.3
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <43F1C385.nailMWZ599SQ5@burner> <20060214122333.GA32743@merlin.emma.line.org>
In-Reply-To: <20060214122333.GA32743@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141751.02153.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 7:23 am, Matthias Andree wrote:
> > -	How to send non disturbing SCSI commands from another
> > 	cdrecord process in case one or more are already running?
>
> Open the device node you obtained and
> send non-disturbing commands through it.
>
> No special treatment required.

On a mostly unrelated note, I've pondered adding quick and dirty versions of 
mkisofs and cdrecord to busybox for a while.  (Low priority, back burner 
thing.)  I actually poked at the cdrecord source once or twice, but it's 
unintellgible and disgusting.*

With mkisofs I can just start from the spec, reverse engineer a few existing 
ISOs, or grab the really old code from before Joerg got ahold of it (back 
when it was still readable).  That's no problem.  But for cdrecord, I can't 
find documentation on what the kernel expects.

I'm only interested in supporting ATA cd burners under a 2.6 or newer kernel, 
using the DMA method.  (SCSI is dead, I honestly don't care.)  I was hoping I 
could just open the /dev/cdrom and call the appropriate ioctls on it, but 
reading the cdrecord source proved enough of an exercise in masochism that I 
always give up after the first hour and put it back on the todo list.

I suppose I should say "screw the source code" and just run the cdrecord 
binary under strace to see what it's doing, but I thought I'd ask: is there a 
good starting place, somewhere?  (Or is there already a simple "cdrecord 
file.iso /dev/cdrom" someplace?)  I expect I'll wind up buying a 50-pack of 
coasters anyway, and I doubt I'll damage my laptop's burner too badly...

Rob

* How bad?  Random example of ignoring how the rest of the world works is that 
it runs autoconf from within make, meaning there's no obvious way to specify 
"./configure --prefix=/mypath", so the last time I played with it (which was 
a while ago), I wound up doing this:

cd /sources &&
tar xvjf buildtools/cdrtools-2.00.3.tar.bz2 &&
cd cdrtools-2.00.3 &&
make &&
cp mkisofs/OBJ/*/mkisofs cdrecord/OBJ/*/cdrecord \ 
cdda2wav/OBJ/*/cdda2wav /usr/bin &&
cp mkisofs/mkisofs.8 /usr/man/man8 &&
cp cdrecord/cdrecord.1 cdda2wav/cdda2wav.1 /usr/man/man1 &&
cd .. &&
rm -rf cdrtools-2.00.3

if [ $? -ne 0 ]; then exit 1; fi

I could understand if it didn't use autoconf at all, but having autoconf but 
_not_ a configure step is deeply into control freak territory...

Rob
-- 
Never bet against the cheap plastic solution.
