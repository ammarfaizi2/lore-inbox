Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVDEHZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVDEHZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVDEHW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:22:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5852 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261592AbVDEHV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:21:28 -0400
Date: Tue, 5 Apr 2005 08:21:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: iomapping a big endian area
Message-ID: <20050405072104.GA26208@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Matthew Wilcox <matthew@wil.cx>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1112475134.5786.29.camel@mulgrave> <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk> <1112649465.5813.106.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112649465.5813.106.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 04:17:45PM -0500, James Bottomley wrote:
> OK, I sent the patch off to Andrew.  To complete the original problem,
> the attached is the patch that uses it in the parisc lasi driver
> (although, actually, it sets up 53c700 to work everywhere including BE
> on a LE system).
> 
> I changed some of the flags around to reflect the fact that we now have
> generic BE support in the driver (rather than the more limited
> force_le_on_be flag).

What I really don't like is that you still need ifdefs and wrappers to
support BE and LE wired chips in the same driver.  Shouldn't you set the
BE or LE flag at iomap() time and always use the same accessors?

