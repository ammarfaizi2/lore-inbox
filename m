Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWIFSN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWIFSN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWIFSN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:13:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63892 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751479AbWIFSNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:13:25 -0400
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/5] dio: clean up completion phase of direct_io_worker()
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net>
	<x49hczl11ru.fsf@segfault.boston.devel.redhat.com>
	<44FEFB5A.7060905@oracle.com>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 06 Sep 2006 14:13:14 -0400
In-Reply-To: <44FEFB5A.7060905@oracle.com> (Zach Brown's message of "Wed, 06
 Sep 2006 09:46:18 -0700")
Message-ID: <x4964g0279h.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [RFC 0/5] dio: clean up completion phase of direct_io_worker(); Zach Brown <zach.brown@oracle.com> adds:

>> This all looks good, the code is much easier to follow.  What do you think
>> about making dio->result an unsigned quantity?  It should never be negative
>> now that there is an io_error field.

zach.brown> Yeah, that has always bugged me too.  I considered renaming it
zach.brown> 'issued', or something, as part of this patchset but thought we
zach.brown> could do it later.

I figured since you were doing some house-keeping, we might as well clean
up as much as possible.  It's up to you, though.  ;)

zach.brown> While we're on this topic, I'm nervious that we increment it
zach.brown> when do_direct_IO fails.  It might be sound, but that we
zach.brown> consider it the amount of work "transferred" for dio->end_io
zach.brown> makes me want to make sure there aren't confusing corner cases
zach.brown> here.

It does look non-obvious when reading the code.  However, I'm pretty sure
it's right.  dio->block_in_file is only updated if there is no error
returned from submit_page_section.  As such, it really does reflect how
much work was done before the error, right?  It does seem odd that we do
this math in two separate places, though.

-Jeff
