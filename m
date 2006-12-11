Return-Path: <linux-kernel-owner+w=401wt.eu-S936961AbWLKQHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936961AbWLKQHo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936945AbWLKQHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:07:44 -0500
Received: from fogou.chygwyn.com ([195.171.2.24]:48488 "EHLO fogou.chygwyn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936960AbWLKQHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:07:42 -0500
Subject: Re: Status of buffered write path (deadlock fixes)
From: Steven Whitehouse <steve@chygwyn.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
In-Reply-To: <457D7EBA.7070005@yahoo.com.au>
References: <45751712.80301@yahoo.com.au>
	 <20061207195518.GG4497@ca-server1.us.oracle.com>
	 <4578DBCA.30604@yahoo.com.au>
	 <20061208234852.GI4497@ca-server1.us.oracle.com>
	 <457D20AE.6040107@yahoo.com.au>  <457D7EBA.7070005@yahoo.com.au>
Content-Type: text/plain
Organization: ChyGwyn Limited
Date: Mon, 11 Dec 2006 16:12:32 +0000
Message-Id: <1165853552.3752.1015.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "fogou.chygwyn.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Tue, 2006-12-12 at 02:52 +1100, Nick Piggin
	wrote: > Nick Piggin wrote: > > Mark Fasheh wrote: > > >>
	->commit_write() would probably do fine. Currently,
	block_prepare_write() > >> uses it to know which buffers were newly
	allocated (the file system > >> specific > >> get_block_t sets the bit
	after allocation). I think we could safely move > >> the clearing of
	that bit to block_commit_write(), thus still allowing > >> us to > >>
	detect and zero those blocks in generic_file_buffered_write() > > > > >
	> OK, great, I'll make a few patches and see how they look. What did you
	> > think of those other uninitialised buffer problems in my first
	email? > > Hmm, doesn't look like we can do this either because at least
	GFS2 > uses BH_New for its own special things. > What makes you say
	that? As far as I know we are not doing anything we shouldn't with this
	flag, and if we are, then I'm quite happy to consider fixing it up so
	that we don't, [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-12-12 at 02:52 +1100, Nick Piggin wrote:
> Nick Piggin wrote:
> > Mark Fasheh wrote:
> 
> >> ->commit_write() would probably do fine. Currently, block_prepare_write()
> >> uses it to know which buffers were newly allocated (the file system 
> >> specific
> >> get_block_t sets the bit after allocation). I think we could safely move
> >> the clearing of that bit to block_commit_write(), thus still allowing 
> >> us to
> >> detect and zero those blocks in generic_file_buffered_write()
> > 
> > 
> > OK, great, I'll make a few patches and see how they look. What did you
> > think of those other uninitialised buffer problems in my first email?
> 
> Hmm, doesn't look like we can do this either because at least GFS2
> uses BH_New for its own special things.
> 
What makes you say that? As far as I know we are not doing anything we
shouldn't with this flag, and if we are, then I'm quite happy to
consider fixing it up so that we don't,

Steve.


