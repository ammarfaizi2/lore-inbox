Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVI1Unp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVI1Unp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVI1Unp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:43:45 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:34012 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750801AbVI1Uno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:43:44 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17211.139.119978.52725@gargle.gargle.HOWL>
Date: Thu, 29 Sep 2005 00:43:55 +0400
To: Roland Dreier <rolandd@cisco.com>
Cc: dwalker@mvista.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: epca_lock to DEFINE_SPINLOCK
Newsgroups: gmane.linux.kernel
In-Reply-To: <52irwlmb1y.fsf@cisco.com>
References: <1127845928.4004.24.camel@dhcp153.mvista.com>
	<1127900349.2893.19.camel@laptopd505.fenrus.org>
	<52irwlmb1y.fsf@cisco.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier writes:
 >     Arjan> this is really ugly though; at minimum a DEFINE_STATIC_SPINLOCK()
 >     Arjan>  would be needed to make this less ugly.
 > 
 > huh?  This is a totally standard kernel idiom -- just do
 > 
 >     grep -Er 'static (DECLARE|DEFINE)' .
 > 
 > in a kernel tree to see how prevalent it is.

It may be widely used and still ugly. The general problem with
DEFINE_FOO() macros is that they obfuscate things: they do not _look_
like C variable declarations, and, in particular, type of variable is
not immediately obvious.

The only reasonable case where DEFINE_FOO(x) is really necessary is when
initializer uses address of x, but even in that case something like

        spinlock_t guard = SPINLOCK_UNLOCKED(guard);

is much more readable than

        DEFINE_SPIN_LOCK(guard);

The question is: does RT really have to force DEFINE_* as the only way
to define things?

 > 
 >  - R.

Nikita.
