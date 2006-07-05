Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWGEUA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWGEUA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWGEUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:00:27 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:24530 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S964914AbWGEUA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:00:26 -0400
Date: Wed, 5 Jul 2006 16:00:23 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA modem not found... resume/suspend helps some times... magic is not found
Message-ID: <20060705200023.GE12704@washoe.onerussian.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060624200409.GA12704@washoe.onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624200409.GA12704@washoe.onerussian.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel People,

Since nobody followed up I've decided to provide additional information
which might help to pin point the problem.
I've loaded pcmcia_core with pc_debug=255

Troublesome lines for me are:

Jul  5 15:52:25 vaio kernel: pcmcia: registering new device pcmcia0.0
Jul  5 15:52:25 vaio kernel: cs: pcmcia_socket0: cs: overrun in pcmcia_get_next_tuple
Jul  5 15:52:26 vaio kernel: cs: pcmcia_socket0: cs: overrun in pcmcia_get_next_tuple

Full kern.log is available from
http://www.onerussian.com/Linux/bugs/pcmcia.modem/kern.log.debug

Please advise what else could I do to revive this modem to life

Thank you in advance

On Sat, 24 Jun 2006, Yaroslav Halchenko wrote:

> Dear Kernel People,

> Before my long trip abroad I decided to make my pcmcia modem work under
> fresh 2.6.17-rc6-mm2.

> It wasn't found at all... after some dancing around it started to
> to appear after pccardctl suspend, pccardctl resume calls.
> After reboot it stopped to do that... now max I could make it is to find
> it partially without binding to loaded serial_cs:

> > sudo pccardctl status
> Socket 0:
> 5.0V 16-bit PC Card
> Subdevice 0 (function 0) [unbound]

> Some information from magic successful initialization is available
> in my bug failed on Debian:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=374742

> and modem was found to be
>     SUBSYSTEM=="pcmcia"
>     SYSFS{modalias}=="pcmcia:m016Cc0001f02fn00pfn00paF5F025C2pb200E6E61pc26477DB8pdC5F4D6FD"
>     SYSFS{prod_id4}=="V8.041"
>     SYSFS{prod_id3}=="56K+Fax"
>     SYSFS{prod_id2}=="Gold Card Global 56K+Fax"
>     SYSFS{prod_id1}=="Psion Dacom"
>     SYSFS{card_id}=="0x0001"
>     SYSFS{manf_id}=="0x016c"
>     SYSFS{func_id}=="0x02"
>     SYSFS{pm_state}=="on"
>     SYSFS{function}=="0x00"

> information on current system where I can't make it work any more
> http://www.onerussian.com/Linux/bugs/pcmcia.modem/

> Here are the results of suspend/resume sequence:

> *> sudo pccardctl eject
> *> sudo pccardctl insert
> > sudo pccardctl status
> Socket 0:
> 5.0V 16-bit PC Card
> > sudo pccardctl suspend
> > sudo pccardctl status
> Socket 0:
> X.XV 16-bit PC Card [suspended]
> > sudo pccardctl resume
> > sudo pccardctl status
> Socket 0:
> 5.0V 16-bit PC Card
> Subdevice 0 (function 0) [unbound]

> Please advise!
-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07102
Student  Ph.D. @ CS Dept. NJIT
