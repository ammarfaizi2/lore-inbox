Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWHBMuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWHBMuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 08:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWHBMuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 08:50:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:12525 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750874AbWHBMue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 08:50:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XibSLmmWbB4oHtbrSofoDbXdmXw/JYP/XFPAihltqK5f0Xzvk+AgHSxUogfSI8n95alxhWarXbdQW1AqqbV38tdE+8QGnYUqKAxmMUjdYZgqQ7NDDJ33O2628zu5E6JI1bjYYVzzPiEzt8JKFqNix4QLX8hvDBPV3qJQL6jFW2g=
Message-ID: <6e0cfd1d0608020550k7ae2c44dg94afbe56d66b@mail.gmail.com>
Date: Wed, 2 Aug 2006 14:50:32 +0200
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
Cc: johnstul@us.ibm.com, akpm@osdl.org, zippel@linux-m68k.org,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, ak@muc.de
In-Reply-To: <20060801.234422.25910237.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060305.021542.126141997.anemo@mba.ocn.ne.jp>
	 <20060730.235403.108306254.anemo@mba.ocn.ne.jp>
	 <6e0cfd1d0607310336o355693a5l939db098b9210d81@mail.gmail.com>
	 <20060801.234422.25910237.anemo@mba.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > I think that this is going into the wrong direction. There are a
> > number of architectures that call do_timer(regs) in a while loop. It
> > would be much nicer if do_timer would get the number of passed ticks
> > as an argument. And the "regs" argument to do_timer is just useless.
>
> But normally do_timer() is called just once, isn't it?  These loops
> are just for lost ticks, which would be rarely happened.  So I think
> tunning for usual case is better.

If you switch of the hz timer in idle you'll get lots of lost ticks.
And if you are
running a virtualized system you can loose you cpu for some ticks as well.
Pass the number of ticks to do_timer.

-- 
blue skies,
  Martin
