Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbUCCAGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUCCAGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:06:20 -0500
Received: from ozlabs.org ([203.10.76.45]:53384 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261754AbUCCAGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:06:18 -0500
Subject: Re: modules registering as sysctl handlers
From: Rusty Russell <rusty@rustcorp.com.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040302124106.GQ16357@parcelfarce.linux.theplanet.co.uk>
References: <20040302122909.GG24260@mulix.org>
	 <20040302124106.GQ16357@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1078272339.15766.5.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Mar 2004 11:05:39 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 23:41, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Tue, Mar 02, 2004 at 02:29:09PM +0200, Muli Ben-Yehuda wrote:
> > Hi 
> > 
> > Looking at 2.6.3-bk, it appears that the sysctl code does not raise a
> > module's reference count before calling a sysctl handler registered by
> > that module. 
> > 
> > - are modules allowed to register sysctl handlers?
> > register_sysctl_table is exported, so I imagine so. 
> > 
> > - am I missing something and modules are in fact protected against
> > concurrent unloading and invocation of sysctl?
> 
> They are not and no, bumping refcount would not be anywhere near enough.

Al is referring to the fact that there's no protection for a dynamically
allocated ctl_table.

However, an owner field and standard module_get() would solve the case
of statically declared ctl_table.

I don't know that there's a current user who requires it though?

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

