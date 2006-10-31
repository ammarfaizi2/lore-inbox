Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423441AbWJaQZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423441AbWJaQZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423543AbWJaQZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:25:19 -0500
Received: from cantor2.suse.de ([195.135.220.15]:50577 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423441AbWJaQZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:25:18 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Linux
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] NFS: nfsaclsvc_encode_getaclres() - Fix potential NULL deref and tiny optimization.
Date: Tue, 31 Oct 2006 17:26:00 +0100
User-Agent: KMail/1.9.5
Cc: David Rientjes <rientjes@cs.washington.edu>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
References: <200610272316.47089.jesper.juhl@gmail.com> <Pine.LNX.4.64N.0610271443500.31179@attu2.cs.washington.edu> <200610280001.49272.jesper.juhl@gmail.com>
In-Reply-To: <200610280001.49272.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311726.00411.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 00:01, Jesper Juhl wrote:
> > > 3) There are two locations in the function where we may return before
> > > we use the value of the variable 'w', but we compute it at the very top
> > > of the function. So in the case where we return early we have wasted a
> > > few cycles computing a value that was never used.

Computing w later in the function is fine.

> > w should be an unsigned int.
>
> Makes sense.

No, this breaks the while loop further below: with an unsigned int, the loop 
counter underflows and wraps.

Please fix this identically in fs/nfsd/nfs2acl.c and fs/nfsd/nfs3acl.c.

Thanks,
Andreas
