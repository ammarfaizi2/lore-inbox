Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUJGWP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUJGWP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269851AbUJGWNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:13:36 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:26584 "EHLO
	mailfe07.swip.net") by vger.kernel.org with ESMTP id S269845AbUJGWI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:08:56 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Fri, 8 Oct 2004 00:08:51 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sebastien.hinderer@libertysurf.fr
Subject: Re: [Patch] new serial flow control
Message-ID: <20041007220851.GD2296@bouh.is-a-geek.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sebastien.hinderer@libertysurf.fr
References: <200410051249_MC3-1-8B8B-5504@compuserve.com> <20041005172522.GA2264@bouh.is-a-geek.org> <1097176130.31557.117.camel@localhost.localdomain> <20041007212722.G8579@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041007212722.G8579@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 07 oct 2004 à 21:27:22 +0100, Russell King a écrit:
> I can't help but wonder whether moving some of the usual modem line
> status change processing should also be moved into the higher levels.

The more I'm thinking about it, the more I think it's not a good idea:
that would require *every* line discipline to implement hardware flow
control (just like xon/xoff), while I think they shouldn't really care
about it.

The asynchronous ppp ldisc for instance can be used on a serial line,
but can very well be used on a ssh tunnel (in which case rts/cts flow
control has no meaning).

I can understand that xon/xoff processing be implemented in ldiscs
since it is characters stuff, but one can't ask the ldisc to know
details about hardware flow control which depends on the tty it is
used on.

Regards,
Samuel Thibault
