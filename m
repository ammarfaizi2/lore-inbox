Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVCOBGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVCOBGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 20:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVCOBGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 20:06:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58821 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262184AbVCOBGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 20:06:45 -0500
Date: Mon, 14 Mar 2005 20:06:32 -0500
From: Dave Jones <davej@redhat.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: AGP module removal impossible ?
Message-ID: <20050315010631.GA8512@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <42361E33.4020903@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42361E33.4020903@ens-lyon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 12:28:51AM +0100, Brice Goglin wrote:
 > Hi Dave,
 > 
 > I can't remove the AGP chipset module on my boxes.
 > Looks like the AGP chipset driver holds a reference on itself and
 > thus makes removal impossible.
 > 
 > From what I understand, as soon as intel_agp is loaded, agp_intel_probe
 > is called. It gets a reference on intel_agp module through
 > !try_module_get(bridge->driver->owner) in agp_add_bridge.
 > Then this reference can only be released through module_put in
 > agp_remove_bridge which is called agp_intel_remove which is only called
 > when removing the module.
 > 
 > Thus it looks impossible to remove this module at all.
 > And I think the problem occurs with all other AGP chipset drivers.
 > 
 > I hope the reason is not just that module removal support is not important
 > in 2.6 :) It looks strange to implement a module removal routine if we
 > know it can't be used :)

The locking is screwed up and has been for some time.
I've been meaning to take a look at it for a while, but keep finding
more important things to do.  It should be fixed to lock/unlock when
the device is opened, as it was in 2.4

		Dave

