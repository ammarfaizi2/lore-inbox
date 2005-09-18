Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVIRFXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVIRFXH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 01:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVIRFXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 01:23:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:13060 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751087AbVIRFXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 01:23:06 -0400
Date: Sun, 18 Sep 2005 07:23:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Eradic disk access during reads
Message-ID: <20050918052301.GA20422@alpha.home.local>
References: <200509170717.03439.a1426z@gawab.com> <200509171323.53054.a1426z@gawab.com> <20050917184643.GA1313@alpha.home.local> <200509180716.46978.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509180716.46978.a1426z@gawab.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 07:16:46AM +0300, Al Boldi wrote:
> Willy Tarreau wrote:
> > On Sat, Sep 17, 2005 at 01:32:53PM +0300, Al Boldi wrote:
> > > Willy Tarreau wrote:
> > > > On Sat, Sep 17, 2005 at 07:26:11AM +0300, Al Boldi wrote:
> > > > > Monitoring disk access using gkrellm, I noticed that a command like
> > > > >
> > > > > cat /dev/hda > /dev/null
> > > > >
> > > > > shows eradic disk reads ranging from 0 to 80MB/s on an otherwise
> > > > > idle system.
> 
> New synonym: eradic=erratic :)

I've noticed from the first mail too :-)

> > Denis' tool seems clearly more suited to analyse your problem.
> 
> The problem seems to be a multi-access collision in the queue, which forces a 
> ~50% reduction of thruput, which recovers with another multi-access 
> collision.  Maybe?!

do you have anything else connected to the same controller ? I've encountered
a problem a long time ago with SATA drives (it was around 2.4.25, with the
beginning of SATA support), where I could not use RAID on my drives because
simultaneous accesses to the drives was not possible. I then realized that
every time I accessed a drive during a read from or a write to another one
would stall. I don't remember if CDROM access caused the same trouble. This
was with a SATA-patched ata-piix driver, but fortunately this is fixed by now.

Regards,
Willy

