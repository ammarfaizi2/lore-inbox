Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbTCJRWc>; Mon, 10 Mar 2003 12:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTCJRWb>; Mon, 10 Mar 2003 12:22:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:1811 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261374AbTCJRVp>;
	Mon, 10 Mar 2003 12:21:45 -0500
Date: Mon, 10 Mar 2003 09:21:55 -0800
From: Greg KH <greg@kroah.com>
To: Ben Collins <bcollins@debian.org>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Device removal callback
Message-ID: <20030310172155.GA9792@kroah.com>
References: <20030310010232.GB16134@phunnypharm.org> <Pine.LNX.4.33.0303100949490.1002-100000@localhost.localdomain> <20030310165548.GA753@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310165548.GA753@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 11:55:48AM -0500, Ben Collins wrote:
> > I much prefer this, as I would like to see it eventually, but I'd rather
> > see the implications worked out before it's generalized.
> 
> Then I have to be concerned about parts of the driver model removing
> parents of my devices without my knowing it. Didn't PCI already go
> through this problem with bus's being removed?

Not that I know of, no.  The PCI core knows when it is removing busses,
as it is the one doing this.

> If my PCI devices gets removed, it simply calls my PCI callbacks, but
> then my PCI drivers have to link into the core and call remove on all
> the host devices, then node devices, then unit directories.

Um, don't you have to do this already today, if someone unloads your pci
driver?  I don't see what the driver core has to do with that.

> I'm not sure what the problem is in allowing the bus driver to know when
> a device is about to be removed for some reason. At the very least it
> makes for a good sanity check mechanism.

As the bus driver was the one who asked for the device to go away in the
first place, why isn't this just extra information?

Still confused,

greg k-h
