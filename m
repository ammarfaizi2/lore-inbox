Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275291AbTHMSJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275293AbTHMSJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:09:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65034 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275291AbTHMSJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:09:34 -0400
Date: Wed, 13 Aug 2003 19:09:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, rddunlap@osdl.org, davej@redhat.com,
       willy@debian.org, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813190924.C20676@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, rddunlap@osdl.org,
	davej@redhat.com, willy@debian.org, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <20030813175009.GA12128@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030813175009.GA12128@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Aug 13, 2003 at 07:50:09PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 07:50:09PM +0200, Sam Ravnborg wrote:
> On Wed, Aug 13, 2003 at 10:31:51AM -0700, Greg KH wrote:
> > 
> > How about this patch?  If you like it I'll add the pci.h change to the
> > tree and let you take the tg3.c part.
> > 
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700) },
> Why not without the extra {}'s so something like this:

Take a moment to think about this (as it is currently):

#define CB_ID(vend,dev,type)                            \
        {                                               \
                .vendor         = vend,                 \
                .device         = dev,                  \
                .subvendor      = PCI_ANY_ID,           \
                .subdevice      = PCI_ANY_ID,           \
                .class          = PCI_CLASS_BRIDGE_CARDBUS << 8, \
                .class_mask     = ~0,                   \
                .driver_data    = CARDBUS_TYPE_##type,  \
        }

vs:

#define CB_ID(vend,dev,type)                            \
        {                                               \
                PCI_DEVICE(vend,dev),			\
                .class          = PCI_CLASS_BRIDGE_CARDBUS << 8, \
                .class_mask     = ~0,                   \
                .driver_data    = CARDBUS_TYPE_##type,  \
        }

and realise that you can't do the second if you include {} into
PCI_DEVICE.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

