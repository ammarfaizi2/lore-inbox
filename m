Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131627AbRCOC7A>; Wed, 14 Mar 2001 21:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131624AbRCOC6v>; Wed, 14 Mar 2001 21:58:51 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:27071 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131622AbRCOC6h>; Wed, 14 Mar 2001 21:58:37 -0500
Message-ID: <3AB030F6.246C6F23@redhat.com>
Date: Wed, 14 Mar 2001 22:03:18 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <20010314213543.A30816@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > Date: Wed, 14 Mar 2001 21:28:14 -0500
> > From: Doug Ledford <dledford@redhat.com>
> 
> > A bug report I was charged with fixing (qla2x00 driver doesn't see all luns or
> > sees multiple identical luns in different scenarios) was not a bug in the
> > qla2x00 driver.  [...]
> >  The bug is that we were detecting offline devices and linking
> > them into the device list.
> 
> Why is this a bug? What would happen when I telnet into the
> the RAID box and enable my volumes on those LUNs?

Then they would be legitimate devices and you would do:

echo "scsi-add-single-device a b c d" > /proc/scsi/scsi

to add them to the device chain.  Before then, they aren't anything (at least
not in the case of the Clariion array).

> >  But, some devices (at least the Clariion raid
> > chassis) report luns that don't currently have any device bound to them as
> > present but offline.  This meant if we truly scanned all luns then we got
> > something like 100+ devices on one ID from this chassis when only 1 might be
> > valid:-(
> 
> 16384 LUNs for Fibre Channel. As you see, scanning is out of the
> question. You must issue REPORT LUNs and fall back on scanning
> if the device reports a check condition. I did that when I worked
> in Sun Storage with A5000/A3500/T3 arrays couple of years ago.

Patches welcomed.  The one I sent already works on a fiber channel setup (the
qla2x00 in question is fc and so is the Clariion array it's connected to, no
detrimental side effects from scanning the box) and so I'm not inclined to add
a REPORT LUNs section to the code unless absolutely necessary.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
