Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272387AbRIKKlm>; Tue, 11 Sep 2001 06:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272385AbRIKKlc>; Tue, 11 Sep 2001 06:41:32 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:46091 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272389AbRIKKlS>; Tue, 11 Sep 2001 06:41:18 -0400
Date: Mon, 10 Sep 2001 23:19:11 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andi Kleen <ak@muc.de>
Cc: kuznet@ms2.inr.ac.ru, tao@acc.umu.se, matthias.andree@gmx.de,
        alan@lxorguk.ukuu.org.uk, wietse@porcupine.org,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010910231911.I30149@emma1.emma.line.org>
Mail-Followup-To: Andi Kleen <ak@muc.de>, kuznet@ms2.inr.ac.ru,
	tao@acc.umu.se, alan@lxorguk.ukuu.org.uk, wietse@porcupine.org,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se> <200109101936.XAA00707@ms2.inr.ac.ru> <20010910224002.31693@colin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010910224002.31693@colin.muc.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen schrieb am Montag, den 10. September 2001:

> > So that applications will have to worry about compatibility with older
> > kernels in any case.
> 
> Just hope then that no ifconfig or other binary has a two on the stack
> when calling this.

Thanks for asking, however, nothing bad will happen if there are no
4.4BSD-style aliases. If there are, you have no business using ifconfig
anyways, and ifconfig certainly has not configured the aliases (it
overwrites the primary address unless you use a separate name such as
eth0:0).

Actually, in net-tools-1.56, ifconfig does write AF_INET onto its ifr
(it gets shot otherwise), without clearing the address field (which
contains the txqueuelen result). However, the worst thing that can
happen is that ifconfig displays one of the aliases - but the alias
would match the txqueuelen then. How many people have 0.0.0.* or *.0.0.0
addresses configured as alias? Not too many. None, to be precise.

It will not bite portable applications either since those init their
address properly.

-- 
Matthias Andree
