Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVAXTf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVAXTf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVAXTda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:33:30 -0500
Received: from [83.102.214.158] ([83.102.214.158]:8423 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261592AbVAXT2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:28:24 -0500
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Ext2-devel] [PATCH] JBD: fix against journal overflow
References: <m3r7khv3id.fsf@bzzz.home.net>
	<1106588589.2103.116.camel@sisko.sctweedie.blueyonder.co.uk>
	<m3llaien2g.fsf@bzzz.home.net>
	<1106590709.2103.132.camel@sisko.sctweedie.blueyonder.co.uk>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Mon, 24 Jan 2005 22:27:06 +0300
In-Reply-To: <1106590709.2103.132.camel@sisko.sctweedie.blueyonder.co.uk> (Stephen
 C. Tweedie's message of "Mon, 24 Jan 2005 18:18:29 +0000")
Message-ID: <m38y6ieigl.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Stephen C Tweedie (SCT) writes:

 SCT> 	/*
 SCT> 	 * Be pessimistic here about the number of those free blocks which
 SCT> 	 * might be required for log descriptor control blocks.
 SCT> 	 */
 SCT> 	...
 SCT> 	left -= (left >> 3);

oops. i overlooked this line. so, the fix becomes minor improvement patch ;)
thanks!

do you think the following can be improved?

	/*
	 * @@@ AKPM: This seems rather over-defensive.  We're giving commit
	 * a _lot_ of headroom: 1/4 of the journal plus the size of
	 * the committing transaction.  Really, we only need to give it
	 * committing_transaction->t_outstanding_credits plus "enough" for
	 * the log control blocks.
	 * Also, this test is inconsitent with the matching one in
	 * journal_extend().
	 */
	if (__log_space_left(journal) < jbd_space_needed(journal)) {


