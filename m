Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSAINxS>; Wed, 9 Jan 2002 08:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286590AbSAINxJ>; Wed, 9 Jan 2002 08:53:09 -0500
Received: from [212.169.100.200] ([212.169.100.200]:19960 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S286584AbSAINwv>; Wed, 9 Jan 2002 08:52:51 -0500
Date: Wed, 9 Jan 2002 14:52:24 +0100
From: Morten Helgesen <admin@nextframe.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: axboe@suse.de, dougg@torque.net, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re:  [PATCH] drivers/scsi/psi240i.c - io_request_lock fix
Message-ID: <20020109145224.B7291@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <200201091328.FAA07632@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200201091328.FAA07632@adam.yggdrasil.com>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 05:28:00AM -0800, Adam J. Richter wrote:
> >> = Morten Helgesen
> >  = Douglas Gilbert
> 
> >From the look of this line in the patch:
> >> +       struct Scsi_Host *host = PsiHost[irq - 10];
> >
> >It will work if the first controller is allocated irq 10,
> >the second one irq 11, etc.   Unlikely ...
> 
> 	No, I think Morten has the use of PsiHost right.  The
> entries in PsiHost are apparently stored by IRQ.  It is not generally
> the case that the first controller is at PsiHost[0], the second at
> PsiHost[1], etc.

Even though I am not _that_ familiar with the code in question, that is how I
understood it too.

> 
> 	I agree with Jens in that the practice is rather ugly, but that
> is the way the driver worked before io_request_lock disappeared and
> I think that improving that stylistic issue is not a prerequisite
> for conversion from io_request_lock to host->host_lock.

Ugly it is. It was not my intention to clean up the code, just make the smallest change
necessary to get it to work. The maintainer should probably do a closer examination.

> 
> 	If I were you, Morten, I would go ahead with your patch
> that makes the minimal changes and then, if you want, make stylistic
> improvements as one or more separate patches, which are something
> that you may want to talk over with the mainter of that driver, if
> there currently is one.

Sure - but who is the maintainer ? :)

> 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Det er ikke lett å være menneske" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
