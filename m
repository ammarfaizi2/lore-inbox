Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTDZQg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTDZQg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:36:28 -0400
Received: from pat.uio.no ([129.240.130.16]:63211 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261892AbTDZQgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:36:20 -0400
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 NFS file corruption
References: <Pine.LNX.4.44.0304261742200.18264-100000@pc40.e18.physik.tu-muenchen.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 26 Apr 2003 18:44:44 +0200
In-Reply-To: <Pine.LNX.4.44.0304261742200.18264-100000@pc40.e18.physik.tu-muenchen.de>
Message-ID: <shsadedrywz.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de> writes:

     > Dear experts!  I'm seeing very strange file corruption, with
     > parts of the data (most of the bytes, actually) being correct,
     > but some being 0x00 and others (few) being something else. The
     > strangest thing however is that this affected exactly the
     > complete first 4kB page of the file.

     > The server and clients run CERN RedHat 7.3.2, which is based on
     > RedHat 7.3 and has a 2.4.18 kernel with patches upto the
     > 2.4.21-pre5 range. If you need the list of patches I can look
     > it up and will happily supply it.

AFAICS, the CERN 2.4.18-27.7.x doesn't appear to have any NFS patches
in it beyond the standard 2.4.18 + the IRIX patch (i.e. it is
identical to the RedHat kernel as far as NFS is concerned).

As such it is missing a good deal of NFS client bugfixes, including
the close-to-open patches which are important when you are updating
files centrally on a server.

It probably isn't the cause of problems here though (if I read the
section below correctly).

     > 1) copy the file onto the server's exported directory
     > 2) create a symlink to it from the same directory
     > 3) execute the file
     > 4) process crashes, gets restated (repeatedly, because of
     >    corruption)
     > 5) machine is rebooted, everything works fine for several hours
     > 6) restart at 4)

     > While in this circle, the file was overwritten several times
     > with updated versions.

You are updating an executable while the clients are running it??? 
Bad! That is not meant to work...

Cheers,
  Trond
