Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271736AbTHDNdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271737AbTHDNdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:33:04 -0400
Received: from www.13thfloor.at ([212.16.59.250]:12680 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271736AbTHDNc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:32:58 -0400
Date: Mon, 4 Aug 2003 15:33:07 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Steven Micallef <steven.micallef@world.net>
Cc: "'Ben Collins'" <bcollins@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: chroot() breaks syslog() ?
Message-ID: <20030804133307.GA4225@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Steven Micallef <steven.micallef@world.net>,
	'Ben Collins' <bcollins@debian.org>, linux-kernel@vger.kernel.org
References: <6416776FCC55D511BC4E0090274EFEF5080024AC@exchange.world.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6416776FCC55D511BC4E0090274EFEF5080024AC@exchange.world.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 03:49:48PM +1000, Steven Micallef wrote:
> You're right - my mistake, it doesn't actually work on 2.4.8 either, I think
> I was looking at the wrong thing when I thought it was actually working.
> 
> Is it worth considering (optionally) making /dev available to chroot()'ed
> environments, or would that just defeat the whole purpose of chroot()?

IMHO, devfs in chroot environment, is defeating the purpose
because if you have access to raw devices, like the device
your chroot dir is on, you can easily mount that device 
again, and voila you have access to the full tree, if you
just have access to, lets say a ramdisk (as raw device of
course), you can also easily write on it, and create the
required device nodes yourself, then mount, and again 
everything is available ...

best thing to do is to copy only those devices, which are
absolutely required to the chrooted environment ...

HTH,
Herbert

> Regards,
> 
> Steve.
> 
> > -----Original Message-----
> > From: Ben Collins [mailto:bcollins@debian.org]
> > Sent: Monday, 4 August 2003 3:19 PM
> > To: Steven Micallef
> > Cc: 'linux-kernel@vger.kernel.org'
> > Subject: Re: chroot() breaks syslog() ?
> > 
> > 
> > > connect(3, {sin_family=AF_UNIX, path="/dev/log"}, 16) = -1 
> > ENOENT (No such
> > > file or directory)
> > > 
> > > Is this intentional? If so, is there a work-around? I 
> > discovered this when
> > > debugging 'rwhod', but I imagine there are many more utils 
> > that would be
> > > affected too.
> > 
> > I don't know how it ever did work, if in fact it did for you. /dev/log
> > is not a kernel device, it's just a normal socket created by syslogd.
> > 
> > Now, if you use devfs, and mount devfs under the chroot, it magically
> > propogates /dev/log. But that's not the normal thing.
> > 
> > -- 
> > Debian     - http://www.debian.org/
> > Linux 1394 - http://www.linux1394.org/
> > Subversion - http://subversion.tigris.org/
> > WatchGuard - http://www.watchguard.com/
> > __________ Information from NOD32 1.449 (20030630) __________
> > 
> > This message was checked by NOD32 for Exchange e-mail monitor.
> > http://www.nod32.com
> > 
> > 
> > 
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
