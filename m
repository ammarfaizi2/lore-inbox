Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267224AbUBSC1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUBSC1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:27:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:59787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267224AbUBSC1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:27:13 -0500
Date: Wed, 18 Feb 2004 18:26:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: miquels@cistron.nl, axboe@suse.de, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: IO scheduler, queue depth, nr_requests
Message-Id: <20040218182628.7eb63d57.akpm@osdl.org>
In-Reply-To: <20040219021159.GE30621@drinkel.cistron.nl>
References: <20040216131609.GA21974@cistron.nl>
	<20040216133047.GA9330@suse.de>
	<20040217145716.GE30438@traveler.cistron.net>
	<20040218235243.GA30621@drinkel.cistron.nl>
	<20040218172622.52914567.akpm@osdl.org>
	<20040219021159.GE30621@drinkel.cistron.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>
> The thing is, the bio's are submitted perfectly sequentially. It's just that
>  every so often a request (with just its initial bio) gets stuck for a while.
>  Because the bio's after it are merged and sent to the device, it's not
>  possible to merge that stuck request later on when it gets unstuck, because
>  the other bio's have already left the building so to speak.

Oh.  So the raid controller's queue depth is larger than the kernel's.  So
everything gets immediately shovelled into the device and the kernel is
left with nothing to merge the little request against.

Shouldn't the controller itself be performing the insertion?
