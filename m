Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWBBVoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWBBVoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWBBVoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:44:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:1422 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932299AbWBBVoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:44:01 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43E27A68.40003@fr.ibm.com>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
	 <1137513818.14135.23.camel@localhost.localdomain>
	 <1137518714.5526.8.camel@localhost.localdomain>
	 <20060118045518.GB7292@kroah.com>
	 <1137601395.7850.9.camel@localhost.localdomain>
	 <m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	 <43D14578.6060801@watson.ibm.com>
	 <Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>	<43E21BD0.6000606@sw.ru>
	 <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>	<43E2249D.8060608@sw.ru>
	 <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>	<43E22DCA.3070004@sw.ru>
	 <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>  <43E27A68.40003@fr.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 16:43:54 -0500
Message-Id: <1138916634.17225.18.camel@elg11.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 22:32 +0100, Cedric Le Goater wrote:
> Eric W. Biederman wrote:
> 
> > For everything except the PID namespace I am just interested in having multiple
> > separate namespaces.  For the PID namespace to keep the traditional unix
> > model you need a parent process so it is actually nesting.
> > 
> > I am interested because, it is easy, because if it is possible than
> > the range of applications you can apply a containers to is much
> > larger.  At the far end of that spectrum is migrating a server running
> > on real hardware and bringing it up as a guest on a newer much more
> > powerful machine.  With the appearance that it had only been
> > unreachable for a few seconds.
> 
> We gave a name to such containers. We call them 'application' containers
> just to make a difference with the 'system' containers, like vserver or openvz.
> 
> 'application' containers are very useful in an HPC environment where you
> can trig checkpoint/restart through batch managers. But, this model,
> really, has some virtualization issues on the edge. The virtualisation of
> the parent process of such a container is tricky, it can be in multiple
> containers at the same time, it can die (difficult to restart ...), it
> could belong to another process groups, etc. Plenty of annoying cases to
> handle.

I guess we all experienced that (see everybodies patches).

> 
> 'system' containers, like vserver or openvz, are safer because they use a
> private PID space.

Maybe we are talking about different things, but I thought our patch-set
does provide private pid spaces ( by putting <pid,container> tuple into
the same pid ). Yes, privacy is achieved only by guarding the edges, but
the next approach that was discussed on the mailing list was to indeed 
make container's first class object, hang the pid mgmt and pid lookup
off the container and thus force the isolation.
Containers then hence move up to be children of "init".

>
> Now, would it be possible to have an 'application' container using a
> private PID space and being friendly to the usual unix process semantics ?
> We haven't found a solution yet ...

Could you spell out what specific UNIX semantics you are referring to.
That would help and we can discuss whether and how they can be
addressed.

> 
> > Entering is different from execing a process on the inside.
> > Implementation wise it is changing the context pointer on your task.
> 
> yes and you could restrict that privilege to some top level container, like
> the container 0.
> 

-- 
Hubertus Franke <frankeh@watson.ibm.com>

