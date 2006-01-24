Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWAXAWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWAXAWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWAXAWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:22:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14472 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030223AbWAXAWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:22:15 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
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
	 <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	 <43D52592.8080709@watson.ibm.com>
	 <m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
	 <1138050684.24808.29.camel@localhost.localdomain>
	 <m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Jan 2006 00:22:05 +0000
Message-Id: <1138062125.24808.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-23 at 14:30 -0700, Eric W. Biederman wrote:
> The short observation is currently we use at most 22bits of the pid
> space, and we don't need a huge number of containers so combining them
> into one integer makes sense for an efficient implementation, and it
> is cheaper than comparing pointers.

Currently. In addition it becomes more costly the moment you have to
start masking them. Remember the point of this was to virtualise the
pid, so you are going to add a ton of masking versus a cheap extra
comparison from the same cache line. And you lose pid space you may well
need in the future for the sake of a quick hack.

> And there will be at least one processes id assigned to the pid space
> from the outside pid space unless we choose to break waitpid, and friends.

That comes out in the wash because it is already done by process tree
pointers anyway. It has to be because using ->ppid would be racy.

Alan

