Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTIYThh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbTIYThh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:37:37 -0400
Received: from pat.uio.no ([129.240.130.16]:45564 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261692AbTIYThf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:37:35 -0400
To: Steve Dickson <SteveD@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, nfs@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Re: [PATCH v2] reduce NFS stack usage
References: <mailman.1064420466.30286.linux-kernel2news@redhat.com>
	<3F7335B4.1070002@RedHat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 25 Sep 2003 12:37:25 -0700
In-Reply-To: <3F7335B4.1070002@RedHat.com>
Message-ID: <shsk77w3bii.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steve Dickson <SteveD@redhat.com> writes:

     > Also, not like there much choice in matter, but I wonder what
     > type of performance hit (if any) there will be by making these
     > routines call kmalloc()... lookups and readdirs are pretty
     > popular ops...

There are always alternatives...

If really this is a problem, how about slabifying the structs
nfs_fattr and/or nfs_fh?

Also, since nfs_entry is only large due to the fh and fattr fields
which are unused unless you have READDIRPLUS (in which case they are
converted to pointers anyhow), how about kicking them out of
nfs_entry altogether?

Cheers,
  Trond
