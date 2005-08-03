Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVHCUtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVHCUtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 16:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVHCUtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 16:49:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8880 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262439AbVHCUtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 16:49:16 -0400
Date: Wed, 3 Aug 2005 13:49:08 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] optimize writer path in time_interpolator_get_counter()
In-Reply-To: <1123086733.5193.69.camel@tdi>
Message-ID: <Pine.LNX.4.62.0508030954350.24344@schroedinger.engr.sgi.com>
References: <1122911571.5243.23.camel@tdi>  <200508021837.j72Ib7T9020681@agluck-lia64.sc.intel.com>
  <1123080155.5193.15.camel@tdi>  <Pine.LNX.4.62.0508030907370.24104@schroedinger.engr.sgi.com>
 <1123086733.5193.69.camel@tdi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005, Alex Williamson wrote:

>    Ok, I can see the scenario where that could produce jitter.  However,
> that implies than any exit through that path could produce jitter as it
> is.  For instance:

Well what is the difference of this approach from booting with "nojitter"? 
The ITC offsets are fixed right?

Just check that the ITC difference is less than what you want to risk and 
switch on "nojitter" during bootup if less than the limit. Same effect 
without changes to the critical timer code patchs.

The main problem occurs as far as I know when execution continues on 
another processor during time measurement. In that case you may get an 
earlier time later because the ITC of the processor you migrated to is not 
there yet.... Similar issues may occur if time information is communicated 
between threads running on different processor.

You have an awful nest of rats here so if you do this then please at 
least do a printk that warns people of what is going on.

