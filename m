Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135891AbRDYQSZ>; Wed, 25 Apr 2001 12:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135895AbRDYQSP>; Wed, 25 Apr 2001 12:18:15 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:50723 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135892AbRDYQSD>; Wed, 25 Apr 2001 12:18:03 -0400
Message-ID: <3AE6F884.6D68304D@redhat.com>
Date: Wed, 25 Apr 2001 12:17:08 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Biardzki <cbi@cebis.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: SCSI-Multipath driver for 2.4?
In-Reply-To: <Pine.LNX.4.21.0104251311420.25506-100000@ameise.opto.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Biardzki wrote:
> 
> Hi,
> 
> I wondered whether thera are already effrots to por the Multipath-driver
> for FibreChannel (http://t3.linuxcare.org) to the 2.4 kernel? This patch
> allows a transparent failover to another path to FC-attached
> disk in case the primary path fails.

When we reviewed the code, we didn't like it all that much.  It served it's
purpose on the t3 stuff from Sun, but it wasn't generic enough to suit our
tastes.  So, Ingo wrote a multipath RAID extension as part of the MD driver
and that's in our 7.1 product and will be sent to the mainstream kernel as
soon as it's gotten enough testing to be deemed finished (for instance, there
are horribly stupid devices out there that support what is called
"Active-Passive" multipath, where if you write to the passive path, it makes
the active path error out, which makes the device 100% useless for
multi-initiator, shared SCSI/FC environments, and makes the device total junk
in my opinion, but if we are going to support them in a Multipath setup, then
the multipath driver has to be modified so it doesn't attempt to touch passive
paths until the active path has already failed, which it doesn't currently
attempt to do when writing superblocks or reading partition tables).

> Is there any documentation about the changes in the SCSI-driver interfaces
> from 2.2 -> 2.4 (eg. in sd.c) ?


-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
