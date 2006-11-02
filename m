Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWKBWTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWKBWTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWKBWTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:19:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8101 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751426AbWKBWTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:19:09 -0500
Subject: Re: Can Linux live without DMA zone?
From: Arjan van de Ven <arjan@infradead.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
In-Reply-To: <454A627C.1090104@cfl.rr.com>
References: <20061102021547.GA1240@srv.junsun.net>
	 <454A1D82.7040709@cfl.rr.com>
	 <1162486642.14530.64.camel@laptopd505.fenrus.org>
	 <454A4237.90106@cfl.rr.com>
	 <1162498205.14530.83.camel@laptopd505.fenrus.org>
	 <454A627C.1090104@cfl.rr.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 02 Nov 2006 23:19:05 +0100
Message-Id: <1162505945.14530.98.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 16:26 -0500, Phillip Susi wrote:
> Arjan van de Ven wrote:
> > that's for the 32 bit boundary. THe problem is that there are 31, 30, 28
> > and 26 bit devices as well, and those are in more trouble, and will
> > eventually fall back to GFP_DMA (inside the x86 PCI code; the driver
> > just uses the pci dma allocation routines) if they can't get suitable
> > memory otherwise....
> > 
> > It's all nice in theory. But then there is the reality that not all
> > devices are nice pci device that implement the entire spec;)
> > 
> 
> Right, but doesn't the bounce/allocation routine take as a parameter the 
> limit that the device can handle?  If the device can handle 28 bit 
> addresses, then the kernel should not limit it to only 24 bits.

you're right in theory, but the kernel only has a few pools of memory
available, but not at every bit boundary. there is a 32 bit pool
(GFP_DMA32) on some, a 30-ish bit pool (GFP_KERNEL) on others, and a 24
bit pool (GFP_DMA) with basically nothing inbetween.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
 

