Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273235AbRIJIYb>; Mon, 10 Sep 2001 04:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273219AbRIJIYU>; Mon, 10 Sep 2001 04:24:20 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:22547 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273026AbRIJIYD>; Mon, 10 Sep 2001 04:24:03 -0400
Date: 10 Sep 2001 10:30:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <88a0nPmXw-B@khms.westfalen.de>
In-Reply-To: <20010909173947.A20202@netnation.com>
Subject: Re: linux-2.4.10-pre5
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010909173947.A20202@netnation.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sim@netnation.com (Simon Kirby)  wrote on 09.09.01 in <20010909173947.A20202@netnation.com>:

> What do people actually use atime for, anyway?  I've always
> noatime/nodiratime'd most servers I've set up because it saves so much
> disk I/O, and I have yet to see anything really use it.  I can see that
> in some cases it would be useful to turn it _on_ (perhaps for debugging /
> removal of unused files, etc.), but it seems silly that the default case
> is a situation which on the surface seems dumb (opening a file for read
> causes a disk write).

I see two possible atime uses:

1. Cleaning up /tmp (mtime is *not* a good indicator that a file is no  
longer used)
2. Swapping out files to slower storage

Essentially, both use the "do we still need this thing" aspect.

Of course, for this to be useful, we really need programs to be able to  
say "ignore my use of this file". tar --atime-preserve, for example  
(which, incidentally, notes a technical problem with doing this). I'd also  
add stuff like files or md5sum or similar diagnostic tools to the "might  
want to not affect atime" list, and possibly also stuff like inn ("atime  
on /var/spool/news is just silly").

HOWEVER, I'd think what would really be nice for this would be an  
O_NOATIME flag (which does enforce read-only operation, of course), and  
not fixing the atime back afterwards (inherently racy, but even more so by  
design of utimes and ctime).

That flag would also be fairly easy to detect with autoconf or similar  
functionality.

MfG Kai
