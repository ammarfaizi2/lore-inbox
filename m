Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWGSJIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWGSJIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 05:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWGSJIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 05:08:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:44761 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964771AbWGSJIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 05:08:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=jOHkKsfIKp37oTXB0sKUxbG8/7PLvoAS27inMISseW1X/MfVhVGC7PtheTshlgW/zen4MyRw5ZrOb1KgFyUf+6h8ciUqxZIzUDLv2DqFWJekASHmMcvI2naTQSw1EWLbSA+j8DNdiumJ+/LCn7UxLONUfha2ixqPiRB9dS51VVY=
Message-ID: <44BDF68D.9040104@gmail.com>
Date: Wed, 19 Jul 2006 11:08:06 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nils Faerber <nils@kernelconcepts.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] Watchdog: i8xx_tco remove pci_find_device
References: <20060719002225.85BFC201A1@srebbe.iguana.be> <20060719061154.GA2438@infomag.infomag.iguana.be>
In-Reply-To: <20060719061154.GA2438@infomag.infomag.iguana.be>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim Van Sebroeck napsal(a):
> Hi Jiri,

Hi Wim.

> 
> Just back from a small holiday, but:
> 
>> Watchdog: i8xx_tco remove pci_find_device.
>>
>> Use refcounting for pci device obtaining. Use PCI_DEVICE macro.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> Why the pci_dev_put's? We aren't registering the PCI devices. See
> the comment above the MODULE_DEVICE_TABLE:
> /*
>  * Data for PCI driver interface
>  *
>  * This data only exists for exporting the supported
>  * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
>  * register a pci_driver, because someone else might one day
>  * want to register another driver on the same PCI id.
>  */

Sure, but it's not registering, but telling the subsystem, we use the device, so
that user can't hotunplug it since some driver uses it and reads and writes its
registers. It's purpose of refcounting in pci_dev_{put,get}() (pci_dev_get is
called in pci_get_device()).

> Since the I/O controller Hub has several functions we explicitely
> do not register the PCI device...
> 
> PS: In the -mm tree there is allready a replacement for this driver...
> Plan is to get this one into linus tree soon.

This patch is against 2.6.18-rc1-mm2. (Maybe you mean there are some patches
coming to -rc2-mm1?)

thanks,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
