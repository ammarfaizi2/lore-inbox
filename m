Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277199AbRJDRlY>; Thu, 4 Oct 2001 13:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277200AbRJDRlP>; Thu, 4 Oct 2001 13:41:15 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:8433 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277199AbRJDRlK>; Thu, 4 Oct 2001 13:41:10 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 4 Oct 2001 11:40:21 -0600
To: jamal <hadi@cyberus.ca>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011004114021.F31061@turbolinux.com>
Mail-Followup-To: jamal <hadi@cyberus.ca>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Robert Olsson <Robert.Olsson@data.slu.se>,
	Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
	Simon Kirby <sim@netnation.com>
In-Reply-To: <Pine.LNX.4.33.0110040752330.1727-100000@localhost.localdomain> <Pine.GSO.4.30.0110040659530.9341-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0110040659530.9341-100000@shell.cyberus.ca>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04, 2001  07:34 -0400, jamal wrote:
> 1) you shut down shared interupts; take a look at this posting by Marcus
> Sundberg <marcus@cendio.se>
> 
> ---------------
> 
>   0:    7602983          XT-PIC  timer
>   1:      10575          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>  11:    1626004          XT-PIC  Toshiba America Info Systems ToPIC95 PCI
> \
> to Cardbus Bridge with ZV Support, Toshiba America Info Systems ToPIC95
> PCI \
> to Cardbus Bridge with ZV Support (#2), usb-uhci, eth0, BreezeCom Card, \
> Intel 440MX, irda0  12:       1342          XT-PIC  PS/2 Mouse
>  14:      23605          XT-PIC  ide0
> 
> -----------------------------
> 
> Now you go and shut down IRQ 11 and punish all devices there. If you can
> avoid that, it is acceptable as a temporary replacement to be upgraded to
> a better scheme.

Well, if we fall back to polling devices if the IRQ is disabled, then the
shared interrupt case can be handled as well.  However, there were complaints
about the patch when Ingo had device polling included, as opposed to just
IRQ mitigation.

> 2) By not being granular enough and shutting down sources of noise, you
> are actually not being effective in increasing system utilization.

Well, since the IRQ itself uses system resources, if it is disabled it will
allow those resources to actually do something (i.e. polling instead, when
we know there is a lot of work to do).

Even if it does not have polling in the patch, the choice is to turn off
the IRQ, or have the system hang because it can not make any progress
because of the high number of interrupts.  If your patch ensures that the
network IRQ load is kept down, then Ingo's will never be activated.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

