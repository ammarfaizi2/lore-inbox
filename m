Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269095AbUHXWyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269095AbUHXWyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269096AbUHXWyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:54:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:13006 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269095AbUHXWxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:53:05 -0400
Date: Tue, 24 Aug 2004 15:56:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
Message-Id: <20040824155635.3d1a1dd6.akpm@osdl.org>
In-Reply-To: <m3d61gchyb.fsf@telia.com>
References: <m33c2py1m1.fsf@telia.com>
	<20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com>
	<20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com>
	<20040824144707.100e0cfd.akpm@osdl.org>
	<m3d61gchyb.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> > Are you saying that your requests are so huge that each one has 1000 BIOs? 
> > That would be odd, for an IDE interface.
> 
> No, the thing is that the packet driver doesn't create requests at
> all. It stuffs incoming bio's in the rbtree, then the worker thread
> collects bio's from the rbtree for the same "zone" on the disc (each
> zone is 64kb on a CDRW and 32KB on a DVD). The driver then creates a
> new bio with the same size as the zone size and submits it to the real
> CD/DVD device.

Good lord.  I assume there's a good reason for this?
