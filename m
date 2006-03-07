Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWCGRga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWCGRga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWCGRga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:36:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40386 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751389AbWCGRg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:36:29 -0500
Message-ID: <440DC353.8080101@sgi.com>
Date: Tue, 07 Mar 2006 18:30:59 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20051027)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: initcall at ... returned with error code -19 (Was: Re: 2.6.16-rc5-mm2)
References: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com> <20060306170919.0fcd8566.pj@sgi.com> <yq0veuq2yeu.fsf@jaguar.mkp.net> <200603071031.32558.bjorn.helgaas@hp.com>
In-Reply-To: <200603071031.32558.bjorn.helgaas@hp.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> On Tuesday 07 March 2006 06:10, Jes Sorensen wrote:
>> I'd subscribe to that. It seems a bit wrong to return 0 in a
>> loadable module if nothing is found, and some of the ones people have
>> posted patches for converting can be either modules or static.
> 
> Yeah, maybe.  But it feels a little like the question of whether
> {pci,pnp,acpi_bus}_register_driver() should return the number of
> devices found.  The consensus is that these functions should return
> only a negative error, or zero for success, leaving any counting of
> devices to the driver's .probe() or .add() method.
> 
> I think a loadable driver's init function *should* return success
> even if no device is yet present.  Maybe you want to load the driver
> before hot-adding the device.

I don't really like this ;-( If a driver is loaded for a specific PCI
device and that isn't present, then IMHO it is better to have it
return -ENODEV and unload it again.

Cheers,
Jes
