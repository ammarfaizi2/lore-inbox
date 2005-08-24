Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVHXVR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVHXVR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVHXVR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:17:29 -0400
Received: from [81.2.110.250] ([81.2.110.250]:10388 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932236AbVHXVR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:17:28 -0400
Subject: Re: question on memory barrier
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Andy Isaacson <adi@hexapodia.org>,
       moreau francis <francis_moreau2000@yahoo.fr>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200508241253.53586.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com>
	 <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com>
	 <20050824194836.GA26526@hexapodia.org>
	 <200508241253.53586.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Aug 2005 22:45:35 +0100
Message-Id: <1124919935.13833.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-24 at 12:53 -0700, Jesse Barnes wrote:
> writel() ensures ordering?  Only from one CPU, another CPU issuing a 
> write at some later time may have its write arrive first.  See 
> Documentation/io_ordering.txt for some documentation I put together on 
> this issue.

And in more detail from the deviceiobook..

      <para>
        In addition to write posting, on some large multiprocessing
systems
        (e.g. SGI Challenge, Origin and Altix machines) posted writes
won't
        be strongly ordered coming from different CPUs.  Thus it's
important
        to properly protect parts of your driver that do memory-mapped
writes
        with locks and use the <function>mmiowb</function> to make sure
they
        arrive in the order intended.  Issuing a regular <function>readX
        </function> will also ensure write ordering, but should only be
used
        when the driver has to be sure that the write has actually
arrived
        at the device (not that it's simply ordered with respect to
other
        writes), since a full <function>readX</function> is a relatively
        expensive operation.
      </para>

