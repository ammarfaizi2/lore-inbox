Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266863AbUFYVoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266863AbUFYVoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266866AbUFYVoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:44:44 -0400
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:55168 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266863AbUFYVol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:44:41 -0400
Date: Fri, 25 Jun 2004 23:44:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Amit Gud <gud@eth.net>, alan <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040625214418.GB5907@elf.ucw.cz>
References: <20040625162537.GA6201@elf.ucw.cz> <200406251707.i5PH7KOw009004@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406251707.i5PH7KOw009004@eeyore.valparaiso.cl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Case closed, anyway. It belongs in the kernel only if there is no
> > > reasonable way to do it in userspace.
> > 
> > But... there's no reasonable way to do this in userspace.
> 
> Let's see...
> 
> > Two pieces of kernel support are needed:
> > 
> > 1) some way to indicate "this file is elastic" (okay perhaps xattrs
> > can do this already)
> 
> Or just a list of elastic files in ~/.elastic. Even better, could mark them
> as "Just delete", "compress"; could go as far as giving (fallback?) globs
> to select files for each treatment ("If space gets tight, delete *~ files,
> and compress *.tex that haven't been read in a week"). Sounds like a fun
> Perl project...

.elastic is ugly but okay.

> > and either
> > 
> > 2a) file selection/deletion in kernel
> 
> A daemon or cron job running as root can do that just fine. Or you can set
> it up for your own files.

If I make it cron job once an hour, users will still get -ENOSPC for
up-to hour. You can make it down to second, but you'll still get
-ENOSPC from time to time. If you want to eliminate -ENOSPC
altogether, you'll delete file from kernel just before returning
-ENOSPC and retry operation. 

> > 2b) assume that disk does not fill up faster than 1GB/sec, allways
> > keep 1GB free, make "deleting" daemon poll each second [ugly,
> > unreliable]
> 
> Buy a larger disk. Make sure sum of all hard quotas is less than filesystem
> size. Need that anyway; so it reduces to a one-user problem with per-user
> solutions. 

Well, having sum of all hard quotas > filesystem size was point of
this excersize...

> > BTW 2c) would be also usefull for undelete. Unfortunately 2c looks
> > very complex, too; it might be easier to do 2a than 2c.
> 
> As said, all this buys very little for a lot of hairy code in the kernel,
> which will be rarely used (and whose bugs will show up when it is badly
> needed to work right). Besides, I strongly oppose automatic file

It may be little gain for lots of effort. I'm just trying to say that
it is not complete nonsense.

I guess we are basically agreeing with each other... It may make nice
student project, and if patch is very non-intrusive, I guess its
okay. If it turns to be hairy, its not worth bothering.

> that, so you have no right to know", no "undelete deleted files, but only
> sometimes; it just might still be around, but if space got tight it isn't"
> (this is even worse...))

Well, few times I wished unix had undelete... It actually *has* one,
and its called power button if you are realize your mistake within 5
seconds.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
