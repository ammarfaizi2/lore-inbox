Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUIFDAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUIFDAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267406AbUIFC7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 22:59:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:41707 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264531AbUIFC7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:59:11 -0400
Date: Sun, 5 Sep 2004 10:02:00 +0200
From: Greg KH <greg@kroah.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs -> udev transition: vcsN are not created
Message-ID: <20040905080200.GC10292@kroah.com>
References: <200408251517.31608.vda@port.imtp.ilyichevsk.odessa.ua> <200408271248.59746.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408271248.59746.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 12:48:59PM +0300, Denis Vlasenko wrote:
> Hi Greg,
> 
> On Wednesday 25 August 2004 15:17, Denis Vlasenko wrote:
> > I am migrating my 2.6 systems from devfs to udev.
> > Versions:
> >
> > # uname -a
> > Linux firebird 2.6.7-bk20 #6 Mon Jul 12 01:23:31 EEST 2004 i686 unknown
> > # ls -d udev* hotplug*
> > hotplug-2004_04_01  udev-030
> >
> > In early boot, when root fs is readonly yet, I start udev this way:
> >
> > mount -t ramfs none /dev
> > env - udevd & sleep 1
> > udevstart
> >
> > and then continue as normal. Things mostly work.
> > However, I noticed that vcsN device nodes are missing
> > (I tried to start Midnight Commander and it failed).
> > This can be due to the fact that I start agettys very
> > late in boot sequence, and thus all ttyN's were not
> > open at the time of udevstart, only first one was (tty1).
> >
> > I logged in and did:
> >
> > # ls -l /udev >before
> > # strace -o us.log udevstart
> > # ls -l /udev >after
> > # diff -u before after >diff
> >
> > This worked, vcsN's appeared:
> [snip]
> 
> As you suggested, I tried 2.6.9-rc1-mm1. Sorry. It does not work.
> 
> My hotplug is instrumented a bit
> to log invocations to syslog. I did 'cat >/dev/tty13':
> 
> hotplug[1196]: cmd: /sbin/hotplug vc
> hotplug[1196]: env: DEVPATH=/class/vc/vcs13 PATH=/sbin:/bin:/usr/sbin:/usr/bin
> ACTION=add PWD=/ SHLVL=1 HOME=/ SEQNUM=232 _=/sbin/env
> hotplug[1198]: cmd: /sbin/hotplug vc
> hotplug[1198]: env: DEVPATH=/class/vc/vcsa13 PATH=/sbin:/bin:/usr/sbin:/usr/bin
> ACTION=add PWD=/ SHLVL=1 HOME=/ SEQNUM=233 _=/sbin/env
> hotplug[1198]: run: /etc/hotplug.d/default/default.hotplug vc
> hotplug[1196]: run: /etc/hotplug.d/default/default.hotplug vc
> hotplug[1196]: run: /etc/hotplug.d/default/udev.hotplug vc
> hotplug[1198]: run: /etc/hotplug.d/default/udev.hotplug vc
> 
> 	/dev/vcs[a]13 did NOT appear.
> 	I waited ~15 secs and ^C'ed cat:

Hm, this works for me.

What does /sys/class/vc/ contain?  Any "vcs" files there?  If not,
that's the issue.

thanks,

greg k-h
