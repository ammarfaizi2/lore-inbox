Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUIXHdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUIXHdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 03:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUIXHdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 03:33:24 -0400
Received: from digitalimplant.org ([64.62.235.95]:47335 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S268533AbUIXHdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 03:33:20 -0400
Date: Fri, 24 Sep 2004 00:33:14 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: "Zhu, Yi" <yi.zhu@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend/resume support for driver requires an external firmware
In-Reply-To: <Pine.LNX.4.44.0409241405540.12384-100000@mazda.sh.intel.com>
Message-ID: <Pine.LNX.4.50.0409240029110.32015-100000@monsoon.he.net>
References: <Pine.LNX.4.44.0409241405540.12384-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Sep 2004, Zhu, Yi wrote:

> Choice 1. In 2.5 kernel, there used to be a ->save_state method in the
> device PM interface. From the "not yet updated" document
> (Documentation/power/pci.txt), this function can be used as "a notification
> that it(the device) may be entering a sleep state in the near future". If we
> take back this interface, the problem can be solved. That is, the driver
> loads firmware into memory in ->save_state and frees the memory in ->resume.
> The deadlock is resolved without any runtime memory wasted.
>
> patch embeded at the end of the mail.

We talked about this in Ottawa a few months ago, and I think this is the
right approach. Note though, that I think it needs to be more complete:

- There needs to be restore_state() to be symmetic.
- There needs to be the proper failure recovery
  If save_state() or suspend() fails, every device that has had their
  state saved needs to be restored.
- It needs to be called for all power management requests.
- The PCI implementation should call pci_save_state() in it, instead of in
  ->suspend().

It would be great if you could add these things. Otherwise, I'll add it to
my TODO list..

Thanks,


	Pat
