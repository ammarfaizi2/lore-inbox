Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbTALRJC>; Sun, 12 Jan 2003 12:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTALRJC>; Sun, 12 Jan 2003 12:09:02 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:13067 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267303AbTALRJC>; Sun, 12 Jan 2003 12:09:02 -0500
Date: Sun, 12 Jan 2003 17:17:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112171744.A11040@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030112092706.GN30025@kroah.com> <Pine.LNX.4.44.0301120856020.12667-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301120856020.12667-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 12, 2003 at 09:05:16AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 09:05:16AM -0800, Linus Torvalds wrote:
> The only place that looked like it _really_ didn't get the kernel lock was
> apparently tty_open(), which is admittedly a fairly important part of it ;)

2.5 does hold the BKL on ->open of charater- (and block-) devices.

The real problem is that the big irqlock is gone and mingo just replaced
it with local_irq_save & friends, which is not enough.
