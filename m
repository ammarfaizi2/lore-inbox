Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVBOSE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVBOSE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVBOSE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:04:59 -0500
Received: from pat.uio.no ([129.240.130.16]:6136 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261784AbVBOSEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:04:55 -0500
Subject: Re: [patch 12/13] ACL umask handling workaround in nfs client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050122203620.108564000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203620.108564000@blunzn.suse.de>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 13:04:42 -0500
Message-Id: <1108490682.10073.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.86, required 12,
	autolearn=disabled, AWL 2.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> vanlig tekstdokument vedlegg (patches.suse)
> NFSv3 has no concept of a umask on the server side: The client applies
> the umask locally, and sends the effective permissions to the server.
> This behavior is wrong when files are created in a directory that has
> a default ACL. In this case, the umask is supposed to be ignored, and
> only the default ACL determines the file's effective permissions.
> 
> Usually its the server's task to conditionally apply the umask. But
> since the server knows nothing about the umask, we have to do it on the
> client side. This patch tries to fetch the parent directory's default
> ACL before creating a new file, computes the appropriate create mode to
> send to the server, and finally sets the new file's access and default
> acl appropriately.


Firstly, this sort of code belongs in the NFSv3-specific code. POSIX
acls have no business whatsoever in the generic NFS code.

Secondly, what is the point of doing all this *after* you have created
the file with the wrong permissions? How are you avoiding races?

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

