Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUCBMlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 07:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUCBMlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 07:41:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43490 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261627AbUCBMlK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 07:41:10 -0500
Date: Tue, 2 Mar 2004 12:41:06 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: modules registering as sysctl handlers
Message-ID: <20040302124106.GQ16357@parcelfarce.linux.theplanet.co.uk>
References: <20040302122909.GG24260@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302122909.GG24260@mulix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 02:29:09PM +0200, Muli Ben-Yehuda wrote:
> Hi 
> 
> Looking at 2.6.3-bk, it appears that the sysctl code does not raise a
> module's reference count before calling a sysctl handler registered by
> that module. 
> 
> - are modules allowed to register sysctl handlers?
> register_sysctl_table is exported, so I imagine so. 
> 
> - am I missing something and modules are in fact protected against
> concurrent unloading and invocation of sysctl?

They are not and no, bumping refcount would not be anywhere near enough.
It's not just modules - no module refcount will help e.g. per-interface
sysctls.  All dynamic sysctls are b0rken and the best course of action
is to avoid using that crap.

We'll need to fix that mess, but it won't be easy.
