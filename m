Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTKGWC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTKGWBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:01:05 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:59665 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264028AbTKGJ6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:58:17 -0500
Date: Fri, 7 Nov 2003 09:58:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031107095814.A2363@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@debian.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B060ED69@AVEXCH02.qlogic.org> <20031106175306.GG26869@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031106175306.GG26869@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Thu, Nov 06, 2003 at 05:53:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 05:53:06PM +0000, Matthew Wilcox wrote:
> > 
> > 	o Build process -- (three module interface for the ISPs), I
> > 	  personally like the idea of a shared library module used
> > 	  between the different ISP drivers.  Many others have voiced
> > 	  their frustrations with the single driver-binary for each
> > 	  ISP type that the directive from management is to have a
> > 	  single binary for all *future* products including the 
> > 	  ISP23xx (ISP2300/ISP2310/ISP2312/ISP2322) chips.
> > 
> > 	  That unfortunately leaves ISP2100 and ISP2200 on the
> > 	  periphery of development efforts.
> 
> I wouldn't see a problem with having a structure like this:
> 
> ql2100.c
> ql2200.c
> ql23xx.c
> qllib.c
> 
> and linking in whichever files are selected.  But you definitely only want
> to build qllib.c once.

Well, if you look at the driver you'll need all files except the firmware
anyway.  And now that we have the request_firmware interface anyway I'd
bebetter to move that out of the module, at least once initramfs settles down
a bit.

The issue is more lots of tiny ifdefs - those in the C source could be easily
hidden using pdev->device comparisms (and I think I'm gonna submit a patch
for that soon, the driver already does that for ISP23XX variants without
a proper abstraction).  Those in the headers are a bit more difficult as the
register layout is a bit different sometimes.  But with doing these as unions
instead of ifdefs and splitted subroutines this should be managæble as well,
the feral driver already does this nicely.

-- 
Christoph Hellwig <hch@lst.de>		-	Freelance Hacker
Contact me for driver hacking and kernel development consulting
