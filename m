Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUECVGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUECVGv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbUECVGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:06:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:18188 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263995AbUECVGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:06:50 -0400
Date: Mon, 3 May 2004 23:05:31 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Bill Catlan <wcatlan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible to delay boot process to boot from USB subsystem?
Message-ID: <20040503210531.GA206@pcw.home.local>
References: <003201c4309c$fd93cd90$0202a8c0@boxa> <20040503053418.GB10228@alpha.home.local> <004001c4314f$6f455a50$0202a8c0@boxa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004001c4314f$6f455a50$0202a8c0@boxa>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 04:44:30PM -0400, Bill Catlan wrote:
> Thanks Willy.  I like to automatic looping of Randy's patch (I had it working
> nicely on a 2.4.18 kernel) because I don't have to set a time in case one
> machine takes longer than another.

I certainly can understand this, although I've never tried it yet.

> So far, however, I haven't got Randy's patch working for a newer kernel, so I
> may try yours.
> 
> Would I only have to run make in the directory where I'm patching the file, then
> make bzImage, make modules_install, and make install from the top level to apply
> your patch?  Compiling all of my modules takes a long time, with random lock-ups
> during compile gumming up the works as well. :-/  Any tips appreciated.

No exactly, you should not run 'make' from the 'init' directory, but rather
tell 'make' where you want it to check for changes :

# make bzImage SUBDIRS=init

It will skip over other directories (such as drivers, fs, net, ...) and
only recompile below 'init'. I do this very often and it's very convenient.
However, you should not do this if you have changed certain compile options
or things that might imply different dependencies.

A hint to check if it has been correctly configured :

# nm vmlinux | grep setuptime
c01b2b80 d __setup_setuptime_setup
c01ab039 d __setup_str_setuptime_setup
c015700c b setuptime
c01b31b0 t setuptime_setup

Regards,
Willy

