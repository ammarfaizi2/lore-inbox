Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbVCQOgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbVCQOgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVCQOgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:36:08 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56784 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263084AbVCQOfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:35:52 -0500
Subject: Re: Why no bigphysarea in mainline?
From: Dave Hansen <haveblue@us.ibm.com>
To: michael@ellerman.id.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PPC64 External List <linuxppc64-dev@ozlabs.org>
In-Reply-To: <200503172057.06570.michael@ellerman.id.au>
References: <200503172057.06570.michael@ellerman.id.au>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 06:35:32 -0800
Message-Id: <1111070132.19021.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 20:57 +1100, Michael Ellerman wrote:
> I realise bigphysarea is a bit of a hack, but it's no where near as
> big a hack as using mem=X to limit the kernel's memory and then using
> the rest of memory for your device driver.

Well, the fact that you can get away with that is a coincidence.  What
if you have 4GB of RAM on an x86 machine, you do mem=3G, and you start
using that top GB of memory for your driver?  You eventually write into
the PCI config space.  Ooops.  You get strange errors that way.

Doing mem= for drivers isn't just a hack, it's *WRONG*.  It's a ticking
time bomb that magically happens to work on some systems.  It will not
work consistently on a discontiguous memory system, or a memory hotplug
system.

> If no one has any fundamental objections I think it'd be good to get
> this merged into mainline so people start using it rather than mem=X
> hacks. To that end please let me know what you think is wrong with
> the patch as it stands (below).

Could you give some examples of drivers which are in the kernel that
could benefit from this patch?  We don't tend to put things like this
in, unless they have actual users.  We don't tend to change code for
out-of-tree users, either.

-- Dave

