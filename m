Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWDWAIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWDWAIA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 20:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWDWAIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 20:08:00 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:39345 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750941AbWDWAH7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 20:07:59 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Van Jacobson's net channels and real-time
Date: Sun, 23 Apr 2006 02:05:32 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Oeser <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <200604221529.59899.ioe-lkml@rameria.de> <20060422134956.GC6629@wohnheim.fh-wedel.de>
In-Reply-To: <20060422134956.GC6629@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604230205.33668.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 22. April 2006 15:49, Jörn Engel wrote:
> That was another main point, yes.  And the endpoints should be as
> little burden on the bottlenecks as possible.  One bottleneck is the
> receive interrupt, which shouldn't wait for cachelines from other cpus
> too much.

Thats right. This will be made a non issue with early demuxing
on the NIC and MSI (or was it MSI-X?) which will select
the right CPU based on hardware channels.

In the meantime I would reduce the effects with only committing
on full buffer or on leaving the interrupt handler. 

This would be ok, because here you have to wakeup the process
anyway on full buffer and if it slept because of empty buffer. 

You loose only, if your application didn't sleep yet and you need to
leave the interrupt handler because there is no work anymore.
In this case the atomic_add would be significant.

All this is quite similiar to now we do page_vec stuff in mm/ already.


Regards

Ingo Oeser
