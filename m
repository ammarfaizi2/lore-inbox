Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbSLaBjL>; Mon, 30 Dec 2002 20:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbSLaBjL>; Mon, 30 Dec 2002 20:39:11 -0500
Received: from havoc.daloft.com ([64.213.145.173]:26598 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267118AbSLaBjK>;
	Mon, 30 Dec 2002 20:39:10 -0500
Date: Mon, 30 Dec 2002 20:47:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Jaroslav Kysela <perex@suse.cz>,
       Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pnp & pci structure cleanups
Message-ID: <20021231014729.GB28152@gtf.org>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz> <20021230221212.GE32324@kroah.com> <1041289960.13684.180.camel@irongate.swansea.linux.org.uk> <20021230225012.GA19633@gtf.org> <20021230225134.GD814@kroah.com> <20021230231436.GA20810@gtf.org> <1041299426.13956.191.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041299426.13956.191.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2002 at 01:50:26AM +0000, Alan Cox wrote:
> Ok. Suggestion for how to handle this (not yet tried). Change the
> assumption about the end marker. Right now the end marker only uses the
> first fields and the user data happens to always be zero. If we change
> the pci matching code to interpret end markers with a non zero userdata
> as a pointer to the next table it all seems to come out in the wash,

I like it


> although there are some tricky details to consider - who frees up the
> extra tables on a module unload (if anyone), and how do we manage
> multiple modules with chains of tables (or do we just disallow that
> case). 

There will definitely be cases where people will want to black out
existing entries too.
Or would that open up to too much potential vendor abuse?  


> I think it also means we need to be able to go pci table -> owner ?

I don't really see why.  If you wanted to be terribly correct have
these things as refcounting kobjects or similar...  But really, with all
those other wonderfully unlocked PCI lists in the core, why starting
doing it The Right Way now?  ;-)

	Jeff




