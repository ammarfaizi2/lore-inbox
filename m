Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSLGTsv>; Sat, 7 Dec 2002 14:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbSLGTsv>; Sat, 7 Dec 2002 14:48:51 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:37775 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264730AbSLGTsu>;
	Sat, 7 Dec 2002 14:48:50 -0500
Date: Sat, 7 Dec 2002 14:57:53 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>, Zwane Mwaikambo <zwane@holomorphy.com>
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, pelaufer@adelphia.net
Subject: Re: [PATCH] Linux PnP Support V0.93 - 2.5.50
Message-ID: <20021207145753.GQ333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Greg KH <greg@kroah.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>, perex@suse.cz,
	linux-kernel@vger.kernel.org, pelaufer@adelphia.net
References: <20021201143221.GC333@neo.rr.com> <Pine.LNX.4.50.0212071322230.3130-100000@montezuma.mastecende.com> <20021207192203.GB16559@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207192203.GB16559@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 11:22:04AM -0800, Greg KH wrote:
> On Sat, Dec 07, 2002 at 01:24:29PM -0500, Zwane Mwaikambo wrote:
> > On Sun, 1 Dec 2002, Adam Belay wrote:
> > 
> > > Attached is a patch, gzipped for size, that updates the 2.5.50 to the latest pnp
> > > version.  It includes all 9 of the previously submitted patches.
> > >
> > > Highlights are as follows:
> > > -PnP BIOS fixes
> > > -Several new macros
> > > -PnP Card Services
> > > -Various bug fixes
> > > -more drivers converted to the new APIs
> > >
> > > PnP developers please use this patch.
> > 
> > Could we get a void* in pnp_dev? I'm finding myself resorting to
> > driver internal arrays in order to track locations of device private structures.
> 
> Use the struct device void pointer for stuff like this.  There's some
> helpful functions to get access to this easily (but don't seem to see
> them in pnp.h at first glance...)


Yes, there are helper functions for this, they can all be found in pnp.h.

static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
{
	return dev_get_drvdata(&pdev->dev);
}

static inline void pnp_set_drvdata (struct pnp_dev *pdev, void *data)
{
	dev_set_drvdata(&pdev->dev, data);
}

static inline void *pnpc_get_drvdata (struct pnp_card *pcard)
{
	return dev_get_drvdata(&pcard->dev);
}

static inline void pnpc_set_drvdata (struct pnp_card *pcard, void *data)
{
	dev_set_drvdata(&pcard->dev, data);
}

thanks,
Adam
