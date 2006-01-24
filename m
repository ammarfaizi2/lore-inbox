Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWAXIJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWAXIJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWAXIJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:09:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20940 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030364AbWAXIJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:09:52 -0500
Date: Tue, 24 Jan 2006 09:09:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: use bytes as image size units
Message-ID: <20060124080937.GB1604@elf.ucw.cz>
References: <200601240032.26735.rjw@sisk.pl> <20060123235642.GD6924@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123235642.GD6924@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 23-01-06 18:56:42, Dave Jones wrote:
> On Tue, Jan 24, 2006 at 12:32:26AM +0100, Rafael J. Wysocki wrote:
>  > Hi,
>  > 
>  > This patch makes swsusp use bytes as the image size units, which is needed
>  > for future compatibility.
> 
> With what ?  I don't see how clipping this range to a maximum of 4GB
> will future-proof anything. What happens in a few years time when
> I want to suspend my 8GB laptop ?

With rest of suspend code, which uses bytes because depending on
PAGE_SIZE is just too ugly. Notice that image size is smaller than
half of lowmem, by design, so thats okay.

In unlikely case of 8GB 32-bit laptop, either suspend image fits into
lowmem, or you are out of luck... Also notice that kernel is allowed
to use bigger image than size limit if it can not shrink image
further. Current code is equivalent with always having limit of 0.

								Pavel
-- 
Thanks, Sharp!
