Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWBFXBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWBFXBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWBFXBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:01:18 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:24729 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964856AbWBFXBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:01:17 -0500
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@openvz.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, clg@fr.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, riel@redhat.com, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <43E7C65F.3050609@openvz.org>
References: <43E7C65F.3050609@openvz.org>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 15:00:58 -0800
Message-Id: <1139266858.6189.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 00:57 +0300, Kirill Korotaev wrote:
> @@ -1132,6 +1133,7 @@ static task_t *copy_process(unsigned lon
>         p->ioprio = current->ioprio;
>  
>         SET_LINKS(p);
> +       (void)get_container(p->container);
>         if (unlikely(p->ptrace & PT_PTRACED))
>                 __ptrace_link(p, current->parent); 

This entire patch looks nice and very straightforward, except for this
bit. :)  The "(void)" bit isn't usual kernel coding style.  You can
probably kill it.

BTW, why does get_container() return the container argument?
get_task_struct(), for instance is just a do{}while(0) loop, so it
doesn't have a return value.  Is there some magic later on in your patch
set that utilizes this?

One other really minor thing: I usually try to do is keep the !
CONFIG_FOO functions static inlines, just like the full versions.  The
advantage is that you get some compile-time type checking, even when
your CONFIG option is off.

-- Dave

