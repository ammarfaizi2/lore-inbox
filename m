Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUENWra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUENWra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUENWr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:47:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51653 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263085AbUENWrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:47:24 -0400
Date: Fri, 14 May 2004 23:47:22 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: FabF <Fabian.Frederick@skynet.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.6-mm2] vfs iput in inode critical region
Message-ID: <20040514224722.GL17014@parcelfarce.linux.theplanet.co.uk>
References: <1084476395.7979.10.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084476395.7979.10.camel@bluerhyme.real3>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 09:26:36PM +0200, FabF wrote:
> Hi,
> 
> 	AFAICS, block_dev.c : do_open calls bdput after an unlock_kernel.bdput
> calls iput and iput plays with some parameters and locks in iput final
> case only.Here's a patch to have a spinlock around the whole iput.

Huh?  Of course iput() is called without BKL (and in a lot more places than
just that, actually), but why does it imply that we suddenly need to hold
inode_lock over the entire function?
