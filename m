Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUJGVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUJGVqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUJGVoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:44:12 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:28056 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S268170AbUJGVnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:43:35 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Thu, 7 Oct 2004 23:43:30 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, sebastien.hinderer@libertysurf.fr
Subject: Re: [Patch] new serial flow control
Message-ID: <20041007214330.GB2296@bouh.is-a-geek.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <rmk@arm.linux.org.uk>,
	sebastien.hinderer@libertysurf.fr
References: <200410051249_MC3-1-8B8B-5504@compuserve.com> <20041005172522.GA2264@bouh.is-a-geek.org> <1097176130.31557.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1097176130.31557.117.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 07 oct 2004 à 20:08:56 +0100, Alan Cox a écrit:
> Right now that poses a challenge but if drivers were to implement
> ldisc->modem_change() or a similar callback for such events an ldisc
> could then handle many of the grungy suprises and handle them once and
> in one place.

Surprises like regular RTS/CTS flow control ?
Aren't there serial chips that are able to handle it themselves ? (so
that the _serial driver_ should be responsible for that, doing it in
software if needed)

I'm asking because there was some funny bug not that far ago: async
ppp people thought that xon/xoff were processed in the serial driver,
because "some serial chips may be able to handle that themselves". So
they weren't processing them. But actually it's really up to the
ldisc to process them. Thus nobody was processing it !

Regards,
Samuel Thibault
