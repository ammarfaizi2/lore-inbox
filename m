Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266851AbUHCVOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUHCVOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266855AbUHCVOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:14:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63669 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266854AbUHCVOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:14:02 -0400
Date: Tue, 3 Aug 2004 17:13:56 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040803210737.GI2241@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0408031712371.5948-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Andrea Arcangeli wrote:

> > -	if (shmflg & SHM_HUGETLB)
> > +	if (shmflg & SHM_HUGETLB) {
> > +		/* hugetlb_zero_setup takes care of mlock user accounting */
> >  		file = hugetlb_zero_setup(size);
> > +		shp->mlock_user = current->user;
> > +	} else {

> where do you change mlock_user in chown?

You don't.  Normal users aren't allowed to chown each
other's files, nor are they allowed to "give away" one
of their files to somebody else.

On unlock the quota gets deducted from the user who
created the hugetlbfs file.

This means there shouldn't be security issues with this
approach.  Let me know if I've overlooked one.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

