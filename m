Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWBKKq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWBKKq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 05:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWBKKq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 05:46:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32452 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751310AbWBKKq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 05:46:26 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 11 Feb 2006 03:43:42 -0700
In-Reply-To: <43ECF803.8080404@sw.ru> (Kirill Korotaev's message of "Fri, 10
 Feb 2006 23:30:59 +0300")
Message-ID: <m13biqxjj5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>> +
>> +static inline int pspace_task_visible(struct pspace *pspace, struct
> task_struct *tsk)
>> +{
>> +	return (tsk->pspace == pspace) ||
>> +		((tsk->pspace->child_reaper.pspace == pspace) &&
>> +		 (tsk->pspace->child_reaper.task == tsk));
> <<< the logic with child_reaper which can be somehow partly inside pspace... and
> this check is not that abvious.

This is the check for what shows up in /proc.

Given that is how I have explicitly documented things to work, (the
init process straddles the boundary) I fail to see how it is not obvious.  

Eric
