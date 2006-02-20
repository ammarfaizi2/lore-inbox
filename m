Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWBTJ0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWBTJ0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWBTJZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:25:59 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:17321 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964808AbWBTJZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:25:58 -0500
Message-ID: <43F98933.2020703@sw.ru>
Date: Mon, 20 Feb 2006 12:17:39 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
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
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <43F3B820.8030907@vilain.net>
In-Reply-To: <43F3B820.8030907@vilain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> However, if we're going to get anywhere, the first decision which we
>> need to make is whether to go with a (container,pid), (pspace,pid) or
>> equivalent pair like approach, or a virtualized pid approach.  Linus had
>> previously said that he prefers the former.  Since there has been much
>> discussion since then, I thought I'd try to recap the pros and cons of
>> each approach, with the hope that the head Penguins will chime in one
>> more time, after which we can hopefully focus our efforts.
I think the first thing we have to do, is not to decide which pids we 
want to see, but what and how we want to virtualize.

> I am thinking that you can have both.  Not in the sense of
> overcomplicating, but in the sense of having your cake and eating it
> too.
BTW, really, why not both?
Eric, can we do something universal which will suite all the parties?

> The only thing which is a unique, system wide identifier for the process
> is the &task_struct.  So we are already virtualising this pointer into a
> PID for userland.  The only difference is that we cache it (nay, keep
> the authorative version of it) in the task_struct.
> 
> The (XID, PID) approach internally is also fine.  This says that there
> is a container XID, and within it, the PID refers to a particular
> task_struct.  A given task_struct will likely exist in more than one
> place in the (XID, PID) space.  Perhaps the values of PID for XID = 0
> and XID = task.xid can be cached in the task_struct, but that is a
> detail.
> 
> Depending on the flags on the XID, we can incorporate all the approaches
> being tabled.  You want virtualised pids?  Well, that'll hurt a little,
> but suit yourself - set a flag on your container and inside the
> container you get virtualised PIDs.  You want a flat view for all your
> vservers?  Fine, just use an XID without the virtualisation flag and
> with the "all seeing eye" property set.  Or you use an XID _with_ the
> virtualisation flag set, and then call a tuple-endowed API to find the
> information you're after.
This sounds good. But pspaces are also used for access controls. So this 
should be incorparated there as well.

Kirill


