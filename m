Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVDEQV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVDEQV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDEQU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:20:26 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:44635 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261796AbVDEQUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:20:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Qar1kkLIqRXGGmOkKAXqGG8hvgS4oPvFv3v+PuicEMb8a6ER07F7gOX0tbODXkVJW+Q3wPBlqWbtXGTRfVYri/gjk5Fjxlv18alMP99Vt39quHD9fseQn9Z07BXBy8xUU59GL5zFxixV4P45ozffR29v2qR2GeaRx93+JFUT3tU=
Message-ID: <d120d50005040509205a6d6b4a@mail.gmail.com>
Date: Tue, 5 Apr 2005 11:20:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Marcel Holtmann <marcel@holtmann.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
In-Reply-To: <20050405114543.GG10171@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050404100929.GA23921@pegasos> <20050404191745.GB12141@kroah.com>
	 <20050405042329.GA10171@delft.aura.cs.cmu.edu>
	 <200504042351.22099.dtor_core@ameritech.net>
	 <1112692926.8263.125.camel@pegasus>
	 <20050405114543.GG10171@delft.aura.cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 5, 2005 6:45 AM, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> On Tue, Apr 05, 2005 at 11:22:06AM +0200, Marcel Holtmann wrote:
> > I agree with Dmitry on this point. The IHEX parser should not be inside
> > firmware_class.c. What about using keyspan_ihex.[ch] for it?
> 
> That's what I had originally, actually called firmware_ihex.ko, since
> the IHEX format parser is not in any way keyspan specific and there are
> several usb-serial converters that seem to use the same IHEX->.h trick
> which could trivially be modified to use this loader.
> 
> But the compiled parser fairly small (< 2KB) and adding it to the
> existing module didn't effectively add any size to the firmware_class
> module since things are rounded to a page boundary anyways.
> 

It is not about the size, it is about source separation. Since it has
nothing to do with actualy loading of a BLOB from userspace to kernel
space I'd put it into lib/, like crc functions, etc. It does not
really have to work with "struct firmware *", "void *data, size_t len"
should be just as useable.

-- 
Dmitry
