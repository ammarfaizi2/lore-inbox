Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWBFUgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWBFUgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWBFUgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:36:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31105 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964801AbWBFUgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:36:37 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
	<20060206201521.GA2470@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:34:58 -0700
In-Reply-To: <20060206201521.GA2470@ucw.cz> (Pavel Machek's message of "Mon,
 6 Feb 2006 20:15:21 +0000")
Message-ID: <m1vevsi5u5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> There are two issues here.
>> 1) Monitoring.  (ps, top etc)
>> 2) Control (kill).
>> 
>> For monitoring you might need to patch ps/top a little but it is doable
> without
>> 2 pids.
>> 
>> For kill it is extremely rude to kill processes inside of a nested pid space.
>> There are other solutions to the problem.
>
> Can you elaborate? If I have 10 containers with 1000 processes each,
> it would be nice to be able to run top then kill 40 top cpu hogs....

So I just posted my patches to lkml if you want to see the details.
But the way I have implemented it each container has a pid in it's parent's
pid namespace.  

That pid to top looks essentially a thread group leader, and top will
tell you which container contains the cpu hogs.

Currently from the outside your choice is to kill or not kill the entire
container.  Which let's you kill the cpu hogs.  The control is not broken
down so fine that it is easy to do something the sysadmin of the container
should be doing.

Eric
