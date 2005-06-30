Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVF3Xjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVF3Xjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 19:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbVF3Xjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 19:39:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:24505 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261230AbVF3Xji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 19:39:38 -0400
Subject: Re: PCI Power management (was: Re: [PATCH 4/13]: PCI Err: e100
	ethernet driver recovery
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Andi Kleen <ak@muc.de>, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com,
       linux-laptop@vger.kernel.org, mochel@transmeta.com, pavel@suse.cz
In-Reply-To: <20050630203931.GY28499@austin.ibm.com>
References: <20050628235848.GA6376@austin.ibm.com>
	 <1120009619.5133.228.camel@gaston> <20050629155954.GH28499@austin.ibm.com>
	 <20050629165828.GA73550@muc.de>  <20050630203931.GY28499@austin.ibm.com>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 09:32:43 +1000
Message-Id: <1120174364.31924.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 15:39 -0500, Linas Vepstas wrote:

> Thus, the right thing to do might be to split up the 
> struct pci_dev->suspend() and pci_dev->resume() calls into
> 
>    suspend()
>    poweroff()
>    poweron()
>    resume()

No. There are very good reasons not to do that split at the pci_dev
level.
 
> and then have the generic pci error recovery routines call
> suspend/resume only, skipping the poweroff-on calls.  Does that 
> sound good?
> 
> I'm not sure I can pull this off without having someone from 
> the power-management world throw a brick at me.

Just keep the error recovery callbacks for now, and we might be able to
provide a generic "helper" doing the watchdog thing (yes, there is a
watchdog in the net core)

Ben.


