Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTKQJsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTKQJsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:48:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263462AbTKQJsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:48:33 -0500
Date: Mon, 17 Nov 2003 09:48:32 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: William Lee Irwin III <wli@holomorphy.com>,
       Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031117094832.GU24159@parcelfarce.linux.theplanet.co.uk>
References: <20031117083007.GA22764@holomorphy.com> <Pine.LNX.4.44.0311170832030.1089-100000@einstein.homenet> <20031117084804.GB22764@holomorphy.com> <20031117090339.GC22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117090339.GC22764@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 01:03:39AM -0800, William Lee Irwin III wrote:
> On Mon, Nov 17, 2003 at 12:48:04AM -0800, William Lee Irwin III wrote:
> > There's a retry loop where the buffer size is doubled each iteration
> > that looks to me like automagic sizing in the code for seq_read(). I
> > can't say I've actually tried to rely on getting more than a page
> > at a time through seq_read(), though.
> 
> Woops. This looks like it only makes sure there's enough to get the
> first ->show() into the buffer; I see that it later gives up when
> m->count == m->size once the first ->show() has enough bufferspace to
> complete later on. So if all ->show() operations to do are less than
> PAGE_SIZE, it'll never hand back more than a page at a time, and may
> hand back short reads prior to EOF, which doesn't bode well for my
> short read == EOF idea (maybe not a great assumption in general).

That's "broken assumption", thank you very much.  There is one and only one
indication of EOF - read() returning 0.  Any application that treats short
read as EOF is broken.  As in "apply Stevens to offender's cranium until
something gives; if it's the book, replace with fresh copy and repeat".
