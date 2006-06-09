Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWFIAky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWFIAky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWFIAky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:40:54 -0400
Received: from mx1.suse.de ([195.135.220.2]:53662 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751334AbWFIAkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:40:53 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Staubach <staubach@redhat.com>
Date: Fri, 9 Jun 2006 10:40:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17544.50037.863862.736802@cse.unsw.edu.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] NFS server does not update mtime on setattr
	request
In-Reply-To: message from Peter Staubach on Wednesday June 7
References: <4485C3FE.5070504@redhat.com>
	<1149658707.27298.10.camel@localhost>
	<4486E662.5080900@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday June 7, staubach@redhat.com wrote:
> 
> Neil, can we get these changes integrated, please?

Nope.
The discussion has already gone on from here, so I might be covering
old ground, but there seem to be further mentions of still needing the
server patch, so just to be sure it is covered....

My reading of SUS says that 
  open(O_TRUNC) of an empty file does not update the modify time
  truncate() of an empty file does update the modify time

So the server has to be able to support this distinction without being
able to directly know what API call was made on the client.
The patch you suggest makes it impossible to support that distinction.

Possibly the server could make a distinction between when nfsd_setattr
is called directly, and when it is called via nfsd_create{,_v3}.  I
would be more open to a patch that makes a distinction there.  However
I think that it would be best for the client to be explicit about what
it is doing by setting the right attr flags.

NeilBrown

