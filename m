Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVCISJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVCISJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVCISJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:09:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42187 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262154AbVCISGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:06:38 -0500
Date: Wed, 9 Mar 2005 10:53:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Gustav Lidberg <gustavl@home.se>,
       Michael Elizabeth Chastain <mec@shout.net>
Cc: linux-kernel@vger.kernel.org, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: make menuconfig creates erronous config for 386
Message-ID: <20050309135309.GA15110@logos.cnet>
References: <422F04F7.1020701@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422F04F7.1020701@home.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wed, Mar 09, 2005 at 03:15:19PM +0100, Gustav Lidberg wrote:
> Hi
> 
> There is a bug in "make menuconfig". If one chooses 386 or 486 for cpu
> type, CONFIG_X86_TSC=y is set in .config. This creates a kernel that is
> unbootable on 386. Testing shows that it worked in 2.4.19, but is broken
> from 2.4.20 onwards. Someone should definetely look into this.
> (I'm not subscribed to lkml)

Quoting Mikael Pettersson, from
http://marc.theaimsgroup.com/?l=linux-kernel&m=109986177309630&w=2

"Do a 'make oldconfig' after switching CPU type from a
TSC-capable one to a TSC-less one in 2.4 kernels. There
is a known bug in the old configuration system where it
can leave derived options in an inconsistent state after
a single round of option changes. CONFIG_X86_TSC is the
prime example of this. Doing a second configuration round
allows the derived options to reach a fixpoint."

Note that arch/i386/defconfig contains CONFIG_X86_TSC=y.

Michael, Mikael, what are the possibilities for fixing this
Configure limitation?

In the meantime, I wonder if arch/i386/defconfig should be 
changed to contain "CONFIG_X86_TSC=n" instead of "=y" to make 
life easier for 386/486 users who use "make menuconfig" without 
pre-existing .config files.

This should have been fixed ages ago. :(
