Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWJESs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWJESs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWJESs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:48:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:62912 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750793AbWJESs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:48:27 -0400
Date: Thu, 5 Oct 2006 11:05:44 -0700
From: Greg KH <gregkh@suse.de>
To: Jarek Poplawski <jarkao2@o2.pl>, "Axel C. Voigt" <Axel.Voigt@qosmotec.com>,
       linux-kernel@vger.kernel.org, David Kubicek <dave@awk.cz>
Subject: Re: Problems with hard irq? (inconsistent lock state)
Message-ID: <20061005180544.GC15199@suse.de>
References: <46E81D405FFAC240826E54028B3B02953B13@aixlac.qosmotec.com> <20061004054308.GA994@ff.dom.local> <20061004054309.GA387@suse.de> <20061004064542.GA2649@ff.dom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004064542.GA2649@ff.dom.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 08:45:43AM +0200, Jarek Poplawski wrote:
> On Tue, Oct 03, 2006 at 10:43:09PM -0700, Greg KH wrote:
> > On Wed, Oct 04, 2006 at 07:43:08AM +0200, Jarek Poplawski wrote:
> > > On 29-09-2006 13:45, Axel C. Voigt wrote:
> ...
> > > > Sep 29 13:29:53 mcs70 kernel: =================================
> > > > Sep 29 13:29:53 mcs70 kernel: [ INFO: inconsistent lock state ]
> > > > Sep 29 13:29:53 mcs70 kernel: ---------------------------------
> > > > Sep 29 13:29:53 mcs70 kernel: inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
> > > > Sep 29 13:29:53 mcs70 kernel: startDV24/3864 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > > > Sep 29 13:29:53 mcs70 kernel: (&acm->read_lock){++..}, at: [<e08952d8>] acm_read_bulk+0x60/0xde [cdc_acm]
> > > > Sep 29 13:29:53 mcs70 kernel: {hardirq-on-W} state was registered at:
> ...
> > > It looks in drivers/usb/class/cdc-acm.c acm_rx_tasklet could be preempted
> > > with acm->read_lock by acm_read_bulk which uses the same lock from hardirq
> > > context.
> > > 
> > > So probably spin_lock_irqsave is needed.  
> > 
> > Yup.  Care to send a patch?
> 
> If it could help?

Great, care to resend this to me with a signed-off-by: line?

thanks,

greg k-h
