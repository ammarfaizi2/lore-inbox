Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUIHGza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUIHGza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268889AbUIHGza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:55:30 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:24897 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268884AbUIHGzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:55:19 -0400
Message-ID: <9e47339104090723554eb021e4@mail.gmail.com>
Date: Wed, 8 Sep 2004 02:55:15 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: multi-domain PCI and sysfs
Cc: "David S. Miller" <davem@davemloft.net>, willy@debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200409072125.41153.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409072115.09856.jbarnes@engr.sgi.com>
	 <20040907211637.20de06f4.davem@davemloft.net>
	 <200409072125.41153.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another part I don't understand... PCI VGA hardware is designed to
respond to IN/OUT instructions to port space. ppc64/ia64 don't have
IN/OUT port instructions. Is there some special hardware on ppc64/ia64
that declares part of the PCI IO space "legacy space" and turns
read/writes there into IN/OUT port cycles on the PCI bus so that the
legacy hardware can see the accesses?

On machines without this "legacy space" translation hardware (ie all
32b x86 bit machines) I can only have a single VGA adapter active
since there is only a single legacy space and inb/outb are real
instructions.

On machines with "legacy space" translation I can have one active VGA
card per translator. How do I know how many translators there are? Is
only one per domain/segment allowed?

How does ppc32 handle VGA port instructions, is the "legacy
translation" space at the bottom of the PCI address space?

I looked at io.h on IA64, how do apps select which legacy IO space
they are using? Now I see add_io_space() and related code.

Maybe it's not a good idea to have a 32b x86 person writing this
driver. Is there a cross platform structure that corresponds to IO
spaces?


-- 
Jon Smirl
jonsmirl@gmail.com
