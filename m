Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315812AbSEEByT>; Sat, 4 May 2002 21:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315813AbSEEByS>; Sat, 4 May 2002 21:54:18 -0400
Received: from web21510.mail.yahoo.com ([66.163.169.59]:897 "HELO
	web21510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315812AbSEEByS>; Sat, 4 May 2002 21:54:18 -0400
Message-ID: <20020505015417.76681.qmail@web21510.mail.yahoo.com>
Date: Sun, 5 May 2002 02:54:17 +0100 (BST)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: Re: PATCH, IDE corruption, 2.4.18
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020505002212.GA2392@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

 --- Mike Fedyk <mfedyk@matchmail.com> wrote: > On Sat, May 04, 2002 at
01:15:20PM +0100, Neil Conway wrote:
> > -	byte stat;
> > +	byte stat,unit;
> 
> [snip]
> 
> >  #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
> > -	byte unit = (drive->select.b.unit & 0x01);
> > +	unit = (drive->select.b.unit & 0x01);
> 
> Why are you moving the init of "unit" out of that ifdef?

Basically to make it compile.  I'm only moving the declaration, and
that's only because I need to abort the routine BEFORE the second line
of the ifdef switches off DMA on that unit.  I did compile a version
with the ifdef split into two bits but I decided that was a little
messy. (It won't compile if my check goes in before the first line of
the ifdef as originally written as it declares a variable and C won't
let declarations follow plain code.)

> Can you see if this problem is still in 2.5 also? 

I haven't got a 2.5.13 tree but I found 2.5.7 on a source browser
online and verified that, back then at least, ide-features.c was still
basically the same.  Of course, the routines in between
ide_register_subdriver and ide_config_drive_speed might have been
different.  If someone can look at the code-path between these two
routines in 2.5.13 to see if there is any check on whether or not the
hwgroup is busy (or simply whether or not DMA is in progress) that
would clear it up.  I'll probably download 2.5.13 sometime soon anyway.

cheers
Neil

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
