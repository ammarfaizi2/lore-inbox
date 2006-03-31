Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWCaRDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWCaRDe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCaRDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:03:34 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18409 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751033AbWCaRDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:03:33 -0500
Date: Fri, 31 Mar 2006 11:03:19 -0600
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during reset.
Message-ID: <20060331170319.GV2172@austin.ibm.com>
References: <20060330213928.GQ2172@austin.ibm.com> <20060331000208.GS2172@austin.ibm.com> <442C8069.507@wolfmountaingroup.com> <20060331003506.GU2172@austin.ibm.com> <442CACC0.1060308@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442CACC0.1060308@wolfmountaingroup.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 09:14:56PM -0700, Jeffrey V. Merkey wrote:
> Yes, we need one. The adapter needs to maintain these stats from the
> registers in the kernel structure and not
> its own local variables. 

Did you read the code to see what the adapter does with these stats? 
Among other things, it uses them to adaptively modulate transmit rates 
to avoid collisions. Just clearing the hardware-private stats will mess
up that function.

> That way, when someone calls to clear the stats
> for testing and analysis purposes,
> they zero out and are reset.

1) ifdown/ifup is guarenteed to to clear things. Try that.

2) What's wrong with taking deltas? Typical through-put performance
measurement is done by pre-loading the pipes (i.e. running for
a few minutes wihtout measuring, then starting the measurement).
I'd think that snapshotting the numbers would be easier, and is 
trivially doable in user-space. I guess I don't understand why 
you need a new kernel featre to imlement this.

--linas
