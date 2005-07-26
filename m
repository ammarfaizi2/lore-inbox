Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVGZLFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVGZLFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 07:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVGZLDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 07:03:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:30655 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261682AbVGZLDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 07:03:09 -0400
Date: Tue, 26 Jul 2005 16:33:11 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, James.Bottomley@SteelEye.com,
       Eric.Moore@lsil.com, bharata@in.ibm.com, Roy.Wade@lsil.com,
       Jared.Hayes@lsil.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [IBM] RE: [BUG] Fusion MPT Base Driver initialization failure wit h kdum p
Message-ID: <20050726110311.GC4047@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1121858719.42de349feb815@imap.linux.ibm.com> <20050725151033.25196965.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725151033.25196965.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 03:10:33PM -0700, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > > If you don't stop the DMA engines before you boot the new kernel, the
> >  > addresses they have to send data to will now be random points in that
> >  > kernel's memory, leading to potential corruption of the new kernel
> >  > image.
> > 
> >  [Copying it to fastboot and linux-kernel mailing lists]
> > 
> >  We are booting second kernel (capture kernel) from a reserved memory location
> >  to take care of on-going DMA issues. So even if some DMA transactions are going
> >  on after the crash they will not corrupt the new kernel.
> > 
> >  > 
> >  > The interrupt panic of the fusion is probably a symptom of this: I bet a
> >  > DMA transfer has just completed and the interrupt is to inform us of
> >  > this (however, in the new kernel we're not expecting any transfers).
> > 
> >  That might very well be the case. So driver should simply ignore the interrupt
> >  when it is not expecting it or it should reset the device if it finds that 
> >  some interrupts are pending when it should not have been there.
> > 
> >  Basically it is a matter of hardening the driver so that it can handle/
> >  initialize the device even if the device is not in reset state. 
> 
> I'd expect that a lot of these problems could be reduced by simply pausing
> for a while in the crash handler, wait for I/O to complete.
> 

Andrew, We will test it out and see if it helps on some of the already
reported issues.

Thanks
Vivek
