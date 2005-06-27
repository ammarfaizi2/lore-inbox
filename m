Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVF0XUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVF0XUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVF0XQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:16:11 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:40167 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261999AbVF0XM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:12:29 -0400
Date: Tue, 28 Jun 2005 01:14:30 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Message-ID: <20050627231430.GA8701@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Patrick Boettcher <pb@linuxtv.org>
References: <20050627120600.739151000@abc> <20050627121412.899787000@abc> <20050627155046.1c44bbdd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627155046.1c44bbdd.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.203.165
Subject: Re: [DVB patch 17/51] flexcop: add big endian register definitions
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Johannes Stezenbach <js@linuxtv.org> wrote:
> >
> > From: Patrick Boettcher <pb@linuxtv.org>
> > 
> > Add big-endian register definitions for running on a PowerPC.
> > (Thanks to Paavo Hartikainen for testing.)
> > 
> > ...
> > +	struct {
> > +		u32 dma_address0                   :30;
> > +		u32 dma_0No_update                 : 1;
> > +		u32 dma_0start                     : 1;
> > +	} dma_0x0;
> >...
> > +
> > +	struct {
> > +		u32 dma_0start                     : 1;
> > +		u32 dma_0No_update                 : 1;
> > +		u32 dma_address0                   :30;
> > +	} dma_0x0;
> 
> Oh dear.  This is a good demonstration of the downside of trying to use
> compiler bitfields to represent hardware registers.  I have vague memories
> of writing BFINS and BFEXT in 3c59x to stomp this problem.
> 
> I don't think there's any guarantee that the code you have there will work
> on all architectures/compiler versions btw.
> 
> Also...  The code appears to be assuming that BE architectures will
> bit-reverse their bitfields.  Is that right?  I'd expect them to only
> byte-reverse them?

Probably the code should use __BIG_ENDIAN_BITFIELD /
__LITTLE_ENDIAN_BITFIELD instead of __BIG_ENDIAN / __LITTLE_ENDIAN?
Anyway, the comment from the CVS commit suggests that it was tested.

I completely agree that this code is ugly as hell.
It was the obvious, simple fix to make the driver work on
PowerPC (and a few users happy), though. Rewriting the
driver not to use bitfields seems to be quite a bit of work.
Blame me for not paying enough attention when the initial
flexcop driver was submitted ;-(

Johannes
