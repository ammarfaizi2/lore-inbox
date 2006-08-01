Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWHAMK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWHAMK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 08:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWHAMK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 08:10:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14829 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751243AbWHAMK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 08:10:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Christoph Lameter <clameter@sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Hoffmann <kraxel@suse.de>, Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a function to a pte range
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org>
Date: Tue, 01 Aug 2006 06:08:43 -0600
In-Reply-To: <79a98a10911fc4e77dce.1154421372@ezr.goop.org> (Jeremy
	Fitzhardinge's message of "Tue, 01 Aug 2006 01:36:12 -0700")
Message-ID: <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@xensource.com> writes:

> 2 files changed, 99 insertions(+)
> include/linux/mm.h |    5 ++
> mm/memory.c        |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>
>
> Add a new mm function apply_to_page_range() which applies a given
> function to every pte in a given virtual address range in a given mm
> structure. This is a generic alternative to cut-and-pasting the Linux
> idiomatic pagetable walking code in every place that a sequence of
> PTEs must be accessed.
>
> Although this interface is intended to be useful in a wide range of
> situations, it is currently used specifically by several Xen
> subsystems, for example: to ensure that pagetables have been allocated
> for a virtual address range, and to construct batched special
> pagetable update requests to map I/O memory (in ioremap()).

- You don't handle huge pages.  For a generic function
  that sounds like a problem.
- I believe there is a reason the kernel doesn't already have
  a function like this.  I seem to recall there being efficiency
  and fast path arguments.
- Placing this code in mm/memory.c without a common consumer is
  pure kernel bloat for everyone who doesn't use this function,
  which is just about everyone.

Eric
