Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUG3Cqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUG3Cqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUG3Cqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:46:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267513AbUG3Cq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:46:27 -0400
Date: Thu, 29 Jul 2004 22:46:15 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp030.home.surriel.com
To: Chris Wright <chrisw@osdl.org>
cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, andrea@suse.de
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040729185215.Q1973@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0407292243330.9228@dhcp030.home.surriel.com>
References: <20040729100307.GA23571@devserv.devel.redhat.com>
 <20040729185215.Q1973@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Chris Wright wrote:

> 2) mlock_user isn't ever set, so SHM_LOCK accounting looks broken
> (trivial to fix).

Woops, looks like Arjan's patch is missed a little piece of
the code there when going throug the forward port...

> 3) now the RLIMIT_MEMLOCK value represents at best half of what a user
> can acutally lock.  because half of the accounting (mlock) is done against
> locked_vm, and the other half against locked_shm.  and as i mentioned
> above, seems that hugetlb is unaccounted for.

Well, the RLIMIT_MEMLOCK is a per-process limit anyway so the
total amount of memory a user can mlock isn't really limited
by it.  The user_struct itself just gets the same limit as each
of the user's processes, to account for memory that doesn't
have the same life time as processes.

> I do agree, however, that storing in user struct allows for quota like
> accounting that matches the shm_lock and hugetlb use cases.

Ok, cool ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
