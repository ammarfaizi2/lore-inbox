Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313808AbSDIA7N>; Mon, 8 Apr 2002 20:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313809AbSDIA7M>; Mon, 8 Apr 2002 20:59:12 -0400
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:25767 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S313808AbSDIA7L>; Mon, 8 Apr 2002 20:59:11 -0400
Date: Tue, 9 Apr 2002 01:56:57 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@zip.com.au>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, nahshon@actcom.co.il,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020409015657.A28889@kushida.apsleyroad.org>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz> <20020408174333.A28116@kushida.apsleyroad.org> <20020408124803.A14935@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> > > Well, noflushd already seems to work pretty well ;-). But I see kernel
> > > support may be required for SCSI.
> > 
> > I've had no luck at all with noflushd on my Toshiba Satellite 4070CDT.
> > It would spin down every few minutes, and then spin up _immediately_,
> > every time.  I have no idea why.
> 
> Were you using the console?  Any activity on ttys causes device inode 
> atime/mtime updates which trigger disk spin ups.  The easiest way to 
> work around this is to run X while using devpts for the ptys.

I was using X, nodiratime on all /dev/hda mounts.  My friend who has the
small VAIO with a Crusoe chip also reports the same problem: noflushd
doesn't work with 2.4 kernels (versions that we tried), and the problem
is the same: it spins down and then spins up immediately afterward.

That just gave me a small idea: maybe the log message to say "disk spun
down" was triggering a write to disk which spun the disk up again... :-)
My syslog.conf is quite clear about having - in front of the paths for
/var/log/messages and /var/log/kernel though, so syslogd should not be
calling fsync.

If someone knows that noflushd has been since version 2.5 for
2.4.current (or 2.5.current) kernels, then I'll give it another spin as
it were, and report the results.  I'd much prefer "proper" kernel
support as is being discussed in this thread though, i.e. writeout of
dirty pages prior to spin down, that sort of thing.  noflushd always
seemed to me a rather questionable hack.

cheers,
-- Jamie
