Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVBCKST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVBCKST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVBCKST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:18:19 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:62082 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263011AbVBCKSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:18:00 -0500
Date: Thu, 03 Feb 2005 19:10:39 +0900 (JST)
Message-Id: <20050203.191039.39155205.taka@valinux.co.jp>
To: ebiederm@xmission.com
Cc: vgoyal@in.ibm.com, akpm@osdl.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com, hari@in.ibm.com,
       suparna@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
 crashdumps.
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <m1zmym6m6z.fsf@ebiederm.dsl.xmission.com>
References: <1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<20050203.160252.104031714.taka@valinux.co.jp>
	<m1zmym6m6z.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> > Hi Vivek and Eric,
> > 
> > IMHO, why don't we swap not only the contents of the top 640K
> > but also kernel working memory for kdump kernel?
> > 
> > I guess this approach has some good points.
> > 
> >  1.Preallocating reserved area is not mandatory at boot time.
> >    And the reserved area can be distributed in small pieces
> >    like original kexec does.
> > 
> >  2.Special linking is not required for kdump kernel.
> >    Each kdump kernel can be linked in the same way,
> >    where the original kernel exists.
> > 
> > Am I missing something?
> 
> Preallocating the reserved area is largely to keep it from
> being the target of DMA accesses.  Since we are not able
> to shutdown any of the drivers in the primary kernel running
> in a normal swath of memory sounds like a good way to get
> yourself stomped at the worst possible time.

So what do you think my another idea?

I think we can always make a kdump kernel mapped to the same virtual
address. So we will be free from caring about the physical address
where the kdump kernel is loaded.

I believe the memsection functionality which LHMS project is working
on would help this.

                            +
                            |
                            |
                        (user space)
                            |
                            |
          physical          | virtual
          memory            | space
             + ------------ +
             |              |
             |              |
             |              |
             + ------------.+
    original |           .  | map kdump kernel here
    kernel   |         .    |
             |       .      |
             |     .       .+
             +   .       .  |
             | .       .    |
             +       .      |
      kdump  |     .        |
      kernel |   .          |
             | .            |
             +              |
             |              |
             |              |
             |              |



Thanks,
Hirokazu Takahashi.
