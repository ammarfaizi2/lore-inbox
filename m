Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTE0RQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTE0RQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:16:33 -0400
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:62086 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263962AbTE0RQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:16:27 -0400
From: jlnance@unity.ncsu.edu
Date: Tue, 27 May 2003 13:29:38 -0400
To: linux-kernel@vger.kernel.org
Cc: SteveD@redhat.com, Charles.Lever@netapp.com
Subject: Re: NFS problems with Linux-2.4
Message-ID: <20030527172938.GA26434@ncsu.edu>
References: <482A3FA0050D21419C269D13989C6113127532@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482A3FA0050D21419C269D13989C6113127532@lavender-fe.eng.netapp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I wanted to follow up this thread now that I have a working solution.

My initial problem was that machine A would create a file and machine B
would attempt to stat() or open() it over NFS and it would not be there.
I was using the 2.4.7 kernel that came with Red Hat 7.2.

Trond suggested I try a more recent kernel since 2.4.7 had known close
to open cache consistency problems.  I tried the 2.4.20 kernel and it
did make the problem better, but it was still there.

Someone suggested doing an opendir() to flush the NFS cache.  This did
make the problem go away with the 2.4.20 kernels.  With the 2.4.7
kenrels, I started getting ESTALE errors after I did this.  I found
that I could work around these errors by doing something like:

    f = fopen(filename, mode);

    if(!f) {
      if(errno==ESTALE) {
	sleep(1);
	f = fopen(filename,  mode);
      }
    }

which is ugly, but it allow me to run on unpatched Red Hat 7.2 systems
which is highly desirable.

Thanks,

Jim
