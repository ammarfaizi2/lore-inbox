Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUGJPlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUGJPlr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUGJPlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:41:47 -0400
Received: from [213.146.154.40] ([213.146.154.40]:51898 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264638AbUGJPlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:41:46 -0400
Date: Sat, 10 Jul 2004 16:41:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tim Wright <timw@splhi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rmmod st "hangs" - bad interaction with sg
Message-ID: <20040710154145.GA17691@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tim Wright <timw@splhi.com>, linux-kernel@vger.kernel.org
References: <1089473460.1473.17.camel@tp-timw.internal.splhi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089473460.1473.17.camel@tp-timw.internal.splhi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 08:31:00AM -0700, Tim Wright wrote:
> Hi,
> I was working on the qlogicisp/isp1020 driver in 2.6, as I still have
> one of these antiques and the driver is a bit out of date (a patch is
> forthcoming). In the process of testing my changes, I came across the
> following:

qlogicisp is slowly going away.  If you look at the qla1280 driver in current
mainline you'll see it has most of the support for the 1020/1040 already,
I just need to fix a final bug and add firmware/pci ids.  This has come up
on linux-scsi a few times..

> This seems bad to me - either the original rmmod should fail with EBUSY,
> or it should complete. However, for it to do so, it seems that st needs
> to know that sg has its hooks into the device it controls, and it needs
> to be able to make it let go. My workaround is impractical if sg is in
> use on other devices too.

I don't think we can fix much about this, it's how the driver model code
works.  Best workarond is to not use sg.

