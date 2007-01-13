Return-Path: <linux-kernel-owner+w=401wt.eu-S1751384AbXAMX6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbXAMX6v (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXAMX6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:58:51 -0500
Received: from a80-100-32-23.adsl.xs4all.nl ([80.100.32.23]:50811 "EHLO
	mail.vanvergehaald.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbXAMX6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:58:50 -0500
Date: Sun, 14 Jan 2007 00:58:44 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Willy Tarreau <w@1wt.eu>
Cc: Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: tuning/tweaking VM settings for low memory (preventing OOM)
Message-ID: <20070113235844.GA19610@shuttle.vanvergehaald.nl>
References: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org> <20070113072217.GW24090@1wt.eu> <20070113131601.GA12901@shuttle.vanvergehaald.nl> <20070113143027.GA16868@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113143027.GA16868@1wt.eu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 03:30:27PM +0100, Willy Tarreau wrote:
> On Sat, Jan 13, 2007 at 02:16:01PM +0100, Toon van der Pas wrote:
> > On Sat, Jan 13, 2007 at 08:22:18AM +0100, Willy Tarreau wrote:
> > > > 
> > > > Which makes me think that we aren't writing back fast enough.  If I  
> > > > mount the drive "sync" the issue clearly goes away.
> > > > 
> > > > It appears from an strace we are doing ftruncate64(5, 178257920) when  
> > > > we OOM.
> > > > 
> > > > Any ideas on VM parameters to tweak so we throttle this from occurring?
> > > 
> > > Take a look at /proc/sys/vm/bdflush. There are several useful parameters
> > > there (doc is in linux-xxx/Documentation). For instance, the first column
> > > is the percentage of memory used by writes before starting to write on
> > > disk. When using tcpdump intensively, I lower this one to about 1%.
> > 
> > Hi Willy,
> > 
> > I know you're doing a great job on keeping the 2.4 kernel in shape,
> > but do you also have a good advice for people with more recent
> > kernels?  (hint: the file /proc/sys/vm/bdflush is missing)
> 
> OK OK OK... Next time I will have coffee *before* replying :-)
> 
> Check /proc/sys/vm/dirty_ratio and dirty_background_ratio. Both are
> percentage of total memory. The first one is for "foreground" writes
> (ie the writing process may block) while the second one is for
> "background" writes :
> 
> $ uname -a
> Linux hp 2.6.16-rc2-pa1 #1 Fri Feb 3 23:34:56 MST 2006 parisc unknown
> $ cat /proc/sys/vm/dirty_ratio 
> 40
> $ cat /proc/sys/vm/dirty_background_ratio 
> 10
> 
> Again, lowering those values should help writing data to disk
> sooner. Also you should take a look at min_free_kbytes (although
> I've not played with it yet) :

Ahh, okay, I didn't really understand these parameters before.
Now I think I understand what they are supposed to do.
I'll do some experiments with them.

Thanks for your help.
Toon.

BTW: That's pretty exotic hardware you have there (parisc).  ;-)
