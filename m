Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269825AbRHDSSY>; Sat, 4 Aug 2001 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269848AbRHDSSO>; Sat, 4 Aug 2001 14:18:14 -0400
Received: from weta.f00f.org ([203.167.249.89]:20112 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269825AbRHDSSJ>;
	Sat, 4 Aug 2001 14:18:09 -0400
Date: Sun, 5 Aug 2001 06:18:59 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010805061859.A20111@weta.f00f.org>
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <20010804133500.F22090@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010804133500.F22090@cs.cmu.edu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc' list trimmed)

On Sat, Aug 04, 2001 at 01:35:00PM -0400, Jan Harkes wrote:

    Deadly for Coda, every fsync triggers an upcall to userspace,
    which costs at least 2 context switches and a whole bunch of
    network traffic as updates are sent back to the server, i.e. the
    fact that some parent has a new child or timestamp is not related
    to or interesting for this delivery.

would limiting it to just the parent dentry be acceptable?

    - fsync(dir) is an _explicit_ indication by an application that
      actually cares what precisely needs to be written to disk.

i though nothing used it (maybe qmail?)

    - fsync(dir) doesn't negatively affect applications that don't care.

fsync(dir) or fsync(file)?

    - The proposed patch doesn't solve the 'oops I relinked the file,
      or I renamed a parent' problems where the path leading to a file
      is lost anyways.

      And the relinking is exactly what is done by both qmail and
      cyrus imap, i.e. this patch wouldn't even solve the problem that
      is being discussed.

cryrus/qmail do link("tmp_place", "store/where_i_want_it") ?

do they also do fsync(open("store")) ?




  --cw
