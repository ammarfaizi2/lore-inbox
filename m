Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTFKRYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTFKRYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:24:33 -0400
Received: from pat.uio.no ([129.240.130.16]:17122 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263319AbTFKRYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:24:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16103.26865.361044.360120@charged.uio.no>
Date: Wed, 11 Jun 2003 19:37:53 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode
	number mismatch)
In-Reply-To: <1055352127.2419.25.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com>
	<1055352127.2419.25.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > I've seen it on early 2.5 and on 2.4, current 2.5.x seems to be
     > ok from a quick test.

2.4 has the 'return ESTALE if current dir fails d_revalidate()'
test. Looks like the vfat stuff has the same problem that 

Sigh... Can we perhaps add FS_ALWAYS_REVAL in order to flag what kind
of behaviour filesystems expect in link_path_walk()? NFS needs
revalidation on all open() calls (including opendir(".")), so removing
the ESTALE code is not an option.

Cheers,
  Trond
