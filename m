Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWE3VGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWE3VGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWE3VGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:06:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10186 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932463AbWE3VGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:06:16 -0400
Date: Tue, 30 May 2006 23:06:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 38/61] lock validator: special locking: i_mutex
Message-ID: <20060530210625.GB28618@elte.hu>
References: <20060529212613.GL3155@elte.hu> <1149022401.21827.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149022401.21827.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 2006-05-29 at 23:26 +0200, Ingo Molnar wrote:
> > + * inode->i_mutex nesting types for the LOCKDEP validator:
> > + *
> > + * 0: the object of the current VFS operation
> > + * 1: parent
> > + * 2: child/target
> > + */
> > +enum inode_i_mutex_lock_type
> > +{
> > +       I_MUTEX_NORMAL,
> > +       I_MUTEX_PARENT,
> > +       I_MUTEX_CHILD
> > +};
> > +
> > +/* 
> 
> I guess we can say the same about I_MUTEX_NORMAL.

yeah. Subtypes start from 1, as 0 is the basic type.

Lock types are keyed via static kernel addresses. This means that we can 
use the lock address (for DEFINE_SPINLOCK) or the static key embedded in 
spin_lock_init() as a key in 99% of the cases. The key [struct 
lockdep_type_key, see include/linux/lockdep.h] occupies enough bytes (of 
kernel static virtual memory) so that the keys remain automatically 
unique. Right now MAX_LOKCDEP_SUBTYPES is 8, so the keys take at most 8 
bytes. (To save some memory there's another detail: for static locks 
(DEFINE_SPINLOCK ones) we use the lock address itself as the key.)

	Ingo
