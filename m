Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUDPMFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUDPMFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:05:55 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:51984 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262909AbUDPMFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:05:52 -0400
Date: Fri, 16 Apr 2004 13:05:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (new)
Message-ID: <20040416130548.B5080@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040410021703.946A9DBE3@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040410021703.946A9DBE3@gherkin.frus.com>; from rct@gherkin.frus.com on Fri, Apr 09, 2004 at 09:17:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 09:17:03PM -0500, Bob Tracy wrote:
> The attached patch set implements a PCMCIA SCSI driver for host adapters
> based on the Symbios 53c500 chip.  The original driver for this chip was
> written by Thomas Corner and available only as an add-on to the
> pcmcia-cs package.  I've been maintaining the add-on driver on an
> infrequent basis for the past several years, and the release of the 2.6
> kernel "forced" a long overdue update.
> 
> The only host adapter I'm aware of that uses the sym53c500 controller
> chip is the "new" version of the New Media Bus Toaster (circa 1996),
> and the attached driver has been tested using this particular adapter
> on a 2.6.4 kernel.  The patch set applies cleanly to 2.6.4 and 2.6.5.
> 
> Comments / feedback / cheers / jeers accepted...

I've given it a short spin and here's a bunch of comments:

 - the split into three source files is supserflous, one file should do it
 - please don't use host.h or scsi.h from drivers/scsi/.  The defintions
   not present in include/scsi/ are deprecated and shall not be used (the
   most prominent example in your driver are the Scsi_<Foo> typedefs that
   have been replaced by struct scsi_foo
 - the driver doesn't even try to deal with multiple HBAs
 - your detection logic could be streamlined a little, e.g. the request/release
   resource mess

