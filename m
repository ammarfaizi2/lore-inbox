Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbUCPQQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUCPQP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:15:57 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:8328 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263624AbUCPQOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:14:19 -0500
Date: Tue, 16 Mar 2004 16:13:00 +0000
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [3C509] Fix sysfs leak.
Message-ID: <20040316161300.GC17958@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, akpm@osdl.org
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk> <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org> <20040316134613.GA15600@redhat.com> <405725F2.7090701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405725F2.7090701@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 11:06:10AM -0500, Jeff Garzik wrote:
 > Dave Jones wrote:
 > >On Tue, Mar 16, 2004 at 11:56:37AM +0100, Marc Zyngier wrote:
 > > > >>>>> "davej" == davej  <davej@redhat.com> writes:
 > > > 
 > > > davej>  #ifdef CONFIG_EISA
 > > > davej> -	if (eisa_driver_register (&el3_eisa_driver) < 0) {
 > > > davej> +	if (eisa_driver_register (&el3_eisa_driver) <= 0) {
 > > > davej>  		eisa_driver_unregister (&el3_eisa_driver);
 > > > davej>  	}
 > > > davej>  #endif
 > > > 
 > > > This is bogus. eisa_driver_register returns 0 when it *succeeds*.
 > >
 > >Then the probing routine is bogus, it returns 0 when it fails too.
 > 
 > No, for the hotplug case the API allows registration to succeed, then 
 > probing calls the ->init_one function later.

Not when the module buggers off afterwards it doesn't.
->init_one points to lala land at that point.

		Dave

