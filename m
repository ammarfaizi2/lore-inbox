Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWBBPP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWBBPP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBBPP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:15:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41390 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751138AbWBBPP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:15:27 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
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
	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
	<43E21BD0.6000606@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Feb 2006 08:13:52 -0700
In-Reply-To: <43E21BD0.6000606@sw.ru> (Kirill Korotaev's message of "Thu, 02
 Feb 2006 17:48:48 +0300")
Message-ID: <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> In fact this is almost what OpenVZ does for half a year, both containers and
> VPIDs.
> But it is very usefull to see process tree from host system. To be able to use
> std tools to manage containers from host (i.e. ps, kill, top, etc.). So it is
> much more convinient to have 2 pids. One globally unique, and one for container.

There are two issues here.
1) Monitoring.  (ps, top etc)
2) Control (kill).

For monitoring you might need to patch ps/top a little but it is doable without
2 pids.

For kill it is extremely rude to kill processes inside of a nested pid space.
There are other solutions to the problem.

It is undesireable to make it too easy to communicate through the barrier because
then applications may start to take advantage of it and then depend on
it and you will have lost the isolation that the container gives you.

Eric
