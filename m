Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVKGCbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVKGCbu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 21:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVKGCbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 21:31:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34775 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932272AbVKGCbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 21:31:50 -0500
Date: Sun, 6 Nov 2005 18:31:24 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Maurer <martinmaurer@gmx.at>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, axel.struebing@freenet.de
Subject: Re: kernel status, "Elitegroup K7S5A" SOLVED
Message-Id: <20051106183124.38a37baa.zaitcev@redhat.com>
In-Reply-To: <200511061922.16296.martinmaurer@gmx.at>
References: <mailman.1125954121.30702.linux-kernel2news@redhat.com>
	<20050907211350.18c07fa9.zaitcev@redhat.com>
	<200511061922.16296.martinmaurer@gmx.at>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2005 19:22:12 +0100, Martin Maurer <martinmaurer@gmx.at> wrote:

> > test this by editing the source code for 2.6.7.  In the file 
> > drivers/usb/storage/transport.c, locate the subroutine 
> > usb_stor_Bulk_max_lun() and comment out the two lines that call 
> > usb_stor_clear_halt().

> this solved my problem too. [...]
> (i tested with a vanilla kernel 2.6.14).

I would like to see a real patch instead of verbal descriptions, because
what you say is not easily believable. I suspect a language barrier.

The difficulty is, in 2.6.14, both ub and usb-storage clear halts when
the device stalls (in ub_probe and usb_stor_Bulk_max_lun). It may be
incorrect, because it's a stall on the control pipe, not a bulk pipe.
But I have no idea what the proper recovery procedure is (e.g. what
happens if we just ignore stalls of control transfers?)

If someone like Pat explaned me what to do, I could code it.

-- Pete
