Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbULPXRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbULPXRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbULPXRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:17:18 -0500
Received: from [213.146.154.40] ([213.146.154.40]:30660 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262069AbULPXPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:15:21 -0500
Date: Thu, 16 Dec 2004 23:15:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
Message-ID: <20041216231519.GA16249@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <200412162224.iBGMOQ52284713@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412162224.iBGMOQ52284713@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 04:24:26PM -0600, Pat Gefre wrote:
> I have a serial driver for Altix I'd like to submit.
> 
> The code is at:
> ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
> 
> Signed-off-by: Patrick Gefre <pfg@sgi.com>

I took a very short look and what spring to mind first is that the
device probing/remoal is rather bogus.  The ->probe/->remove callbacks
of a PCI driver can be called at any time, and any initialization /
teardown actions must happen from those.  A logical consequence of that
is that a proper PCI driver should have no global state.

I'd also like to second Matthews commens, please move the driver to
drivers/serial and use proper readX/writeX accessors.  Please run the
driver through sparse to find the iomem derferences and possibly other
issues.
