Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269175AbUIHOHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbUIHOHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUIHNnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:43:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:60839 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268227AbUIHNmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:42:43 -0400
Subject: Re: [PATCH] missing pci_disable_device()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: greg@kroah.com, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <413E7925.1010801@jp.fujitsu.com>
References: <413D0E4E.1000200@jp.fujitsu.com>
	 <1094550581.9150.8.camel@localhost.localdomain>
	 <413E7925.1010801@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094647195.11723.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 13:39:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 04:14, Kenji Kaneshige wrote:
> > Think about unloading frame buffers or PCI devices with multiple
> > functions and multiple drivers. I agree the drivers definitely want
> > fixing where appropriate. I'm not sure your approach is safe (although a
> 
> I don't understand what you are worried about. Could you tell me
> what would be a problem with frame buffers or PCI devices with
> multiple functions?

If I have a framebuffer driver loaded for my video card in bitmap mode
all is well. If I unload it you then disable the video hardware even
though it would still be otherwise usable in text mode.

The same occurs when one PCI device has multiple functions (not PCI
functions but linux drivers using it). There are some examples of this
such as the CS5520 where one BAR is the IDE controller.

