Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVHWLR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVHWLR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVHWLR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:17:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:24496 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932128AbVHWLR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:17:26 -0400
Date: Tue, 23 Aug 2005 13:16:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mlindner@syskonnect.de
Subject: Re: skge missing ifdefs.
In-Reply-To: <20050823060239.GC9322@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0508231259500.3743@scrub.home>
References: <20050801203442.GD2473@redhat.com> <20050801203818.GA7497@havoc.gtf.org>
 <20050822195913.GF27344@redhat.com> <20050822132333.2ff893e6.akpm@osdl.org>
 <20050822203522.GB9322@parcelfarce.linux.theplanet.co.uk>
 <20050822134218.55de5b82.akpm@osdl.org> <Pine.LNX.4.61.0508230015300.3743@scrub.home>
 <20050823060239.GC9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Aug 2005, Al Viro wrote:

> As for your s/thread_info/stack/ - I don't believe it's doable in mainline
> right now.  It's definitely separate from m68k merge and should not be
> mixed into it.  Moreover, mandatory changes to every platform arch-specific
> code over basically cosmetic issue (renaming a field of task_struct) at
> this point are going to be gratitious PITA for every architecture with
> out-of-tree development.  And m68k folks, of all people, should know what
> fun it is.

No, I don't know it. Sometimes merging can be tricky, but then I check the 
original diff and apply it manually. What I'm planning involves no logical 
changes, so it would be an absolute no-brainer to merge. It's the logical 
changes that may even compile normally, that can be the a real PITA.

> When folks start using task_thread_info() in arch/* (i.e. by 2.6.1[45]) the
> size of that delta will go down big way and it will be less painful.  Until
> then...  Not a good idea.

I already did the complete conversion (and I did it forward and backward 
to be sure the result is the same), so I dont see the problem to merge it 
in 2.6.13. The final removal of the thread_info field can happen in 2.6.14 
and any missed changes in external trees are trivially fixable.

bye, Roman
