Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVFBWYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVFBWYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFBWYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:24:08 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:28140 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261432AbVFBWYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:24:02 -0400
Date: Fri, 3 Jun 2005 00:24:00 +0200
From: castet.matthieu@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re:PNP parallel&serial ports: module reload fails (2.6.11)?
Message-ID: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net>
Reply-To: 429CECE3.1060904@tls.msk.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

try pnpacpi=off in your kernel options and it should work.
An other solution is to comment pnpacpi_disable_resources in
drivers/pnp/pnpacpi/core.c in order to avoid that the resource are
disable.


When booting, the parport resources are enable by your kernel, and when
you load for the first time the module there nothing to activate.

But when you rmmod the driver, you free the resource.

And pnpacpi have some problem to activate resource with some strange acpi implementation...

There was a problem in pnp layer implementation : the resource weren't
given in the right order, Adam Belay send me a patch, but I don't know
if it got in main-line ?

May be there also a bug in pnpacpi_encode_resources (with the pnp patch
apply I didn't still work on some hardware...)

You can try to send your dsdt, but I am quit busy for the moment.
May be some Intel guy could look at the problem...


Matthieu
