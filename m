Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUBPMRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 07:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUBPMRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 07:17:13 -0500
Received: from p508155B0.dip.t-dialin.net ([80.129.85.176]:56193 "EHLO
	o.ww.redhat.com") by vger.kernel.org with ESMTP id S264245AbUBPMRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 07:17:11 -0500
Date: Mon, 16 Feb 2004 13:17:09 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       Linux Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: dm core patches
Message-ID: <20040216121709.GA15372@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <20040210163548.GC27507@reti> <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti> <20040212185145.GY21298@marowsky-bree.de> <20040212201340.GB1898@reti> <20040213151213.GR21298@marowsky-bree.de> <20040213153936.GF15736@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213153936.GF15736@reti>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 03:39:36PM +0000, Joe Thornber wrote:
> On Fri, Feb 13, 2004 at 04:12:14PM +0100, Lars Marowsky-Bree wrote:
> > On 2004-02-12T20:13:40,
> >    Joe Thornber <thornber@redhat.com> said:
> > 
> > > I think the main concern now is over the testing of paths.  Sending an
> > > io down an inactive path can be very expensive for some hardware
> > > configurations.  So I'm considering changing a couple of things:
> > > 
> > > - Only ever send io to 1 priority group at a time (even test ios).
> > >   To test the lower priority groups we'd have to periodically switch to
> > >   them and use them for a bit for both test io and proper io.
> > 
> > You are missing the obvious answer:
> > 
> > - Periodically checking paths is a user-space issue and doesn't belong
> >   into the kernel. User-space gets to handle this policy.
> 
> Yes, that is obvious, I had wanted to do failback automatically.  But
> pushing it to userland does allow people to write hardware specific
> tests.  I'll try it and see what people think.

Right, such policy belongs to userpsace it seems.

The reason why I put it into the multipath target is to cover the case,
where all paths are inoperational, the system is OOM _and_ the only
chance to recover from that is the hope to unfail a path in order to
release memory preasure.

'Sorry, userspace test handler can't run, your enterprise server
is a pile of sh..' is not acceptable in case there's a path we
could unfail IMO.

Regards,
Heinz    -- The LVM Guy --


> 
> Thanks,
> 
> - Joe
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat, Inc.
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
