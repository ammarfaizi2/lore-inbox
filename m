Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVAUVMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVAUVMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVAUVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:12:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:39914 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262504AbVAUVMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:12:12 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: device-mapper: fix TB stripe data corruption
Date: Fri, 21 Jan 2005 15:12:45 -0600
User-Agent: KMail/1.7.1
Cc: Benjamin LaHaise <bcrl@kvack.org>, Alasdair G Kergon <agk@redhat.com>,
       Andrew Morton <akpm@osdl.org>
References: <20050121181203.GI10195@agk.surrey.redhat.com> <20050121203354.GC2265@kvack.org>
In-Reply-To: <20050121203354.GC2265@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211512.45524.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 2:33 pm, Benjamin LaHaise wrote:
> On Fri, Jan 21, 2005 at 06:12:03PM +0000, Alasdair G Kergon wrote:
> > Missing cast thought to cause data corruption on devices with stripes >
> > ~1TB.
>
> Why not make chunk a sector_t?

We have to take a mod of the chunk value and the number of stripes (which can 
be a non-power-of-2, so a shift won't work). It's been my understanding that 
you couldn't mod a 64-bit value with a 32-bit value in the kernel. Just to be 
sure, I've changed "chunk" to a sector_t and recompiled, and get the 
following error:

  MODPOST
*** Warning: "__udivdi3" [drivers/md/dm-mod.ko] undefined!
*** Warning: "__umoddi3" [drivers/md/dm-mod.ko] undefined!

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
