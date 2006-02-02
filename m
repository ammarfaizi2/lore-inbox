Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWBBPYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWBBPYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWBBPYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:24:48 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:13840 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932072AbWBBPYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:24:40 -0500
Message-ID: <43E2249D.8060608@sw.ru>
Date: Thu, 02 Feb 2006 18:26:21 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>In fact this is almost what OpenVZ does for half a year, both containers and
>>VPIDs.
>>But it is very usefull to see process tree from host system. To be able to use
>>std tools to manage containers from host (i.e. ps, kill, top, etc.). So it is
>>much more convinient to have 2 pids. One globally unique, and one for container.
> 
> 
> There are two issues here.
> 1) Monitoring.  (ps, top etc)
> 2) Control (kill).
> 
> For monitoring you might need to patch ps/top a little but it is doable without
> 2 pids.
> 
> For kill it is extremely rude to kill processes inside of a nested pid space.
> There are other solutions to the problem.
it is not always good idea to fix the tools everytime new functionality 
is involved. why do you think there are no more tools except for 
ps,top,kill? will you fix it all?

Another example, when you have problems in your VPS it is very 
convinient to attach with strace/gdb/etc from the host. Will you patch 
it as well?

OpenVZ big advantage is this ease of administering compared to VM 
approach and it is not good idea to forbid this. If you have broken VM 
you have problems, in OpenVZ you have control over VPSs.

> It is undesireable to make it too easy to communicate through the barrier because
> then applications may start to take advantage of it and then depend on
> it and you will have lost the isolation that the container gives you.
in OpenVZ we have VPSs fully isolated between each other.
But host system has access to some of VPS resources such as files, 
processes, etc. I understand your concern which is related to 
checkpointing, yeah?

Kirill

