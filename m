Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTJJF1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 01:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJJF1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 01:27:05 -0400
Received: from pat.uio.no ([129.240.130.16]:57744 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262344AbTJJF1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 01:27:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16262.17185.757790.524584@charged.uio.no>
Date: Fri, 10 Oct 2003 01:26:57 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010044909.GB26379@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
	<3F85ED01.8020207@redhat.com>
	<20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk>
	<20031010044909.GB26379@mail.shareable.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:

     >     - are dnotify / lease / lock reliable indicators on this filesystem?
     >       (i.e. dnotify is reliable on all local filesystems, but
     >       not over any of the remote ones AFAIK).

Belongs in fcntl()... Just return ENOLCK if someone tries to set a
lease or a directory notification on an NFS file...

     >     - is stat() reliable (local filesystems and many remote) or
     >       potentially out of date without open/close (NFS due to
     >       attribute cacheing)

There are many possible cache consistency models out there. Consider
for instance AFS connected/disconnected modes, NFSv4 delegations or
CIFS shares. How are you going to distinguish between them all and
how do you propose that applications make use of this information?

Cheers,
  Trond
