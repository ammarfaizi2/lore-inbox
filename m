Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWCGRbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWCGRbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCGRbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:31:41 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:27325 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751265AbWCGRbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:31:40 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: initcall at ... returned with error code -19 (Was: Re: 2.6.16-rc5-mm2)
Date: Tue, 7 Mar 2006 10:31:32 -0700
User-Agent: KMail/1.8.3
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
References: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com> <20060306170919.0fcd8566.pj@sgi.com> <yq0veuq2yeu.fsf@jaguar.mkp.net>
In-Reply-To: <yq0veuq2yeu.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071031.32558.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 06:10, Jes Sorensen wrote:
> >>>>> "Paul" == Paul Jackson <pj@sgi.com> writes:
> Paul> Andrew wrote:
> >> That's OK - it's -ENODEV.
> 
> Paul> I can't help but wonder if the particular case of -ENODEV should
> Paul> be kept quiet, as in the following totally untested patch:
> 
> I'd subscribe to that. It seems a bit wrong to return 0 in a
> loadable module if nothing is found, and some of the ones people have
> posted patches for converting can be either modules or static.

Yeah, maybe.  But it feels a little like the question of whether
{pci,pnp,acpi_bus}_register_driver() should return the number of
devices found.  The consensus is that these functions should return
only a negative error, or zero for success, leaving any counting of
devices to the driver's .probe() or .add() method.

I think a loadable driver's init function *should* return success
even if no device is yet present.  Maybe you want to load the driver
before hot-adding the device.

The common idiom of, e.g.,

    static int __init serial8250_pci_init(void)
    {
        return pci_register_driver(&serial_pci_driver);
    }

should remain acceptable, though it returns 0 even if no devices
are found.

Bjorn
