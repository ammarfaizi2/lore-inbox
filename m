Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWG1Afl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWG1Afl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWG1Afl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:35:41 -0400
Received: from mail.suse.de ([195.135.220.2]:63623 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932071AbWG1Afk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:35:40 -0400
From: Neil Brown <neilb@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Date: Fri, 28 Jul 2006 10:34:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17609.23449.706093.915863@cse.unsw.edu.au>
Cc: Eric Sandeen <sandeen@sandeen.net>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, jack@suse.cz, 20@madingley.org,
       marcel@holtmann.org, linux-kernel@vger.kernel.org, sct@redhat.com,
       adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
In-Reply-To: message from Christoph Hellwig on Thursday July 27
References: <17599.2754.962927.627515@cse.unsw.edu.au>
	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>
	<17600.30372.397971.955987@cse.unsw.edu.au>
	<20060721170627.4cbea27d.akpm@osdl.org>
	<20060722131759.GC7321@thunk.org>
	<20060724185604.9181714c.akpm@osdl.org>
	<17605.32781.909741.310735@cse.unsw.edu.au>
	<44C7A272.8030401@sandeen.net>
	<17608.96.409298.126686@cse.unsw.edu.au>
	<44C906CB.8050100@sandeen.net>
	<20060727191247.GA29166@infradead.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 27, hch@infradead.org wrote:
> On Thu, Jul 27, 2006 at 01:32:43PM -0500, Eric Sandeen wrote:
> > Neil Brown wrote:
> > >I'll do it differently in a day or so.
> > 
> > Would moving export_iget into fs/inode.c & exporting it from there be a 
> > reasonable way to go?  At least ext2 & ext3 both have this need (prevent 
> > nfs access to special inodes) so putting the bulk of what they need for 
> > get_dentry (i.e. export_iget) somewhere common seems like a decent 
> > option to me.
> 
> Nope.  The right fix is to not make ext2/3 rely on export_iget at all. Please
> implement the proper export_operations instead, similar to e.g. xfs. 
> 
> export_iget is a horrible layering violation that needs to go away long-term,
> not move into core code.

Agreed.
I've just submitted revised patches.  They effectively open-code
export_iget in a local implemention of the get_dentry
export_operation.

This should give the problem with no unpleasant exports or layering
issues. 

NeilBrown
