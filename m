Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbTIDJsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbTIDJsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:48:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59405 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261520AbTIDJsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:48:06 -0400
Date: Thu, 4 Sep 2003 10:48:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904104801.A7387@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Paul Mackerras <paulus@samba.org>, hch@lst.de,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk> <16215.1054.262782.866063@nanango.paulus.ozlabs.org> <20030904023624.592f1601.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904023624.592f1601.davem@redhat.com>; from davem@redhat.com on Thu, Sep 04, 2003 at 02:36:24AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 02:36:24AM -0700, David S. Miller wrote:
> On Thu, 4 Sep 2003 19:21:34 +1000 (EST)
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > What I would prefer is if we passed a struct device pointer, a
> > resource pointer and an offset to ioremap.  Then we could just have
> > bus addresses in PCI device resources instead of having to translate
> > them into physical addresses.
> 
> You only need a resource in order to do this.  Then you can
> stick the upper bits, controller number, whatever in the unused
> resource flag bits.

Using the high flag bits probably isn't a good idea for two reasons:

1. We already use bit 31 to indicate the busy status:

   #define IORESOURCE_BUSY         0x80000000      /* Driver has marked this resource busy */

   However, it looks like bits 27 to 17 are currently unused.

2. The resource tree won't know about the upper bits or whatever sitting
   in flags, and as such identical addresses on two different buses will
   clash.

Resource start,end needs to be some unique quantity no matter which (PCI)
bus you are on.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

