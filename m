Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTK0UAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 15:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTK0UAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 15:00:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46351 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261613AbTK0UAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 15:00:44 -0500
Date: Thu, 27 Nov 2003 20:00:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: felipe_alfaro@linuxmail.org, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
Message-ID: <20031127200041.B25015@flint.arm.linux.org.uk>
Mail-Followup-To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	felipe_alfaro@linuxmail.org, davem@redhat.com,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <1069934643.2393.0.camel@teapot.felipe-alfaro.com> <20031127.210953.116254624.yoshfuji@linux-ipv6.org> <20031127194602.A25015@flint.arm.linux.org.uk> <20031128.045413.133305490.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031128.045413.133305490.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Fri, Nov 28, 2003 at 04:54:13AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 04:54:13AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> In article <20031127194602.A25015@flint.arm.linux.org.uk> (at Thu, 27 Nov 2003 19:46:02 +0000), Russell King <rmk+lkml@arm.linux.org.uk> says:
> > I'm slightly cautious here, although I haven't read the patch yet.
> > Did anyone consider whether any of these structures were copied to
> > user space, and whether, as a result of this change, we're now
> > copying uninitialised data to users?
> 
> I believe that it, to change from strcpy() to strlcpy(), just 
> eliminates possibility of buffer-overrun.

While this is 100% correct, the bit which raised my attention was the
original message which didn't seem to show that the above had been
considered.

The thing that worries me is that an incorrect strlcpy() conversion
gives the impression that someone has thought about buffer underruns
as well as overruns, and, unless someone /has/ actually thought about
it, there could well still be a security problem lurking there.

I'm just overly wary of all strlcpy() conversions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
