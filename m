Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVBBVpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVBBVpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVBBVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:42:04 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:25737 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262812AbVBBVhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:37:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=JoJI8NVPMD7z5BPLVi55Uz8Mx9BJjpK1jZhzAEuveiPP3vQfnFUWY7S43EYwM91/XJsOqbXntR//uPKj3FlZbwa92LcziY3cC9br3QK0SbddUhybByjhu+EZu+LaJmaij31k1u4igQjZ0c4EVkCE1W8XH99CLz5ydEvIAw3XJ08=
Message-ID: <58cb370e05020213371d308106@mail.gmail.com>
Date: Wed, 2 Feb 2005 22:37:19 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Patrick Gefre <pfg@sgi.com>
Subject: Re: [PATCH] Altix : ioc4 serial driver support
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx
In-Reply-To: <420139BF.4000100@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050103140938.GA20070@infradead.org>
	 <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com>
	 <20050201092335.GB28575@infradead.org> <420139BF.4000100@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2005 14:36:15 -0600, Patrick Gefre <pfg@sgi.com> wrote:
> Christoph Hellwig wrote:
> > Do you need to use ide_pci_register_driver?  IOC4 doesn't have the legacy
> > IDE problems, and it's never used together with such devices in a system,
> > so a plain pci_register_driver should do it.
> >
> 
> So ide_pci_register_driver is only for legacy devices with certain IDE
> problems - I think that is what you are saying (just trying to make sure
> I have it right) ??

ide_pci_register() is needed because of legacy ordering assumptions
(from BIOS and/or Windows) in case of many PCI IDE devices.  If there
is no possibility of other IDE PCI devices on your architecture it is safe to
call pci_register_driver() directly (see ide_scan_pcibus() in setup-pci.c).

BTW IDE part of the patch looks OK.

Thanks,
Bartlomiej
