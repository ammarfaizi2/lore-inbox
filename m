Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268724AbUHZMDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268724AbUHZMDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUHZMA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:00:59 -0400
Received: from mail.shareable.org ([81.29.64.88]:1990 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S268745AbUHZMAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:00:05 -0400
Date: Thu, 26 Aug 2004 12:58:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christer Weinigel <christer@weinigel.se>
Cc: Spam <spam@tnonline.net>, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826115856.GF30449@mail.shareable.org>
References: <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <m3llg2m9o0.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3llg2m9o0.fsf@zoo.weinigel.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:
> all applicatons that copy files will fail to copy the streams.  So
> no working cp command, no nautilus nor konqueror without changes to
> the application.

No true.  A lot of the fancy stuff depends on metadata which is merely
another view of the serialised contents in the flat file.  Nautilus &
Konqueror thumbnails are an example of that (I gave a few more in
other mails).  cp works fine with that, and so does ftp.  The metadata
is just recalculated when it's needed from the target file.

> And if you have to change the applications anyway, isn't it much
> better to agree on a shared library in userspace that everyone uses?
> Which has the added bonus that it can be made to work on top of
> Linux, Windows, Ultrix and VMS?

Ideally yes, a shared library _or_ at least an agreed representation.

However, with filesystem support you can improve performance by
avoiding unneed serialisation (write to your huge *Office
presentation, read it from another program, no need to wait for the
slow tar+compress stage yet it's _as if_ those were done), retain
computed metadata with coherency guarantees (e.g. real time search
indexes, crypto digests and such), and let the filesystem decide when
best to prune computed metadata or convert representations.

All of these things can work with a combination of userspace plugins
(not the same as reiser4 plugins), and filesystem support.

Without the filesystem support, you can still use the userspace
plugins -- so apps would still be portable -- but you don't get the
extras mentioned above.

-- Jamie
