Return-Path: <linux-kernel-owner+w=401wt.eu-S1762463AbWLJXXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762463AbWLJXXc (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 18:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762499AbWLJXXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 18:23:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33527 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762424AbWLJXXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 18:23:31 -0500
Date: Mon, 11 Dec 2006 00:23:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Wouter Verhelst <wouter@grep.be>
Cc: Paul Clements <paul.clements@steeleye.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: show nbd client pid in sysfs
Message-ID: <20061210232316.GD32577@elf.ucw.cz>
References: <45762745.7010202@steeleye.com> <20061208211723.GC4924@ucw.cz> <20061210180725.GA29943@country.grep.be> <20061210195819.GA32577@elf.ucw.cz> <20061210231801.GD29943@country.grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210231801.GD29943@country.grep.be>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-12-11 00:18:01, Wouter Verhelst wrote:
> On Sun, Dec 10, 2006 at 08:58:19PM +0100, Pavel Machek wrote:
> > Hi!
> 
> Hi
> 
> > > > > This simple patch allows nbd to expose the nbd-client 
> > > > > daemon's PID in /sys/block/nbd<x>/pid. This is helpful 
> > > > > for tracking connection status of a device and for 
> > > > > determining which nbd devices are currently in use.
> > > > 
> > > > Actually is it needed at all? Perhaps nbd clients should be modified
> > > > to put nbdX in their process nam?
> > > 
> > > I don't think that's the right approach; only the kernel can guarantee
> > > that a given process is actually managing a given nbd device (I could
> > > have some rogue process running around announcing that it's managing
> > > nbd2, and then what?)
> > 
> > I'd say "do not run rogue processes as root" :-).
> > 
> > nbd-client should run as root -- I do not think interface was
> > carefully audited to run it as a user -- so rogue process should not
> > really be a problem.
> 
> IOW, you're suggesting I walk the process list from userspace to find a
> process for which a) it claims it's running for a given nbd device, and
> b) I can verify that it actually has the permissions to do so. That's a
> whole lot of code in comparison to
> 
> f=open("/sys/block/nbd2/pid", O_RDONLY);
> read(f,buf,len);
> 
> I think I very much prefer the above two lines, not only for simplicity.
> 
> Also, your suggestion relies on users /only/ using the official
> nbd-client, and is fragile in cases where that assumption is false
> (i.e., it's susceptible to false negatives). The suggested patch does
> not have that problem.

I do not think finding out "which pid is controlling nbd#2" is _that_
important.

We have /var/lock files for ttyS*, I do not see reason why nbd should
be different. Actually you could copy /var/lock approach.

And BTW that /sys/ thingie is racy by design (as is the log file). By
the time you try to do anything with that PID, process may be gone.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
