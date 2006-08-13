Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWHMAXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWHMAXt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWHMAXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:23:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbWHMAXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:23:49 -0400
Date: Sat, 12 Aug 2006 17:23:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_swap_bio() question
Message-Id: <20060812172341.0132a415.akpm@osdl.org>
In-Reply-To: <200608112332.18015.rjw@sisk.pl>
References: <200608112332.18015.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 23:32:17 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> I'm looking at get_swap_bio() in mm/page_io.c and wonder why the result of
> map_swap_page() in there is multiplied by (PAGE_SIZE >> 9).  Is it the block
> size of 512 B hardcoded?  And if so, is that actually right (I mean, aren't there
> any block devices with different block sizes)?
> 

Yep, the Linux block layer is based on a 512-bytes sector all over the
place.  Everywhere you see a sector_t, that's in units of 512-byte-sectors.
