Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129573AbQK1QRp>; Tue, 28 Nov 2000 11:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129575AbQK1QRf>; Tue, 28 Nov 2000 11:17:35 -0500
Received: from unthought.net ([212.97.129.24]:38803 "HELO mail.unthought.net")
        by vger.kernel.org with SMTP id <S129573AbQK1QRX>;
        Tue, 28 Nov 2000 11:17:23 -0500
Date: Tue, 28 Nov 2000 16:47:21 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Kevin Krieser <kkrieser@delphi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: out of swap
Message-ID: <20001128164721.I21902@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
        Kevin Krieser <kkrieser@delphi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A22EC94.2A434703@mindspring.com> <000b01c058ec$6791abe0$0701a8c0@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <000b01c058ec$6791abe0$0701a8c0@thinkpad>; from kkrieser@delphi.com on Mon, Nov 27, 2000 at 09:36:33PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 09:36:33PM -0600, Kevin Krieser wrote:
> 
> > What would I like it to do?  Warn me maybe before my swap goes to
> > zero.  Kill the
> > program that is doing this possibly.  Allow me to set a per
> > process memory / swap
> > limit so that no one process can suck up my system resources.
> >
> 
> There are several programs available with the typical Linux installation
> that allows you to monitor swap space.  For example, xosview.

Yep

> 
> There are also settings you can make in Netscape that supposedly limit disk
> space usage and memory usage.

But this doesn't help this particular problem, I think. The problem is probably
not the in-memory cache, but the resource consumption caused by netscape
loading the pictures.

You can use ulimit (or pam) to set memory consumption limits for each process,
and that would usually do the trick (see /etc/pam.d/ and
/etc/security/limits.conf at least on RedHat).

Unfortunately, Netscape sends the images to the X server, so usually you will
see that Netscape's memory consumption stays fairly constant, while your X
server will start consuming lots of memory.   If you set the resource limits,
your X server will be the obvious choice for the OOM killer (I guess -
comments, Riel or Andrea ?).  I don't know of any good solution to this problem
other than just having enough swap space - after all, seriously, with today's
disks, who can't spare an extra few hundred megs (which would usually be more
than enough).

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
