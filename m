Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318649AbSICMwx>; Tue, 3 Sep 2002 08:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318690AbSICMwx>; Tue, 3 Sep 2002 08:52:53 -0400
Received: from [64.119.101.42] ([64.119.101.42]:21376 "HELO mars.net-itech.com")
	by vger.kernel.org with SMTP id <S318649AbSICMww>;
	Tue, 3 Sep 2002 08:52:52 -0400
Date: Tue, 3 Sep 2002 08:57:19 -0400
From: Avery Pennarun <apenwarr@nit.ca>
To: "Vlodavsky, Zvi" <zvi.vlodavsky@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'faith@cs.unc.edu'" <faith@cs.unc.edu>,
       "'Ulrich.Windl@rz.uni-regensburg.de'" 
	<Ulrich.Windl@rz.uni-regensburg.de>,
       "Levy, Omer" <omer.levy@intel.com>
Subject: Re: Momentary timezone problem with apm (bug report)
Message-ID: <20020903085719.A13333@worldvisions.ca>
References: <436282DBEE7CD51191E30002A50A6369032D14A0@hasmsx102.iil.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436282DBEE7CD51191E30002A50A6369032D14A0@hasmsx102.iil.intel.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 11:59:41AM +0300, Vlodavsky, Zvi wrote:

> Please personally CC me with responses on this posting: 
> I have encountered a problem when coming out of apm suspend mode (apm -s):
> the system time gets momentarily skewed by the hour difference between the
> local timezone and GMT. It then returns to normal, but the momentary skew
> can casue problems for applications checking the time right after coming out
> of suspend.

This problem is usually a result of the completely useless "RTC stores time
in GMT" kernel option, whose only effect is to make the kernel load the
wrong time out of the RTC when is comes out of suspend.  (You can safely
disable this option even if your clock _is_ stored in GMT.)

So make sure that option is set to NO.

Other than that, try killing apmd and make sure it's not to blame; maybe
it's restoring the wrong time if it's calling hwclock incorrectly for your
system (but since you describe the problem as a "momentary" one, apmd is
likely the one fixing it, not breaking it).

Good luck.

Avery

