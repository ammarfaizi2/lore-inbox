Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVDRI2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVDRI2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVDRI2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:28:32 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:20997 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261913AbVDRI20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:28:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
Subject: Re: More performance for the TCP stack by using additional hardware chip on NIC
Date: Mon, 18 Apr 2005 11:27:30 +0300
User-Agent: KMail/1.5.4
References: <3Udkm-7rV-7@gated-at.bofh.it> <3Ugid-1w6-25@gated-at.bofh.it> <d3ubvt$1ra$1@pD9F878E4.dip0.t-ipconnect.de>
In-Reply-To: <d3ubvt$1ra$1@pD9F878E4.dip0.t-ipconnect.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504181127.30821.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 April 2005 22:04, Andreas Hartmann wrote:
> Willy Tarreau schrieb:
> > Well, if the application does not touch most of the data, either it
> > is playing as a relay, and the data will at least have to be copied,
> > or it will play as a client or server which reads from/writes to disk,
> > and in this case, I wonder how the NIC will send its writes directly
> > to the disk controller without some help.

If both NIC and disk is clever enough, they can both use DMA:
NIC ==dma==> RAM ==dma==> DISK
without CPU needing to ever touch the bulk of data.

> > What worries me with those NICs is that you have no control on the
> > TCP stack. You often have to disable the acceleration when you
> > want to insert even 1 firewall rule, use policy routing or even
> > do a simple anti-spoofing check. It is exactly like the routers
> > which do many things in hardware at wire speed, but jump to snail
> > speed when you enable any advanced feature.

Yes. This is why TCP offload is a buzzword mostly.
Anybody with real experience on this?

> Alacritech says, the hardware solution would make it very easy for the
> application, because _every_ application would gain, without considering
> the hardware it runs on itself. These are things which CEO's like to hear
> - because they think, they could save time and money during development of
> the application.

Most probably marketspeak.

> I don't think that it must be a problem, that on the hardware TCP stack
> doesn't run any filter or other additional functions, because machines
> (often clusters) with high workloads usually run on dedicated servers with
> other dedicated firewall machines in front of.

If you put firewall machine in front of your 10GigE server, you
are killing its performance.

> I think it would be good to support this hardware, because the user can
> decide afterwards (after testing), which is the best choice for his
> specific application and workload.

Are specs available?
--
vda

