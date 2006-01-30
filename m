Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWA3Igw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWA3Igw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWA3Igv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:36:51 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:44194 "EHLO
	smtprelay06.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751265AbWA3Igv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:36:51 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
Date: Mon, 30 Jan 2006 09:36:42 +0100
User-Agent: KMail/1.7.2
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org
References: <20060128182522.GA31458@havoc.gtf.org> <200601291711.43426.ioe-lkml@rameria.de> <43DDBA71.6040402@gmail.com>
In-Reply-To: <43DDBA71.6040402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601300936.43977.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 08:04, Tejun Heo wrote:
> I object.  Using array is intentional.  Slave aware controllers (PATA / 
> ata_piix) will use [0..1], most SATA controllers will use only [0], and 
> PM aware ones will use [0..15].  The intention was requiring low level 
> drivers of only what they know and normalize them in the core layer.
> 
> eg. Current std SATA reset routines consider the argument as *class (a 
> single class value) and it's intentional.  As long as a lldd is aware of 
> only one device per port, it's allowed/recommeded to consider the passed 
> classes argument as a pointer to single class value.  The rest is upto 
> the core libata layer.
 
But what you pass along is basically an unbounded array, which is
a bug waiting to happen.

So please let the core layer pass a bounded array here or provide
a function from core layer to set that and check the index.


Thanks & Regards

Ingo Oeser

