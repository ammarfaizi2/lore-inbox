Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbRF2KKM>; Fri, 29 Jun 2001 06:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265846AbRF2KJx>; Fri, 29 Jun 2001 06:09:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22972 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265830AbRF2KJu>;
	Fri, 29 Jun 2001 06:09:50 -0400
Date: Fri, 29 Jun 2001 06:09:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Edmund GRIMLEY EVANS <edmundo@rano.org>, linux-kernel@vger.kernel.org
Subject: Re: directory order of files
In-Reply-To: <E15FuhY-0008QC-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0106290546450.25765-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jun 2001, Alan Cox wrote:

> > With Linux ext2, and some other systems, when you create files in a
> > new directory, the file system remembers their order:
> 
> No - it merely seems too. 
> 
> > $ touch one two three four
> > $ ls -U
> > one  two  three  four
> 
> Then try 'rm three; touch five'

Moreover, it isn't true even for the case when we create a list of files
in empty directory. Example: assuming that /tmp has 1Kb blocks,

mkdir /tmp/A
cd A
touch `perl -e 'print "a"x255'`
touch `perl -e 'print "b"x255'`
touch `perl -e 'print "c"x255'`
touch `perl -e 'print "d"x255'`
touch A
ls -U

will give you (lots of a) (lots of b) (lots of c) A (lots of d).

With 4Kb blocks you'll need 16 long names instead of 4 - the effect
will be the same.

The reason is quite simple - at some point you get no space for long
name and it goes into the next directory block, but there's still enough
for a short name, so it gets created in the first block.

IOW, there's no warranties at all.

