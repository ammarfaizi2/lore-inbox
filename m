Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWBNGCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWBNGCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWBNGCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:02:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57837 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030473AbWBNGCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:02:03 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
 process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
	<m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru>
	<20060213170207.GB24200@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 13 Feb 2006 22:59:35 -0700
In-Reply-To: <20060213170207.GB24200@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Mon, 13 Feb 2006 11:02:07 -0600")
Message-ID: <m1slqmtr94.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This seems a very valid point.  And even if you implement code to detect
> when a process exits whether it is a child_reaper for some pspace, you
> can't just make pspace->child_reaper = pspace->child_reaper->child_reaper,
> as the wid may not be valid in the grandparent's namespace, right?

Right. What I have done is in the PSPACE_EXIT condition all children
when they die self reap and have the global process reaper set to their
parent.  However since exit_signal == -1 the initial process reaper
never sees them.

Even for a nested pspace I figure it is an error for anything to outlive
init.  The wid not working is a valid reason for this however if it was
really necessary a new wid value could be allocated.  As nothing on
the inside of a pspace is directly aware of it. 

The situation is very similar to being behind a NAT firewall.

Eric
