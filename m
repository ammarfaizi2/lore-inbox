Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRACQtz>; Wed, 3 Jan 2001 11:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132581AbRACQtp>; Wed, 3 Jan 2001 11:49:45 -0500
Received: from Cantor.suse.de ([194.112.123.193]:54536 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132577AbRACQtc>;
	Wed, 3 Jan 2001 11:49:32 -0500
Date: Wed, 3 Jan 2001 17:18:57 +0100
From: Andi Kleen <ak@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Dr. David Gilbert" <gilbertd@treblig.org>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010103171857.A4689@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Jan 03, 2001 at 01:26:18PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 01:26:18PM -0200, Rik van Riel wrote:
> On Wed, 3 Jan 2001, Dr. David Gilbert wrote:
> 
> >   I got wondering as to whether the various journaling file
> > system activities were designed to survive the occasional
> > unclean shutdown or were designed to allow the user to just pull
> > the plug as a regular means of shutting down.
> 
> >   Thoughts?
> 
> 1. a journaling filesystem is designed to be "consistent"
>    (or rather, easily recoverable) all of the time

The file system metadata is, but it has no idea if the application's data is 
consistent or not.

Also when you listen to tytso's tales of certain cheap IDE disks writing crap 
when they and the system are powered off during a write you should probably
better not turn off the system running when not absolutely needed.

If the system was designed for situation (2) you would probably only
use applications that do their own log (or some other disk consistency
technique). That does not seem to be the case currently.
Also when unclean shutdown was very common you also be probably better 
of with a complete log structured fs that does not need to replay 
on mount.  


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
