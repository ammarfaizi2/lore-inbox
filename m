Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVIMUzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVIMUzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVIMUzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:55:24 -0400
Received: from postage-due.permabit.com ([66.228.95.230]:52122 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932505AbVIMUzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:55:21 -0400
To: Peter Staubach <staubach@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
	<784q8qrsad.fsf@sober-counsel.permabit.com>
	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
	<788xy2qas0.fsf@sober-counsel.permabit.com>
	<20050913183948.GE14889@dmt.cnet>
	<784q8okdfn.fsf@sober-counsel.permabit.com>
	<4327386B.5050201@redhat.com>
From: Assar <assar@permabit.com>
Date: 13 Sep 2005 16:55:07 -0400
In-Reply-To: <4327386B.5050201@redhat.com>
Message-ID: <78zmqghems.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach <staubach@redhat.com> writes:
> NFS uses XDR to encode C strings.  They are encoded as counted byte arrays
> and are _not_ null terminated.  The space containing the string is rounded
> up to the next 4 byte boundary though and, usually, this space is zero
> filled.
> The number of bytes in the string is encoded as a big endian integer in the
> first four bytes.

Yes, but fs/nfs/nfs2xdr.c:nfs_xdr_readlinkres on 2.4.31 writes a 0 at
the end of string after having received it, which is what started this
thread.  Look at the end of nfs_xdr_readlinkres.
