Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWCXRlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWCXRlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWCXRlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:41:52 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:1159 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751297AbWCXRlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:41:52 -0500
Date: Fri, 24 Mar 2006 18:41:51 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: ray-gmail@madrabbit.org
Cc: lkml <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: delay_tsc(): inefficient delay loop (2.6.16-mm1)
Message-ID: <20060324174151.GA20085@rhlx01.fht-esslingen.de>
References: <20060324170436.GA1568@rhlx01.fht-esslingen.de> <2c0942db0603240922u7bade58lcf2a6af2af8ec6ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0942db0603240922u7bade58lcf2a6af2af8ec6ae@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 24, 2006 at 09:22:51AM -0800, Ray Lee wrote:
> On 3/24/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> > +       loops += bclock;
> [...]
> > -       } while ((now-bclock) < loops);
> > +       } while (now < loops);
> 
> Erm, aren't you introducing an overflow problem here?
> 
> if loops is 2^32-1, bclock is 1, the old version would execute the
> proper number of times, the new one will blow out in one tick.

Doh. That's what happens if you get too excited about some new trick...
Back to the drawing board, methinks.

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
