Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVAITZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVAITZK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVAITZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:25:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:62674 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261711AbVAITXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:23:41 -0500
Subject: Re: [PATCH] scheduling priorities with rlimit
From: utz lehmann <lkml@s2y4n2c.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <1105297598.4173.52.camel@laptopd505.fenrus.org>
References: <1105290936.24812.29.camel@segv.aura.of.mankind>
	 <1105297598.4173.52.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 09 Jan 2005 20:23:32 +0100
Message-Id: <1105298613.24812.42.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-09 at 20:06 +0100, Arjan van de Ven wrote:
> On Sun, 2005-01-09 at 18:15 +0100, utz lehmann wrote:
> > Hi
> > 
> > I really like the idea of controlling the maximum settable scheduling
> > priorities via rlimit. See the Realtime LSM thread. I want to give users
> > the right to raise the priority of previously niced jobs.
> > 
> > I have modified Chris Wright's patch (against 2.6.10):
> > (http://marc.theaimsgroup.com/?l=linux-kernel&m=110513793228776&w=2)
> > 
> > - allow always to increase nice levels (lower priority).
> > - set the default for RLIMIT_PRIO to 0.
> > - add the other architectures.
> > 
> > With this the default is compatible with the old behavior.
> > 
> > With RLIMIT_PRIO > 0 a user is able to raise the priority up to the
> > value. 0-39 for nice levels 19 .. -20, 40-139 for realtime priorities
> > (0 .. 99).
> 
> this is a bit of an awkward interface don't you think?
> I much rather have the rlimit match the exact nice values we communicate
> to userspace elsewhere, both to be consistent and to not expose
> scheduler internals to userpsace.

Yes it is. But rlimits are unsigned .-( (asm/resource.h says this).
I prefer rlimit match nice value too, but how to do this with unsigned.
And what do with the RT prio, different rlimit?
Btw: I saw this on a solaris command too, 0-39 for nice, 40-139 for RT
(dont rememer which).

>
> Also I like the idea of allowing sysadmins to make certain users/groups
> nice levels 5 and higher (think a university machine that makes all
> students nice 5 and higher only, while giving staff 0 and higher, and
> the sysadmin -5 and higher ;)

You can do this already. "priority" item in /etc/security/limits.conf.
But they can only lower the priority.
This patch is for allowing to raise it.


