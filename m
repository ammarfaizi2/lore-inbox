Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263964AbUCPRJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbUCPRJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:09:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:24195 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263964AbUCPRIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:08:41 -0500
Date: Tue, 16 Mar 2004 09:08:12 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
Message-ID: <20040316170812.GA14971@kroah.com>
References: <20040313014156.GB10930@kroah.com> <OF625BA2CA.1376AB85-ONC1256E58.002FCAD7-C1256E58.00331651@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF625BA2CA.1376AB85-ONC1256E58.002FCAD7-C1256E58.00331651@de.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 10:18:00AM +0100, Martin Schwidefsky wrote:
> 
> So we need an external release function, one that isn't part of the zfcp
> module. This external release function is either a generic function for
> all these objects or a dedicated release function for each of the
> additional
> device objects. A dedicated release function would mean to define a release
> function somewhere in the kernel or another module just for the purpose of
> freeing an object defined by the zfcp module. This is even more gross than
> to use a generic release function. And the simplest release function is
> kfree.

This is not ok.  If you have to do something like this, I really suggest
that you not allow the "sub modules" be able to unload before the upper
module can.  In fact, why would you want to do such a thing?

I still really strongly object to this patch.  If it's a scsi problem,
fix it there, but odds are it's your driver's problem as no other scsi
driver needs this.

thanks,

greg k-h
