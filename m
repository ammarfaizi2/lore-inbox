Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbTDZRb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbTDZRb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 13:31:58 -0400
Received: from pat.uio.no ([129.240.130.16]:11137 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262624AbTDZRb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 13:31:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16042.50310.700613.569032@charged.uio.no>
Date: Sat, 26 Apr 2003 19:40:22 +0200
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 NFS file corruption
In-Reply-To: <Pine.LNX.4.44.0304261857450.18264-100000@pc40.e18.physik.tu-muenchen.de>
References: <shsadedrywz.fsf@charged.uio.no>
	<Pine.LNX.4.44.0304261857450.18264-100000@pc40.e18.physik.tu-muenchen.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de> writes:


    >> You are updating an executable while the clients are running
    >> it??? Bad! That is not meant to work...
    >>
     > It seems to work 50% of the time, while in the other cases
     > every page but the first ist correctly updated. Is there a
     > reason why this should be so?

Yes. There is not guarantee that the client isn't using a given page.
More importantly though, it just doesn't make sense to change an
executable dynamically. How would you make the transition from one
executable code to the other seamless?

     > Would it be okay to delete the file and recreate one with the
     > same name? This way it should get a new handle, right?

That won't stop your processes from crashing when you delete the file
from underneath them, but it is indeed the recommended way to handle
this sort of problem. This is the way programs such as 'install'
(a.k.a. ginstall) work.

Cheers,
  Trond
