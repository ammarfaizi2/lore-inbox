Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWBFUb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWBFUb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWBFUb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:31:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24193 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964801AbWBFUbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:31:34 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 01/20] pid: Intoduce the concept of a wid (wait id)
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<20060206195427.GH11887@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:23:48 -0700
In-Reply-To: <20060206195427.GH11887@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Mon, 6 Feb 2006 13:54:27 -0600")
Message-ID: <m13biwjkx7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> 
>> The wait id is the pid returned by wait.  For tasks that span 2
>> namespaces (i.e. the process leaders of the pid namespaces) their
>> parent knows the task by a different PID value than the task knows
>> itself. Having a child with PID == 1 would be confusing. 
>
> Is it possible here to have wid conflicts?
>
> Does that matter?
>
> Looking at sysvinit, it seems that it does.  If the wid happens
> to conflict with the pid of one of the children init knows about,
> it could confuse init.

No.  The wid is in the pspace of the parent, and the pid is in the processes
pspace.  Add is in any pspace are unique.

Eric
