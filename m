Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268002AbTBMJwu>; Thu, 13 Feb 2003 04:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268005AbTBMJwu>; Thu, 13 Feb 2003 04:52:50 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:56801 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268002AbTBMJwt>; Thu, 13 Feb 2003 04:52:49 -0500
Date: Thu, 13 Feb 2003 11:00:29 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Dave Jones <davej@codemonkey.org.uk>, torvalds@transmeta.com,
       davej@suse.de, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] cpufreq: move frequency table helpers to extra module
Message-ID: <20030213100029.GA14301@brodo.de>
References: <20030213091131.GA8909@brodo.de> <20030213093951.GA22151@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213093951.GA22151@codemonkey.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 09:39:51AM +0000, Dave Jones wrote:
> On Thu, Feb 13, 2003 at 10:11:31AM +0100, Dominik Brodowski wrote:
>  > The CPU frequency table helpers can easily be modularized --
>  > especially as they are not needed on all architectures, or for 
>  > all drivers.
> 
> As most of the x86 drivers have been converted now, it looks like
> it'd make more sense to conditionalise this on architecture, and
> move the remaining x86 drivers over to the helpers (longrun/longhaul).

Longhaul yes, Longrun no. On longrun you can't set the speed to a specific
frequency[*], only to a _frequency range_. So the frequency table helpers
aren't needed there. Also, for gx-suspmod, which allows really fine-grained
setting of frequencies, the frequency table helpers don't make sense.

> It just strikes me as silly that we have a config option that when
> disabled could end up showing no chip drivers when the conversion
> is complete.

So, even when the conversion is complete, there are two drivers which can be
compiled. Additionally, some users (or distros!) might prefer modularizing
this.

	Dominik

[*] you can set policy->max = policy->min, but that really doesn't make
sense on longrun.
