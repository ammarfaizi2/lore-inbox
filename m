Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUCPOuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUCPOtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:49:11 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:51333 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261931AbUCPObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:31:20 -0500
Date: Tue, 16 Mar 2004 14:29:51 +0000
From: Dave Jones <davej@redhat.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Message-ID: <20040316142951.GA17958@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk> <wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org> <20040316134613.GA15600@redhat.com> <wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 03:09:49PM +0100, Marc Zyngier wrote:
 > >>>>> "Dave" == Dave Jones <davej@redhat.com> writes:
 > 
 > Dave> Then the probing routine is bogus, it returns 0 when it fails too.
 > 
 > Uh ? el3_eisa_probe looks like it properly returns an error...
 > 
 > Or maybe you call a failure not finding a proper device on the bus ?

The damned bus doesn't even exist. If this is a case that couldn't be
detected, I'd not be complaining, but this is just nonsense having
a driver claim that its found an EISA device, when there aren't even
any EISA slots on the board.

 > When the driver registers, the bus may not have been probed yet
 > (built-in case). So un-registering the driver when it fails to find a
 > proper device is simply wrong with the current implementation.

This happens long after bus initialisation should have already figured
out that the bus doesn't exist. Even if it was left this late, the
eisa registration code should be doing a 'oh, I've not even checked
if I have a bus yet, I'll do it now' before it starts doing completely
bogus things like checking for devices.

The way I see it, EISA bus support is completely horked right now.

		Dave

