Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTEOBVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTEOBVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:21:54 -0400
Received: from pat.uio.no ([129.240.130.16]:30698 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263567AbTEOBVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:21:52 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
References: <Pine.LNX.4.44.0305141749490.28007-100000@home.transmeta.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 15 May 2003 03:34:25 +0200
In-Reply-To: <Pine.LNX.4.44.0305141749490.28007-100000@home.transmeta.com>
Message-ID: <shshe7xt2la.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > I'm interested in a much more generic issue of "user
     > credentials", and here a PAG can be _one_ credential that a
     > user holds on to. But to be useful, a user has to be able to
     > have multiple such credentials. While one might be his "AFS
     > userid", another will be his NFS mount credentials, and a third
     > one will be his key to decrypt his home directory on that
     > machine.

The interesting thing about a PAG is that it is a handle that is
shared between userland and the kernel, and carries information about
which collection of authentication tokens/credentials a process holds.

RPCSEC can be made to use it to communicate which bag of creds the
userland daemon may use when it attempts to negotiate a new security
context for an NFS user. At the moment all we can tell is 'use the
credentials of uid=zyx' which is no good if the user wants 2
subprocesses to authenticate using different remote kerberos accounts,
say.

Cheers,
  Trond
