Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWEGQuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWEGQuy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWEGQuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:50:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932199AbWEGQuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:50:54 -0400
Date: Sun, 7 May 2006 09:50:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Schoonover <jasons@pioneer-pra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-Id: <20060507095039.089ad37c.akpm@osdl.org>
In-Reply-To: <200605051010.19725.jasons@pioneer-pra.com>
References: <200605051010.19725.jasons@pioneer-pra.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2006 10:10:19 -0700
Jason Schoonover <jasons@pioneer-pra.com> wrote:

> I'm having some problems on the latest 2.6.17-rc3 kernel and SCSI disk I/O.  
> Whenever I copy any large file (over 500GB) the load average starts to slowly 
> rise and after about a minute it is up to 7.5 and keeps on rising (depending 
> on how long the file takes to copy).  When I watch top, the processes at the 
> top of the list are cp, pdflush, kjournald and kswapd.

This is probably because the number of pdflush threads slowly grows to its
maximum.  This is bogus, and we seem to have broken it sometime in the past
few releases.  I need to find a few quality hours to get in there and fix
it, but they're rare :(

It's pretty harmless though.  The "load average" thing just means that the
extra pdflush threads are twiddling thumbs waiting on some disk I/O -
they'll later exit and clean themselves up.  They won't be consuming
significant resources.

