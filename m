Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264740AbSIQWzM>; Tue, 17 Sep 2002 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264703AbSIQWzL>; Tue, 17 Sep 2002 18:55:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8893 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264740AbSIQWvm> convert rfc822-to-8bit;
	Tue, 17 Sep 2002 18:51:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "David S. Miller" <davem@redhat.com>, ak@suse.de
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Date: Tue, 17 Sep 2002 15:55:52 -0700
User-Agent: KMail/1.4.1
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, anton.wilson@camotion.com
References: <20020917.141806.49377410.davem@redhat.com> <20020918004442.A32234@wotan.suse.de> <20020917.153828.24171342.davem@redhat.com>
In-Reply-To: <20020917.153828.24171342.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209171555.52872.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 September 2002 03:38 pm, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: Wed, 18 Sep 2002 00:44:42 +0200
>
>    > I don't know how Sun and SGI manage with their larger systems.  Either
>    > they don't do clock sync, or they may have to make expensive
>    > tradeoffs.
>
>    I guess you could always run NTP between the different CPUs ;) ;)
>
> :-)
>
> More seriously, you don't need to have the cpu tick registers sync'd,
> it is the rate that matters.
>
> Once booted, you can sync these system tick registers with a pretty
> straight forward algorithm in the kernel.  Bonus points if you can
> figure out how to cancel out the cost of moving the system tick sample
> cachelines between master and slave in your algorithm :-)

Been there.  Done that.  Had the product canceled.    ;^)

The initial sync was easy, even with variable latencies on cache lines.  A 
much simplified NTP-ish algorithm works fine.  The painful thing was bus 
clock drift and programs that foolishly relied on the TSC being the same 
between CPUs and between nodes.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

