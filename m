Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSCSSLE>; Tue, 19 Mar 2002 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSCSSKz>; Tue, 19 Mar 2002 13:10:55 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:504 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S288019AbSCSSKh>; Tue, 19 Mar 2002 13:10:37 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 19 Mar 2002 07:15:54 -0700
To: Peter Hartley <pdh@utter.chaos.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
Message-ID: <20020319141554.GL470@turbolinux.com>
Mail-Followup-To: Peter Hartley <pdh@utter.chaos.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <006701c1cf6d$d9701230$2701230a@electronic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 19, 2002  17:45 -0000, Peter Hartley wrote:
> In particular, this means that an e2fsck 1.27 built against such a glibc
> will fail with SIGXFS every time on any block device bigger than 2Gbytes.
> This is because:
> 
>  * e2fsck calls setrlimit(RLIMIT_FSIZE, RLIM_INFINITY) in
>    an attempt to unset the limit. RLIM_INFINITY here is
>    0xFFFFFFFF. This is IMO the Right Thing.

It is only the right thing if the original limit was not 0xFFFFFFFF.
Otherwise, it is just adding to the problem, because the problem only
happens when you try to SET the limit.

> Surely the only Right Things to do in the kernel are (a) invent a new
> setrlimit call that corrects the RLIM_INFINITY value, or (b) have the
> current setrlimit call correct the RLIM_INFINITY value unconditionally.

(c) rlimit should not apply to block devices.

There were patches for this floating around, and I thought they made it
into 2.4.18, but they did not.

I do agree that we should also fix "setrlimit" to do the 0x7FFFFFFF to
0xFFFFFFFF correction.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

