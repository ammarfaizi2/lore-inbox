Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUEMTks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUEMTks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbUEMTjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:39:21 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:12299 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264471AbUEMT1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:27:40 -0400
Subject: Re: [PATCH] AES i586 optimized (oops)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Fruhwirth Clemens <clemens-dated-1085312570.422b@endorphin.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1084462173.2554.3.camel@teapot.felipe-alfaro.com>
References: <20040513110110.GA8491@ghanima.endorphin.org>
	 <20040513040732.75c5999c.akpm@osdl.org>
	 <20040513114250.GB22233@ghanima.endorphin.org>
	 <1084457158.1737.2.camel@teapot.felipe-alfaro.com>
	 <1084462173.2554.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1084476462.1793.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 13 May 2004 21:27:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 17:29, Felipe Alfaro Solana wrote:
> On Thu, 2004-05-13 at 16:05, Felipe Alfaro Solana wrote:
> > On Thu, 2004-05-13 at 13:42, Fruhwirth Clemens wrote:
> > > > 
> > > > Some benchmark figures would be useful.  Cache-cold and cache-hot.
> > > 
> > > I posted this patch for the first time about 3/4 year ago. The first
> > > response has been the same. Please have a look at
> > 
> > I'll give this a spin, since I'm very interested in AES. Currently, I'm
> > using IPSec with AES ESP all over my 100Mbps LAN. I'll apply this one to
> > 2.6.6-mm2 and will compare with vanillas 2.6.6 and 2.6.6-mm2.
> 
> I got an oops on 2.6.6-mm2 plus i586 AES patch when invoking setkey to
> setup my SPD database with preshared keys entries. Attached dmesg and
> config.

As pointed before, it was the CONFIG_REGPARM config option. Reverting
the force-config_regparm-to-y.patch and setting CONFIG_REGPARM to no
solves the problems.

Having tried the new i586-optimized AES, I must say that throughput
increases from ~7MB/s with vanilla AES to more than ~9.4MB/s with the
i586-optimized AES (when FTPing a large file over the AES/ESP encrypted
link).

That's like saying that I'm getting more than 80% of the maximum
sustained, unencrypted throughput for my network link (which is at
~11MB/s). That's really impressive, since that's a Security Association
between a 700Mhz PIII and a 2GHz P4.

Nice work, indeed.

