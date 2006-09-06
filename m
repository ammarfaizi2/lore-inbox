Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWIFO5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWIFO5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWIFO5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:57:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751228AbWIFO5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:57:17 -0400
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/5] dio: clean up completion phase of direct_io_worker()
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 06 Sep 2006 10:57:09 -0400
In-Reply-To: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net> (Zach
 Brown's message of "Tue,  5 Sep 2006 16:57:32 -0700 (PDT)")
Message-ID: <x49hczl11ru.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding [RFC 0/5] dio: clean up completion phase of direct_io_worker(); Zach Brown <zach.brown@oracle.com> adds:

zach.brown> There have been a lot of bugs recently due to the way
zach.brown> direct_io_worker() tries to decide how to finish direct IO
zach.brown> operations.  In the worst examples it has failed to call
zach.brown> aio_complete() at all (hang) or called it too many times
zach.brown> (oops).

zach.brown> This set of patches cleans up the completion phase with the
zach.brown> goal of removing the complexity that lead to these bugs.  We
zach.brown> end up with one path that calculates the result of the
zach.brown> operation after all off the bios have completed.  We decide
zach.brown> when to generate a result of the operation using that path
zach.brown> based on the final release of a refcount on the dio structure.

[...]

zach.brown> I hoped to get some feedback (and maybe volunteers for
zach.brown> testing!) by sending the patches out before waiting for the
zach.brown> stress tests.

This all looks good, the code is much easier to follow.  What do you think
about making dio->result an unsigned quantity?  It should never be negative
now that there is an io_error field.

ACK.

Jeff
