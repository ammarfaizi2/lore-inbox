Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUGSTVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUGSTVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUGSTVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 15:21:14 -0400
Received: from palrel13.hp.com ([156.153.255.238]:59333 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265467AbUGSTVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 15:21:09 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16636.7969.396569.877226@napali.hpl.hp.com>
Date: Mon, 19 Jul 2004 12:21:05 -0700
To: Andreas Schwab <schwab@suse.de>
Cc: davidm@hpl.hp.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: fix for unkillable zombie task
In-Reply-To: <jesmbr3pfl.fsf@sykes.suse.de>
References: <16632.21429.257483.650452@napali.hpl.hp.com>
	<jesmbr3pfl.fsf@sykes.suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 17 Jul 2004 12:20:46 +0200, Andreas Schwab <schwab@suse.de> said:

  Andreas> Could this be the same problem as discussed in the thread at
  Andreas> <http://marc.theaimsgroup.com/?t=108857537300002&r=1&w=2>?

It appears the "final" patch never made it into Linus' tree?

In any case, I'm certain the fix I submitted is needed, but I wouldn't
claim I understand all of the exit path handling---it's become rather
complicated with the NPTL-changes.  For example, one thing I don't
understand in forget_original_parent() is that it traverses the
father->children list and then does the check:

		if (father == p->real_parent) {

AFAIK, if "p" in on the father->children list, that implies that
(p->real_parent == father).  I suspect a typo here and
"p->real_parent" should read "p->parent", but I'm sure whoever wrote
this code must have tested it, so it's probably more likely I'm
missing something.

	--david
