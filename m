Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269175AbUHZSD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbUHZSD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269138AbUHZSBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:01:07 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:21153 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269217AbUHZRzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:55:35 -0400
Date: Thu, 26 Aug 2004 19:55:14 +0200
From: Christophe Saout <christophe@saout.de>
To: Diego Calleja <diegocg@teleline.es>
Cc: Rik van Riel <riel@redhat.com>, jamie@shareable.org,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826175512.GA16785@leto.cs.pocnet.net>
References: <20040826190548.3e67726f.diegocg@teleline.es> <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com> <20040826194010.548e4a4c.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826194010.548e4a4c.diegocg@teleline.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 07:40:10PM +0200, Diego Calleja wrote:

> > So all I need to do is "cat /bin | gzip -9 > /path/to/backup.tar.gz" ?
> 
> /bin could be separated (like linus said) but cat /bin/.compound could do
> it. This is the /etc/passwd Hans' example, I think:

Yes, but what about locking? If we have compound files with
individually accessible components a lock on the compound files
could lock its components at the same time.

But what with /usr/.compound? Is it read-only? What if you truncate it?
Does it atomically delete the whole /usr directory tree? What about reading?
It has to go through all these independent files, what if they change while
you are reading the compound file? Does it lock everything? Point-in-time
snapshot? If reiser4 can't do this. ;-)

I don't say that it's impossible to do but I think it's a lot harder than
doing it the other way round.
