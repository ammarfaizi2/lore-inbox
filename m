Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVDKHlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVDKHlN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVDKHlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:41:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52204 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261718AbVDKHkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:40:53 -0400
Message-ID: <425A295A.6050703@suse.de>
Date: Mon, 11 Apr 2005 09:38:02 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mjg59@srcf.ucam.org, hare@suse.de, Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org> <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net> <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net> <20050405175600.644e2453.akpm@osdl.org> <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net> <20050406142749.6065b836.akpm@osdl.org> <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net> <20050408103327.GD1392@elf.ucw.cz> <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net> <20050410212747.GB26316@elf.ucw.cz> <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
> On Sun, Apr 10, 2005 at 11:27:47PM +0200, Pavel Machek wrote:
>> Can you try without XFS?
> 
> No, XFS is my root filesystem. :( (Now that I think about it, would
> modularizing XFS and using an initrd be OK?)

Yes, although it is not totally trivial.

> I'll see if I can reproduce this on one of my test boxes. I'll *try* to
> get to it later today, but it's possible that I won't be able to get to
> it until next Friday or Saturday.
> 
>> I do not why it interferes, but I've seen that before on suse
>> kernels...
> 
> Have you seen it without the resume-from-initrd patch too, or only with
> that patch?

We have seen it in 9.3-beta, exact scenario was:
- root fs is XFS, ide driver is modular
  => xfs module and ide-controller module is in initramfs
  => first all modules were loaded (device driver + fs)
  => resume was triggered, resume was _really_ slow.

we worked around it in the initramfs by first loading device drivers,
triggering resume, then loading the fs modules and continuing boot.
In the resume case, we'd never reach the "load fs modules" part and
generally it seems a good idea (if the drivers are modular) to keep the
setup before resume as minimalistic as possible.

We never tried with XFS compiled in. It seems we can no longer hide from
fixing XFS ;-)

Best regards,

     Stefan

