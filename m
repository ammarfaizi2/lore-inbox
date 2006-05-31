Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWEaVG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWEaVG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWEaVG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:06:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:6633 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965003AbWEaVG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:06:28 -0400
Date: Wed, 31 May 2006 16:00:53 -0500
To: Brice Goglin <brice@myri.com>
Cc: Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, tom.l.nguyen@intel.com, rajesh.shah@intel.com
Subject: Re: [RFC]disable msi mode in pci_disable_device
Message-ID: <20060531210053.GE6364@austin.ibm.com>
References: <1148612307.32046.132.camel@sli10-desk.sh.intel.com> <20060526125440.0897aef5.akpm@osdl.org> <44776491.1080506@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44776491.1080506@myri.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:26:57PM +0200, Brice Goglin wrote:
> Andrew Morton wrote:
> >> In
> >> his usage, pci_save_state will be called at runtime, and later (after
> >> the device operates for some time and has an error) pci_restore_state
> >> will be called.
> >
> > Is that a sane thing for a driver to be doing? (Not relevant to this issue
> > though).
> 
> The aim is to be able to recover from a memory parity error in the NIC.
> Such errors happen sometimes, especially when a cosmic ray comes by. To
> recover, we restore the state that we saved at the end of the
> initialization. As saving currently disables MSI, we currently have to
> restore the state right after saving it at the end of the initialization
> (see the end of
> myri10ge_probe in http://lkml.org/lkml/2006/5/23/24).

My experience dealing with a similar thing suggests that its usually
easier to restore the state to where it was after a cold boot, but
before the device driver touched the h/w.  

--linas

