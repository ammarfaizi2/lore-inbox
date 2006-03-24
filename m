Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWCXSwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWCXSwL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWCXSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:52:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62950 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932591AbWCXSwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:52:10 -0500
Date: Fri, 24 Mar 2006 10:48:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com, tytso@mit.edu,
       zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time
 through fs-wide dirty bit]
Message-Id: <20060324104818.0016c2f2.akpm@osdl.org>
In-Reply-To: <20060324143239.GB14508@goober>
References: <20060322011034.GP12571@goober>
	<1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
	<20060322224844.GU12571@goober>
	<20060322175503.3b678ab5.akpm@osdl.org>
	<20060324143239.GB14508@goober>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valerie Henson <val_henson@linux.intel.com> wrote:
>
> On Wed, Mar 22, 2006 at 05:55:03PM -0800, Andrew Morton wrote:
> > Valerie Henson <val_henson@linux.intel.com> wrote:
> > > 
> > > ext2 is simpler and faster than ext3 in many cases.  This is sort of
> > > cheating; ext2 is simpler and faster because it makes no effort to
> > > maintain on-disk consistency and can skip annoying things like, oh,
> > > reserving space in the journal.  I am looking for ways to make ext2
> > > cheat even more.
> > > 
> > 
> > But it might be feasible to knock up an ext3-- in which all the journal
> > operations are stubbed out.
> 
> Hmm... Could we get the mark_buffer_dirty/mark_inode_dirty logic
> right?

All things are possible ;) One might add a new
ext3_minus_minus_mark_buffer_dirty(), for example, put that in all the
right places.

>  Probably create a list in the stubbed journal functions and
> then mark them dirty in the journal close?  However, half the reason
> I'm working on ext2 is the simplicity of the code - stubbing it out
> would solve the performance problem but not the complexity problem.

Well ext3-- won't do anything to simplify the ext3 codebase.  It was just a
thought..

> Note that ext3's habit of clearing indirect blocks on truncate would
> break some things I want to do in the future. (Insert secret plans
> here.)

Ah.  I guess one would need to port the ext2 truncate code.
