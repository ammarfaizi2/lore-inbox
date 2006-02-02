Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWBBVcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWBBVcp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWBBVcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:32:45 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:4342 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932284AbWBBVcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:32:32 -0500
Message-ID: <43E27A68.40003@fr.ibm.com>
Date: Thu, 02 Feb 2006 22:32:24 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>	<43E2249D.8060608@sw.ru> <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>	<43E22DCA.3070004@sw.ru> <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> For everything except the PID namespace I am just interested in having multiple
> separate namespaces.  For the PID namespace to keep the traditional unix
> model you need a parent process so it is actually nesting.
> 
> I am interested because, it is easy, because if it is possible than
> the range of applications you can apply a containers to is much
> larger.  At the far end of that spectrum is migrating a server running
> on real hardware and bringing it up as a guest on a newer much more
> powerful machine.  With the appearance that it had only been
> unreachable for a few seconds.

We gave a name to such containers. We call them 'application' containers
just to make a difference with the 'system' containers, like vserver or openvz.

'application' containers are very useful in an HPC environment where you
can trig checkpoint/restart through batch managers. But, this model,
really, has some virtualization issues on the edge. The virtualisation of
the parent process of such a container is tricky, it can be in multiple
containers at the same time, it can die (difficult to restart ...), it
could belong to another process groups, etc. Plenty of annoying cases to
handle.

'system' containers, like vserver or openvz, are safer because they use a
private PID space.

Now, would it be possible to have an 'application' container using a
private PID space and being friendly to the usual unix process semantics ?
We haven't found a solution yet ...

> Entering is different from execing a process on the inside.
> Implementation wise it is changing the context pointer on your task.

yes and you could restrict that privilege to some top level container, like
the container 0.

C.

