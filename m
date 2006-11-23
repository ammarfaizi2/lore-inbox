Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933713AbWKWNma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933713AbWKWNma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933715AbWKWNma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:42:30 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:6919 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S933713AbWKWNma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:42:30 -0500
Date: Thu, 23 Nov 2006 14:42:21 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jason Gaston <jason.d.gaston@intel.com>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, i2c@lm-sensors.org
Subject: Re: [PATCH 2.6.19-rc6] i2c-i801: SMBus patch for Intel ICH9
Message-Id: <20061123144221.866c07cb.khali@linux-fr.org>
In-Reply-To: <1164284758.31358.781.camel@laptopd505.fenrus.org>
References: <200611221519.12373.jason.d.gaston@intel.com>
	<20061123130938.5818ad16.khali@linux-fr.org>
	<1164284758.31358.781.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

On Thu, 23 Nov 2006 13:25:57 +0100, Arjan van de Ven wrote:
> On Thu, 2006-11-23 at 13:09 +0100, Jean Delvare wrote:
> > On Wed, 22 Nov 2006 15:19:12 -0800, Jason Gaston wrote:
> > > This updated patch adds the Intel ICH9 LPC and SMBus Controller DID's.
> > > This patch relies on the irq ICH9 patch to pci_ids.h.
> > 
> > Looks good. Care to also update Documentation/i2c/busses/i2c-i801? I
> > see it misses at least the ICH8 and ESB2 as well.
> > 
> > I would also appreciate an update to lm_sensors' sensors-detect script,
> > if you could send a patch to the sensors list.
> 
> 
> hmmm couldn't the sensors-detect script just at runtime look at the pci
> tables in the modules? that way no need to duplicate/update all of this
> in multiple places...

Not really. It is important that sensors-detect knows about chips which
are not supported by the running kernel. That way, we can tell the
users to try the latest version of sensors-detect when they report that
hardware monitoring doesn't work out of the box, and from the output,
we can tell them which kernel they need to upgrade to. If
sensors-detect reads the list of supported devices from the kernel,
instead of having its own, it will no longer work, by definition.

Additionally, sensors-detect is still supposed to support 2.4 kernels,
and I don't think 2.4 drivers advertise the list of devices they
support.

What we could do, on the other hand, is check the detected device ID
against the list the running kernel driver supports, to let the user
know that his/her chip is not supported by his/her kernel. Care to
provide a patch adding this functionality to sensors-detect?

Thanks,
-- 
Jean Delvare
