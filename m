Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUI1UQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUI1UQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUI1UQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:16:10 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:10244 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267770AbUI1UQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:16:07 -0400
Date: Tue, 28 Sep 2004 21:16:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: linux-kernel@vger.kernel.org, wenxiong@us.ibm.com
Subject: Re: [PATCH 2.6.8.1] drivers/char: New serial driver.
Message-ID: <20040928211602.B5355@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Kilau, Scott" <Scott_Kilau@digi.com>, linux-kernel@vger.kernel.org,
	wenxiong@us.ibm.com
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D774@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D774@minimail.digi.com>; from Scott_Kilau@digi.com on Mon, Sep 27, 2004 at 03:03:32PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 03:03:32PM -0500, Kilau, Scott wrote:
> I am submitting a new serial driver for the 2.6 series of kernels.
> 
> Description:
> Digi serial driver for the Digi Neo and Classic PCI serial port
> products.

 - you pci handling is rather bogus.  You must handle all initialization
   from ->probe and all teardown from ->remove.  No fuzzing with board
   count please - if pci_module_init returned success the driver must
   stay loaded
 - why is this one driver and not two?  Please split it into one driver
   for each hardware type
 - the procfs/sysctl support is rather gross.  For sysctl please use
   simple tabls like everyone else (e.g. look at fs/xfs/linux-2.6/xfs_systl.c)
   Also new procfs entries are discouraged in general, but if you absolutely
   need them use the fs/seq_file.c interface
 - please convert to Russell's serial_core interface (drivers/serial),
   we already have far more copies of the old serial driver munged into
   various driver than nessecary
 - if you want compat code please always emulted older apis on old
   ones.

