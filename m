Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTEEH3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 03:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbTEEH3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 03:29:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261893AbTEEH3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 03:29:02 -0400
Date: Mon, 5 May 2003 08:41:31 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@digeo.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] how to fix is_local_disk()?
Message-ID: <20030505074131.GA10374@parcelfarce.linux.theplanet.co.uk>
References: <20030504090003.A7285@lst.de> <20030504003021.077e8819.akpm@digeo.com> <20030504010014.67352345.akpm@digeo.com> <20030504191013.A10659@lst.de> <20030504140537.50310417.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504140537.50310417.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 02:05:37PM -0700, Andrew Morton wrote:
 
> About half of the s_umount grabbers perform that check.  The others might be
> buggy.  I'm not sure - it's all rather gunky in there and hard to tell what
> the rules are.

Very simple, actually - if you are holding an active reference, no checks
are needed.  If you do not (as in this case) - you need to check that
filesystem is not in the middle of shutdown after getting ->s_umount.
