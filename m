Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUH3AHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUH3AHb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 20:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUH3AHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 20:07:31 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:57221 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268368AbUH3AH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 20:07:29 -0400
In-Reply-To: <1093821430.8099.49.camel@lade.trondhjem.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: silent semantic changes with reiser4
Cc: viro@parcelfarce.linux.theplanet.co.uk, reiser@namesys.com, flx@msu.ru,
       pj@sgi.com, riel@redhat.com, ninja@slaphack.com, diegocg@teleline.es,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com, torvalds@osdl.org
X-Mailer: BeMail - Mail Daemon Replacement 2.3.1 Final
From: "Alexander G. M. Smith" <agmsmith@rogers.com>
Date: Sun, 29 Aug 2004 20:07:24 -0400 EDT
Message-Id: <1326059983-BeMail@cr593174-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote on Sun, 29 Aug 2004 19:17:10 -0400:
> Is it just the fantasy of supporting hard-links across "stream
> boundaries" (as in "touch a b; ln b a/b; ln a b/a")? I'm pretty sure
> nobody wants to have to add cyclic graph detection to their filesystems
> anyway. 8-)

Been there, done that.  It works in a rough form in an experimental RAM file system for BeOS.  But deleting files requires a graph traversal to see if it is isolating just one item or a whole bunch of them.  It also implies keeping track of multiple parent directories for everything.  It does make it useful for the user - you can have files and directories in multiple places, so you don't have to decide on one classification for a file (or directory).  One other downside is a lot of locking complexity (or not if you don't need fine grained locking) to guarantee atomicity of the delete.

For user convenience, the low level delete function returns an error code if there is more than one item cut off from the root, but it could just as well delete all of them (sort of like rmdir giving an error if the directory isn't empty rather than just deleting everything).

- Alex
