Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWJ0XDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWJ0XDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWJ0XDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:03:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15750 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750970AbWJ0XDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:03:34 -0400
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: lock refcount operations
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <20061027181735.18631.43565.sendpatchset@tetsuo.zabbo.net>
	<x49fyd9v9sy.fsf@segfault.boston.devel.redhat.com>
	<45426D3F.3040304@oracle.com>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Fri, 27 Oct 2006 19:03:22 -0400
In-Reply-To: <45426D3F.3040304@oracle.com> (Zach Brown's message of "Fri, 27 Oct 2006 13:34:07 -0700")
Message-ID: <x49odrxnyyt.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [PATCH] dio: lock refcount operations; Zach Brown <zach.brown@oracle.com> adds:

>> I don't believe that this can happen.

zach.brown> Yeah, I think my brain made the leap to spurious wake-ups from
zach.brown> hashed wait queues.  Which aren't being used :).  As long as
zach.brown> it's a private wait queue and sleeps and sleeps with
zach.brown> UNINTERRUPTIBLE it seems ok.

zach.brown> Do you think the cleanup shouldn't be done?  It seems easier to
zach.brown> understand after the patch, and makes dio_await_one() pretty
zach.brown> darn straight forward.

The patch looks sane to me, and I appreciate all of your comments in the
code.

zach.brown> The addition of the interrupt masking spin lock acquiry in
zach.brown> dio_bio_submit() looks alarming.  This lock acquiry existed in
zach.brown> that path before the recent dio completion patch set.  We
zach.brown> shouldn't expect significant performance regression from
zach.brown> returning to the behaviour that existed before the completion
zach.brown> clean up work. 

Are you going to quantify this at all?  I think we should.

-Jeff
