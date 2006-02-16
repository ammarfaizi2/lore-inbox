Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWBPSxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWBPSxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbWBPSxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:53:42 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21945 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030432AbWBPSxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:53:41 -0500
Subject: Re: (pspace,pid) vs true pid virtualization
From: Dave Hansen <haveblue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
In-Reply-To: <20060216184407.GC11974@sergelap.austin.ibm.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	 <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	 <20060216142928.GA22358@sergelap.austin.ibm.com>
	 <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
	 <20060216175326.GA11974@sergelap.austin.ibm.com>
	 <m1mzgrp3nl.fsf@ebiederm.dsl.xmission.com>
	 <20060216184407.GC11974@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 10:52:59 -0800
Message-Id: <1140115979.21383.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 12:44 -0600, Serge E. Hallyn wrote:
> Now Dave and I were just talking about actually using the
> init process in a pspace to do administration from outside.
> For instance, the userspace code, in /sbin/pspaceinit, which
> runs as (pspace 2, pid 1), could open a pipe with it's parent
> (pspace1, pid 234).  pid 234 can then ask the init process to
> do things like list processes, kill a process, and maybe even
> recursively talk to the init process in pspace 3.

This would require a much smarter init, and that a child be nice,
cooperate and pass on what is requested of it if it's nested children
are to be killed.  If a child decided to be mean and ignore its parent's
requests, the parent can always just kill the child.

(Read the last sentence, and in case you're wondering, no I don't have
any children in real life)

-- Dave

