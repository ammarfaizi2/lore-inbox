Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUBWVPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUBWVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:13:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:58321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262009AbUBWVKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:10:31 -0500
Date: Mon, 23 Feb 2004 13:08:21 -0800
From: Greg KH <greg@kroah.com>
To: Martin <marogge@onlinehome.de>
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       vishwas.manral@lycos.com, "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in pci_find_subsys
Message-ID: <20040223210821.GB22598@kroah.com>
References: <DMOCIEPNKDKOLIAA@mailcity.com> <200402230639.00737.robin.rosenberg.lists@dewire.com> <200402230830.45003.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402230830.45003.marogge@onlinehome.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 08:30:44AM +0100, Martin wrote:
> On Monday 23 February 2004 06:39, Robin Rosenberg wrote:
> 
> > > I was checking the pci documentation and it said under the heading
> > > Obsolete function pci_find_subsys() - Superseded by pci_get_subsys() as
> > > the former is not Hot plug safe. Could this be related to the problem
> >
> > You WHAT? Read the documentation! :-) I thought the ones calling the
> > function should do that.
> 
> Reading the documentation (ie. source code) it appears the problem is 
> triggered by the line
> 
> WARN_ON(in_interrupt());
> 
> Looks like the driver calls pci_find_subsys() from inside an interrupt on 
> occasions which apparently it shouldn't. The problem seems to be on 
> nvidia's side, not kernel development. I have emailed nvidia about it some 
> time ago, so far no reaction... 

This is correct, that function should not be called from within an
interrupt.  That is just stupid programming...

thanks,

greg k-h
