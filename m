Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTJVOvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 10:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTJVOvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 10:51:40 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:31761 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263215AbTJVOvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 10:51:39 -0400
Date: Wed, 22 Oct 2003 15:51:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix console driver
Message-ID: <20031022155137.A23053@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031022150759.A21653@infradead.org> <Pine.SGI.3.96.1031022093244.262870B-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.3.96.1031022093244.262870B-100000@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Oct 22, 2003 at 09:39:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 09:39:12AM -0500, Pat Gefre wrote:
> + > Were all the points which Christoph raised considered?
> + 
> + No.
> + 
> 
> Which item(s), specifically, do you have an issue with ?

You're still registering with the normal serial major/minor without
using serial core.  That means the normal serial driver can't be used
when sn_serial is loaded, e.g. for using a pci serial card in an
altix.  The irq mess still isn't fixed - this isn't exactly an issue
with this driver but I exposing the bloody mess outside arch/ia64/sn
is a very bad idea.  I'd suggest kicking ajm to fix that up.

pciio.h has no business beeing included in this driver that doesn't
use anything PCIish, again a core SN issue that needs fixing.

Also after reading through the new comment ontop of the file it might
be a good idea to rename it to sn_console.c, especially now that there
is a real ioc4 serial driver.

