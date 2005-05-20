Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVETBRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVETBRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 21:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVETBRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 21:17:52 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:49357 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261219AbVETBRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 21:17:47 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <428D37CF.5070903@cybsft.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave> <428C030E.8030102@cybsft.com>
	 <1116476630.5867.2.camel@mulgrave>  <20050519095143.GA3972@in.ibm.com>
	 <1116546970.5037.137.camel@mulgrave>  <428D37CF.5070903@cybsft.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 20:17:33 -0500
Message-Id: <1116551853.5037.145.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 20:05 -0500, K.R. Foley wrote:
> It does work with the exception that my u160 drive is still identified
> as 80MB/s.

Well, that's some good news, at least.

> May 19 19:36:46 porky kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
> May 19 19:36:46 porky kernel:  target0:0:0: Beginning Domain Validation
> May 19 19:36:46 porky kernel: WIDTH IS 1
> May 19 19:36:46 porky kernel: (scsi0:A:0): 6.600MB/s transfers (16bit)
> May 19 19:36:46 porky kernel: (scsi0:A:0): 80.000MB/s transfers
> (40.000MHz, offset 127, 16bit)

OK, it looks like the period is limited to 25ns.  Could you confirm
this?

cat /sys/class/spi_transport/target0:0:0/period
cat /sys/class/spi_transport/target0:0:0/max_period

Now, if the max_period is 25, try doing

echo 12.5 > /sys/class/spi_transport/target0:0:0/max_period

and then

echo 1 > /sys/class/spi_transport/target0:0:0/revalidate

to trigger a revalidation of the domain and see if it comes up to 160.

Thanks,

James


