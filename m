Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWBIV73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWBIV73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWBIV73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:59:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23983 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750782AbWBIV72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:59:28 -0500
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, frankeh@watson.ibm.com, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       "Dmitry Mishin" <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 09 Feb 2006 14:56:46 -0700
In-Reply-To: <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Wed, 08 Feb 2006 17:24:16 -0700")
Message-ID: <m13bis5h7l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok digesting this some more I don't see a glaring case in the code
where it is set_econtainer(...); do stuff ; restore_econtainer(..);
has a tremendous advantage at the moment.  Plus it removes the
opportunity to catch old code that deals with multiple contexts at
compile time, and has to be done by pain staking code review.

That aside the truly important thing I realized is that for
the optimization effects it is an implementation detail.  Batched
reference counting of shared resources is something we can
go back in and add at any time.  It will take a little refactoring
to do but it something that can be done without changing the
user space API.

So since individual namespace pointers in the task_struct
are simpler and have the required flexibility.  I think we
can table this part of the discussion for now.

The other detail I brought up which was most interesting was
the marking of specific variables that would go into a
container or namespace.  Well as long as it is implemented on
the namespace level that is still possible, and may even
be beneficial.

Eric
