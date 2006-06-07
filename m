Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWFGPnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWFGPnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWFGPnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:43:13 -0400
Received: from mail.fieldses.org ([66.93.2.214]:14262 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932266AbWFGPnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:43:12 -0400
Date: Wed, 7 Jun 2006 11:42:58 -0400
To: Peter Staubach <staubach@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Neil Brown <neilb@suse.de>,
       NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] NFS server does not update mtime on setattr request
Message-ID: <20060607154258.GA22335@fieldses.org>
References: <4485C3FE.5070504@redhat.com> <1149658707.27298.10.camel@localhost> <4486E662.5080900@redhat.com> <20060607151754.GB23954@fieldses.org> <4486F020.3030707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4486F020.3030707@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 11:26:24AM -0400, Peter Staubach wrote:
> J. Bruce Fields wrote:
> >What's the basis for that interpretation?  The language seems extremely
> >clear:
> >
> >	"On successful completion, if the file size is changed, these
> >	functions will mark for update the st_ctime and st_mtime fields
> >	of the file, and if the file is a regular file, the S_ISUID and
> >	S_ISGID bits of the file mode may be cleared."
> >
> >Why are you concerned about this?  Do you have an actual application
> >that breaks?
> 
> Yes, there is a customer who is quite unhappy that the semantics over Linux
> client NFS are different than those of BSD, Solaris, and local file system
> access on Linux itself.  The basis for my work is based on a bugzilla from
> this customer.

OK; just out of curiosity, what's the url/bug number/whatever?

> My interpretation is based on looking at the local behavior on Linux, which
> changes mtime/ctime even if the file size does not change, and SunOS, which
> changes mtime/ctime even if the file size does not change and is very
> heavily SUSv3 compliant.

Fair enough.

> In this case, "changed" does not mean "made different".  It simply means
> that the file size is set to the new value.

That's ridiculous, though; that's just not what "changed" means, and
that renders the "if" clause redundant.  Better just to say "SUS is
wrong, and this is what everybody actually does...."

--b.
