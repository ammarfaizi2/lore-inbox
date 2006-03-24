Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWCXOdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWCXOdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWCXOdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:33:21 -0500
Received: from fmr19.intel.com ([134.134.136.18]:30130 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751048AbWCXOdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:33:21 -0500
Date: Fri, 24 Mar 2006 06:32:39 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com, tytso@mit.edu,
       zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324143239.GB14508@goober>
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322175503.3b678ab5.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 05:55:03PM -0800, Andrew Morton wrote:
> Valerie Henson <val_henson@linux.intel.com> wrote:
> > 
> > ext2 is simpler and faster than ext3 in many cases.  This is sort of
> > cheating; ext2 is simpler and faster because it makes no effort to
> > maintain on-disk consistency and can skip annoying things like, oh,
> > reserving space in the journal.  I am looking for ways to make ext2
> > cheat even more.
> > 
> 
> But it might be feasible to knock up an ext3-- in which all the journal
> operations are stubbed out.

Hmm... Could we get the mark_buffer_dirty/mark_inode_dirty logic
right?  Probably create a list in the stubbed journal functions and
then mark them dirty in the journal close?  However, half the reason
I'm working on ext2 is the simplicity of the code - stubbing it out
would solve the performance problem but not the complexity problem.

Note that ext3's habit of clearing indirect blocks on truncate would
break some things I want to do in the future. (Insert secret plans
here.)

-VAL
