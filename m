Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWBAQaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWBAQaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWBAQaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:30:11 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:19600 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964993AbWBAQaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:30:08 -0500
Message-ID: <43E0E1D3.5000803@fr.ibm.com>
Date: Wed, 01 Feb 2006 17:29:07 +0100
From: Greg <gkurz@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
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
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org> <m13bj34spw.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13bj34spw.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> On this front I have been planning on using sys_clone as it allows
> pieces of the virtualization to be incrementally built, it already
> supports the FS namespace, and it supports flexibly specifying what
> you want to contain.
> 

What would you do to handle the following case:

pid = getpid();
if (sys_clone(CLONE_CONTAINER) == 0) {
	ppid = getppid();
	assert(ppid == pid);
}

Most of the calls involving resource ids will return values that aren't
*consistent* with ids already stored in userland... could possibly break some
piece of code. Perhaps a sys_exec() should also be enforced to reset the process
memory.

-Greg-
