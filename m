Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbTGLGnq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 02:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267778AbTGLGnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 02:43:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24998 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267773AbTGLGno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 02:43:44 -0400
Date: Fri, 11 Jul 2003 23:58:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: willy@debian.org, bernie@develer.com, akpm@zip.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: do_div vs sector_t
Message-Id: <20030711235822.31dde2fc.akpm@osdl.org>
In-Reply-To: <20030712075202.A1327@infradead.org>
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
	<20030712075202.A1327@infradead.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jul 11, 2003 at 11:33:59PM +0100, Matthew Wilcox wrote:
> >                         aic->seek_mean = aic->seek_total + 128;
> >                         do_div(aic->seek_mean, aic->seek_samples);
> >                 }
> > 
> > seek_mean is a sector_t so sometimes it's 64-bit on a 32-bit platform.
> > so we can't avoid calling do_div().
> 
> That's why we have sector_div, never use do_div on a sector_t.

Thing is, the arith in there can overflow with 32-bit sector_t anyway, so
we need 64-bit quantities regardless of the CONFIG_LBD setting.

