Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUFYMKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUFYMKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUFYMK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:10:29 -0400
Received: from [213.146.154.40] ([213.146.154.40]:38839 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265872AbUFYMKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:10:25 -0400
Date: Fri, 25 Jun 2004 13:10:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David van Hoose <david.vanhoose@comcast.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
Message-ID: <20040625121023.GA29274@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David van Hoose <david.vanhoose@comcast.net>,
	Helge Hafting <helge.hafting@hist.no>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no> <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org> <40DC1192.7030006@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DC1192.7030006@comcast.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 07:50:42AM -0400, David van Hoose wrote:
> yeah.. Really. Here's what I do.
> 
> I have ext3 partitions, so I decided if they are different partitions, 
> then I can compile my kernel with ext2 as a module and ext3 builtin.
> So I do it and reboot. Panic! Reason? Cannot find filesystem for the 
> root partition.
> The error is in the kernel itself either way. Pick your reason.
> 1) ext3 is identified as ext2 on bootup.
> 2) There is no fallback to ext3 if ext2 is not found.

Doesn't make sense.  The kernel just tries all registered filesystems
for the rootfs until one clames it.  It means you either:

 - don't actually have ext3 in the kernel or
 - the filesystems actually is ext2 and not ext3

Try calling debugfs /dev/$ROOTDEVICE and then typing features, what does it
say?

