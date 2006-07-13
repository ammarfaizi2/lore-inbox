Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWGMHs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWGMHs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWGMHs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:48:57 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:11725 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751507AbWGMHs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:48:56 -0400
Message-ID: <44B5FA31.9030309@s5r6.in-berlin.de>
Date: Thu, 13 Jul 2006 09:45:53 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: ralphc@pathscale.com
CC: David Miller <davem@davemloft.net>, rdreier@cisco.com, rolandd@cisco.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: Suggestions for how to remove bus_to_virt()
References: <1152746967.4572.263.camel@brick.pathscale.com>	<adar70quzwx.fsf@cisco.com> <20060712.174013.95062313.davem@davemloft.net>
In-Reply-To: <20060712.174013.95062313.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> If you need device level DMA mapping semantics, create them for your
> device type.  This is what USB does, btw.

Ralph,
two other examples where drivers provide some sort of address lookup are:

 - drivers/ieee1394/dma.[hc]
   AFAIK this deals with housekeeping of ringbuffers as used by
   1394 controllers for isochronous transmit and receive. Users of
   this little API are dv1394, video1394, ohci1394.

 - patch "dc395x: dynamically map scatter-gather for PIO" by
   Guennadi Liakhovetski,
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=cdb8c2a6d848deb9eeefffff42974478fbb51b8c
   This mapping is not specific to SCSI. The user is a driver which
   mixes PIO and DMA.

I don't know if these have any similarity to your requirements though.

(I too need to come up with either a portable replacement of bus_to_virt
or with a fundamentally different implementation but haven't started my
project yet. This occurrence of bus_to_virt is in drivers/ieee1394/sbp2
but #ifdef'd out by default.)
-- 
Stefan Richter
-=====-=-==- -=== -==--
http://arcgraph.de/sr/
