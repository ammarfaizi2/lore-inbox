Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272781AbRIGREv>; Fri, 7 Sep 2001 13:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272418AbRIGREm>; Fri, 7 Sep 2001 13:04:42 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:27637 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272781AbRIGRE3>; Fri, 7 Sep 2001 13:04:29 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 7 Sep 2001 11:04:26 -0600
To: Mack Stevenson <mackstevenson@hotmail.com>
Cc: linux-kernel@vger.kernel.org, reiser@namesys.com,
        nerijus@users.sourceforge.net
Subject: Re: Basic reiserfs question
Message-ID: <20010907110426.D32553@turbolinux.com>
Mail-Followup-To: Mack Stevenson <mackstevenson@hotmail.com>,
	linux-kernel@vger.kernel.org, reiser@namesys.com,
	nerijus@users.sourceforge.net
In-Reply-To: <F1296yL2m9lHiu3fQtY00009c2d@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F1296yL2m9lHiu3fQtY00009c2d@hotmail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 07, 2001  13:38 +0200, Mack Stevenson wrote:
> Sorry, but there's something still troubling me: is getting the following 
> lines written to syslog normal upon booting after a "clean" shutdown or an 
> indicator of a "dirty" shutdown?
> 
> >From syslog, referring to the last time I booted my machine:
> 
> reiserfs: checking transaction log (device 03:02) ...
> Warning, log replay starting on readonly filesystem
> reiserfs: replayed 16 transactions in 4 seconds
> using r5 hash to sort names
> ReiserFS version 3.6.25
> VFS: Mounted root (reiserfs filesystem) readonly.

This clearly means that it is a "dirty" shutdown, because it is replaying
the journal log.  

> Should I worry if I don't get such messages whenever I boot? Or should I 
> worry if I get those messages after (apparently) clean shutdown procedures?

It would be troublesome if you got the messages after a clean shutdown.
This might mean that reiserfs is not syncing some journal buffers to disk
when the root filesystem is remounted read-only.  Alternately, it may mean
that it is finding bogus transactions to replay in the journal (I don't
know how reiserfs determines whether the journal is clean or dirty).

It may also mean that your disk claims to have written data to disk, but
then only puts it in cache and you power off before in actually writes it.
Do you have APM/ACPI power off after shutdown?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

