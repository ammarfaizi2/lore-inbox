Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752492AbWKBUKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbWKBUKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbWKBUKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:10:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10943 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752492AbWKBUKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:10:23 -0500
Subject: Re: Can Linux live without DMA zone?
From: Arjan van de Ven <arjan@infradead.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
In-Reply-To: <454A4237.90106@cfl.rr.com>
References: <20061102021547.GA1240@srv.junsun.net>
	 <454A1D82.7040709@cfl.rr.com>
	 <1162486642.14530.64.camel@laptopd505.fenrus.org>
	 <454A4237.90106@cfl.rr.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 02 Nov 2006 21:10:05 +0100
Message-Id: <1162498205.14530.83.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 14:08 -0500, Phillip Susi wrote:
> Arjan van de Ven wrote:
> > that is a nice theory, but unfortunately there is just a lot of "PCI"
> > hardware out there for which the designers decided to save a bit of
> > copper and only wire up the lower X address lines (for various values of
> > X)
> 
> Yea, but shouldn't PCI drivers be using another means than allocating 
> from GFP_DMA?  Wasn't there some sort of bounce buffers call I can't 
> quite remember the details of?  That performs any required translations 
> to bus hardware addresses, and copies the buffer to a more appropriate 
> location if required, based on the specific requirements of that device?

that's for the 32 bit boundary. THe problem is that there are 31, 30, 28
and 26 bit devices as well, and those are in more trouble, and will
eventually fall back to GFP_DMA (inside the x86 PCI code; the driver
just uses the pci dma allocation routines) if they can't get suitable
memory otherwise....

It's all nice in theory. But then there is the reality that not all
devices are nice pci device that implement the entire spec;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

