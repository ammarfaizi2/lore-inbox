Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWG1Nav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWG1Nav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWG1Nau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:30:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161089AbWG1Nau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:30:50 -0400
Date: Fri, 28 Jul 2006 14:30:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Staubach <staubach@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Eric Sandeen <sandeen@sandeen.net>,
       Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, jack@suse.cz, 20@madingley.org,
       marcel@holtmann.org, linux-kernel@vger.kernel.org, sct@redhat.com,
       adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
Message-ID: <20060728133013.GA32548@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Staubach <staubach@redhat.com>,
	Eric Sandeen <sandeen@sandeen.net>, Neil Brown <neilb@suse.de>,
	Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
	jack@suse.cz, 20@madingley.org, marcel@holtmann.org,
	linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
References: <17600.30372.397971.955987@cse.unsw.edu.au> <20060721170627.4cbea27d.akpm@osdl.org> <20060722131759.GC7321@thunk.org> <20060724185604.9181714c.akpm@osdl.org> <17605.32781.909741.310735@cse.unsw.edu.au> <44C7A272.8030401@sandeen.net> <17608.96.409298.126686@cse.unsw.edu.au> <44C906CB.8050100@sandeen.net> <20060727191247.GA29166@infradead.org> <44CA10A5.3030209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CA10A5.3030209@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 09:27:01AM -0400, Peter Staubach wrote:
> Since export_iget() doesn't actually involve any code which has anything to
> do with the NFS server exports data structures, what exactly is the 
> objection?
> Is it truly better to duplicate code than to use a common routine which
> can be documented?

export_iget calls iget() which assumes a lot about how a filesystem works.
Generally no one should call iget outside of filesystem code (export_iget
is the only such occurance) and should be replaced by opencoding iget_locked
& co on filesystems where it helps or a simple_iget that takes a callback
similar to the current read_inode method.  By moving export_iget to core
code you encourage people to use it, and that's the last thing we want.

Btw, you folks might want to ping Al Viro, he had patches to fix various
nfsd vs icache issues a while ago.

> 
>    Thanx...
> 
>       ps
---end quoted text---
