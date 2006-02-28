Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWB1MnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWB1MnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWB1MnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:43:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64693 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932206AbWB1MnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:43:16 -0500
Date: Tue, 28 Feb 2006 12:43:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jejb@steeleye.com, linux-scsi@vger.kernel.org
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060228124314.GA4674@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jejb@steeleye.com, linux-scsi@vger.kernel.org
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 09:27:28PM -0800, Linus Torvalds wrote:
> 
> The tar-ball is being uploaded right now, and everything else should 
> already be pushed out. Mirroring might take a while, of course.
> 
> There's not much to say about this: people have been pretty good, and it's 
> just a random collection of fixes in various random areas. The shortlog is 
> actually pretty short, and it really describes the updates better than 
> anything else.
> 
> Have I missed anything? Holler. And please keep reminding about any 
> regressions since 2.6.15.

We still have a regression from 2.6.15 in the megaraid_sas driver.

We started sending down all requests as scatter/gather lists after 2.6.15,
and the (broken) way megaraid_sas tried to hide the physical disks ceased
to work.  Now the driver shows all physical disks which confuses installers
to no end and could trick people to write to it which would corrupt controller
internal state badly.

To fix this properly the scsi midlayer needs to handle the ->slave_configure
return value.  The patch for that is pretty trivially, but could in theory
cause problems if an existing driver returns something bogus from
->slave_configure.   Both the core patch and the actual megaraid_sas fix
are in James' scsi-rc-fixes tree, so if you pull that once more we should
be done with this.
