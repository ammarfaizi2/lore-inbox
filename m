Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVF1Gon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVF1Gon (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVF1GoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:44:21 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:15295 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262023AbVF1GlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:41:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: pcmcia: release_class patch concern
Date: Tue, 28 Jun 2005 01:41:00 -0500
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pcmcia@lists.infradead.org
References: <200506272356.50029.dtor_core@ameritech.net> <20050628061400.GA9019@isilmar.linta.de>
In-Reply-To: <20050628061400.GA9019@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506280141.01223.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 June 2005 01:14, Dominik Brodowski wrote:
> Hi Dmitry,
> 
> On Mon, Jun 27, 2005 at 11:56:49PM -0500, Dmitry Torokhov wrote:
> > Hi Dominik,
> > 
> > I noticed that Linus committed the patch from you that introduces waiting
> > for completion in module's exit routine. I believe it is a big no-no
> 
> Is it really? Any PCI driver which calls pci_unregister_driver() waits for
> completion (-> driver_unregister() -> wait_for_completion(&drv->unloaded) ).
>

Driver objects don't linger around - teardown is straightforward and
attribute access protected with bumping up module's reference count.
So it usually works out pretty well. 

> 
> > as something like this will wedge the kernel:
> > 
> > 	rmmod <module> < /sys/path/to/devices/attribute
> 
> Why would anybody issue such a command?

This is just the simpliest method to illustrate the problem. I am sure
someone could come up with a more realistic example. I think Al Viro
mentioned it some time ago, but I can't find his post...

> But it even wouldn't succeed, as 
> the module usage count would be >0 if there are attributes below
> /sys/class/pcmcia_socket/
...
> So I could have left the other wait_for_completion out, as it should never
> actually _wait_. Nonethteless, I consider it to be a safeguard.

Since the completion will never be actually used I'd rather not have it
at all - I believe it sets bad example.
 
-- 
Dmitry
