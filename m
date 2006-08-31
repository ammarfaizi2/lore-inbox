Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWHaQnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWHaQnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWHaQnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:43:24 -0400
Received: from pat.uio.no ([129.240.10.4]:43449 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932195AbWHaQnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:43:24 -0400
Subject: Re: bug in nfs in 2.6.18-rc5?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       unionfs@fsl.cs.sunysb.edu
In-Reply-To: <44F70D22.2030703@cs.columbia.edu>
References: <44F6F80F.1000202@cs.columbia.edu>
	 <1157040230.11347.31.camel@localhost>  <44F70D22.2030703@cs.columbia.edu>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 12:43:12 -0400
Message-Id: <1157042592.11347.70.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.188, required 12,
	autolearn=disabled, AWL 1.81, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 12:24 -0400, Shaya Potter wrote:
> why does the client care about server mounted file systems?

It wants to allow POSIX applications to work correctly even in the case
where the nfsd administrator is using 'nohide'. It wants those same
applications to work correctly in the case where the nfsd administrator
is exporting more than one filesystem over NFSv4.

>   The 
> server's nfsd has to tell them apart, otherwise shouldn't give them to 
> the client.  Otherwise it seems like the nfsd and the nfs client have to 
> have innate knowledge of each other.

Of course the server knows that it is crossing a mountpoint. The client
figures it out by looking at the 'fsid' attribute (which uniquely labels
the filesystem on that server) in order to figure out which filesystem
that the file/directory it just looked up belongs to. Whenever the
fileid changes between parent directory and child, that means that a
mountpoint was crossed on the server.

  Trond

