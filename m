Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751034AbWFEMJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWFEMJx (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWFEMJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:09:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:9167 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751033AbWFEMJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:09:53 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44841E8B.7070608@s5r6.in-berlin.de>
Date: Mon, 05 Jun 2006 14:07:39 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: Arjan van de Ven <arjan@linux.intel.com>, Jiri Slaby <jirislaby@gmail.com>,
        Ben Collins <bcollins@ubuntu.com>,
        Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>,
        =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Subject: Re: [PATCH 2.6.17-rc5-mm3] ieee1394: hl_irqs_lock is taken in hardware
 interrupt context
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447F0905.8020600@gmail.com> <1149176945.3115.70.camel@laptopd505.fenrus.org> <1149179744.4533.205.camel@grayson> <tkrat.02c63cb007e86f12@s5r6.in-berlin.de>
In-Reply-To: <tkrat.02c63cb007e86f12@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> ohci1394 and pcilynx call highlevel_host_reset from their hardware
> interrupt handler (via hpsb_selfid_complete).

By the way, the hl->host_reset() handlers should be audited WRT 
possibilities to offload parts of them into tasklets, workqueues etc..

bad:
	csr.c::host_reset() ->
	http://bugzilla.kernel.org/show_bug.cgi?id=6070

OK:
	nodemgr.c::nodemgr_host_reset()
	sbp2.c::sbp2_host_reset()

looks OK to me:
	dv1394.c::dv1394_host_reset()

can't tell:
	eth1394.c::ether1394_host_reset()
	raw1394.c::host_reset()
-- 
Stefan Richter
-=====-=-==- -==- --=-=
http://arcgraph.de/sr/
