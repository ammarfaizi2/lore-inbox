Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVAXRtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVAXRtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVAXRtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:49:15 -0500
Received: from [83.102.214.158] ([83.102.214.158]:63970 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261547AbVAXRs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:48:56 -0500
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Ext2-devel] [PATCH] JBD: fix against journal overflow
References: <m3r7khv3id.fsf@bzzz.home.net>
	<1106588589.2103.116.camel@sisko.sctweedie.blueyonder.co.uk>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Mon, 24 Jan 2005 20:47:35 +0300
In-Reply-To: <1106588589.2103.116.camel@sisko.sctweedie.blueyonder.co.uk> (Stephen
 C. Tweedie's message of "Mon, 24 Jan 2005 17:43:09 +0000")
Message-ID: <m3llaien2g.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Stephen C Tweedie (SCT) writes:
 SCT> I don't see how that "limit" is relevant here.  wbuf is nothing but the
 SCT> size of the IO batches we pass to ll_rw_block() during that commit
 SCT> phase.  j_free affects the total size of space the *entire* commit has
 SCT> to run into, and (as akpm has commented with a big marker beside it)
 SCT> start_this_handle() reserves a *lot* of headroom for the extra space
 SCT> that may be needed for transaction metadata.



		/* If there's no more to do, or if the descriptor is full,
		   let the IO rip! */

		if (bufs == ARRAY_SIZE(wbuf) ||
		    commit_transaction->t_buffers == NULL ||
		    space_left < sizeof(journal_block_tag_t) + 16) {

                        ....

			/* Force a new descriptor to be generated next
                           time round the loop. */
			descriptor = NULL;
			bufs = 0;

------------------------^^^^^^^^^^^^^^^^^^^


 SCT> Have you really seen this patch make a difference in testing?

of course


