Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbVCDXYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbVCDXYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbVCDXXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:23:24 -0500
Received: from pat2.uio.no ([129.240.130.19]:34748 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263230AbVCDVQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:16:03 -0500
Subject: Re: Linux 2.6.11.1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050304124431.676fd7cf.akpm@osdl.org>
References: <20050304175302.GA29289@kroah.com>
	 <20050304124431.676fd7cf.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 13:15:50 -0800
Message-Id: <1109970950.10173.71.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.498, required 12,
	autolearn=disabled, AWL 1.50, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 04.03.2005 Klokka 12:44 (-0800) skreiv Andrew Morton:

> nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
> nfsd--exportfs-reduce-stack-usage.patch
> nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
> nfsd--svcrpc-rename-pg_authenticate.patch
> nfsd--svcrpc-move-export-table-checks-to-a-per-program-pg_add_client-method.patch
> nfsd--nfs4-use-new-pg_set_client-method-to-simplify-nfs4-callback-authentication.patch
> nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
> audit-mips-fix.patch
> make-st-seekable-again.patch
> 
> wrt the nfsd patches, Neil said:
> 
> The problem they fix is that currently:
>     Client A holds a lock
>     Client B tries to get the lock and blocks
>     Client A drops the lock
>   **Client B doesn't get the lock immediately, but has to wait for a
>            timeout. (several seconds)

Well, yes, but more importantly, they should also fix a problem with
reboot recovery on the client side.

Currently, if rpc.statd sends an RPC call down to lockd in order to
notify it of a reboot of the server, the sunrpc server code will try to
authenticate that RPC call by doing an upcall to rpc.mountd.... Doh!

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

