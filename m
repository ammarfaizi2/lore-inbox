Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTFJPgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTFJPdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:33:46 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:1469
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263281AbTFJPdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:33:15 -0400
Date: Tue, 10 Jun 2003 11:46:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xirc2ps_cs update
Message-ID: <20030610154655.GA1959@gtf.org>
References: <200306101524.15648.daniel.ritz@gmx.ch> <Pine.LNX.4.44.0306101731200.10841-100000@petra.hos.u-szeged.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306101731200.10841-100000@petra.hos.u-szeged.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 05:35:18PM +0200, Geller Sandor wrote:
> On Tue, 10 Jun 2003, Daniel Ritz wrote:
> 
> > -    busy_loop(HZ/25);		     /* wait 40 msec */
> > +    Wait(HZ/25);		     /* wait 40 msec */
> 
> Why not Wait(40); instead Wait(HZ/25) ? Currently HZ is 1000. However, the
> value can change - as it changed from 100 to 1000.

True enough...  the best solution is to grep the tree for a
msecs_to_jiffies macro, and use that.  Then it will look like

	Wait(msecs_to_jiffies(40))

and the macro does the proper scaling versus constant HZ.

	Jeff



