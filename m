Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269743AbUJMOdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269743AbUJMOdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269742AbUJMOdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:33:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40111 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269731AbUJMOaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:30:16 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16749.15265.475571.767534@segfault.boston.redhat.com>
Date: Wed, 13 Oct 2004 10:28:49 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, sct@redhat.com
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
In-Reply-To: <20041003194831.GB3089@openzaurus.ucw.cz>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	<20041003194831.GB3089@openzaurus.ucw.cz>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch rfc] towards supporting O_NONBLOCK on regular files; Pavel Machek <pavel@ucw.cz> adds:

pavel> Hi!
>> This patch makes an attempt at supporting the O_NONBLOCK flag for
>> regular files.  It's pretty straight-forward.  One limitation is that we
>> still call into the readahead code, which I believe can block.  However,
>> if we don't do this, then an application which only uses non-blocking
>> reads may never get it's data.

pavel> This looks very nice. Does it mean that aio and friends are
pavel> instantly obsolete?

I dont' think so.  This only addresses the read() path, for one.  Plus, in
it's current form, it will not perform any I/O if the data is not present.
So, you will need another thread/process to do kick off the I/O.

pavel> Does it have comparable performance to aio?

I haven't run any tests.  One advantage this has to current aio is that it
can operate without O_DIRECT.

-Jeff
