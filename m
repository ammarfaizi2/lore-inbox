Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271816AbTGXXJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271815AbTGXXJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:09:57 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:50330 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S271814AbTGXXJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:09:22 -0400
Date: Thu, 24 Jul 2003 19:14:21 -0400
From: Ben Collins <bcollins@debian.org>
To: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Firewire
Message-ID: <20030724231421.GQ1512@phunnypharm.org>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724230928.GB23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 04:09:29PM -0700, Chris Ruvolo wrote:
> On Thu, Jul 24, 2003 at 06:36:15PM -0400, Ben Collins wrote:
> > I know damn well that 2.6.0-test1 is not running r578 of the ohci1394
> > driver. In fact, that's 10 months old.
> 
> Er.. whoops.  Sorry, that was from my 2.4 boot.  Here's the right one.  This
> is at module load time.  The rest of the data is correct.
> 
> -Chris
> 
> 
> ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>                         
> PCI: Found IRQ 10 for device 0000:00:0b.0
> ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[db001000-db0017ff]  Max Packet=[2048]
> raw1394: /dev/raw1394 device initialized
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc00160 ffc00000 00000000 60f30404                         
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc00560 ffc00000 00000000 60f30404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc00960 ffc00000 00000000 60f30404
> ieee1394: ConfigROM quadlet transaction error for node 00:1023
 
That's more like it, thanks.


I've seen this before, but I can never reproduce it. Not with i386, nor
with sparc64, and not running 2.4 or 2.6. I know what is happening
though. The response packet is getting processed before the status
packet (IOW, the ack for your request is getting back after the actual
response to your request).

Not sure how that is possible, but I suspect it's just a bit of logic
that needs to be applied, or queue the replies waiting for the ack.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
