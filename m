Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTLVJiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 04:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTLVJiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 04:38:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:26028 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264372AbTLVJiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 04:38:02 -0500
Date: Mon, 22 Dec 2003 01:37:59 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Manuel Estrada Sainz <ranty@debian.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource dealloocation problems
Message-ID: <20031222093759.GB30235@kroah.com>
References: <200312210137.41343.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312210137.41343.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 01:37:39AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> It seems that implementation of the firmware loader is racy as it relies
> on kobject hotplug handler. Unfortunately that handler runs too early,
> before firmware class attributes controlling the loading process, are
> created. This causes firmware loading fail at least half of the times on
> my laptop.

Um, why not have your script wait until the files are present?  That
will remove any race conditions you will have.

> Another problem that I see is that the present implementation tries to free
> some of the allocated resources manually instead of relying on driver model.
> Particularly damaging is freeing fw_priv in request_firmware. Although the
> code calls fw_remove_class_device (which in turns calls 
> class_device_unregister) the freeing of class device and all its attributes
> can be delayed as the attribute files may still be held open by the
> userspace handler or any other program. Subsequent access to these files
> could cause trouble.

Cleanups should happen in the release function.  If the firmware code
doesn't do this, it's wrong.

thanks,

greg k-h
