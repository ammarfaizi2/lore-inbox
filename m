Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWECUhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWECUhr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWECUhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:37:47 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:14532 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750841AbWECUhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:37:46 -0400
Date: Wed, 3 May 2006 13:37:40 -0700
From: thockin@hockin.org
To: Tim Small <tim@buttersideup.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: Problems with EDAC coexisting with BIOS
Message-ID: <20060503203740.GA17515@hockin.org>
References: <C1989F6360C8E94B9645F0E4CF687C08C1E9FB@pgsmsx412.gar.corp.intel.com> <1145888979.29648.56.camel@localhost.localdomain> <4459119D.10905@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4459119D.10905@buttersideup.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 09:25:01PM +0100, Tim Small wrote:
> existing BIOSs, but the EDAC module could reprogram the chipset 
> error-signalling registers, so that an ECC error no longer triggers an 

This is key, I think.

> SMI.  The BIOS SMI handler could then read the signalling registers, and 
> leave the ECC registers well alone if ECC errors are not set to generate 
> an SMI.

The fundamental problem with SMI is that we CAN'T know what it is doing.
I've seen systems which trigger SMI from a GPIO toggled by a clock.  I've
seen systems trigger SMI from a chipset-internal periodic timer.  I've
seen chipsets route NMI->SMI or even MCE->SMI.  If the BIOS is polling the
error status registers from a periodic SMI, we're GOING to lose data.

The big hammer - turn off SMI - is probably OK on some systems, but is not
a general solution.  More and more hardware workarounds and features are
SMI based.  There are some rather interesting things that can be done in
SMM, *iff* we could get the BIOS out of the way.

Tim (watching EDAC from time to time, quietly)
