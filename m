Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269919AbUJGX1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269919AbUJGX1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269909AbUJGX00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:26:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16908 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269919AbUJGXKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:10:39 -0400
Date: Fri, 8 Oct 2004 00:10:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sebastien.hinderer@libertysurf.fr
Subject: Re: [Patch] new serial flow control
Message-ID: <20041008001034.H8579@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sebastien.hinderer@libertysurf.fr
References: <200410051249_MC3-1-8B8B-5504@compuserve.com> <20041005172522.GA2264@bouh.is-a-geek.org> <1097176130.31557.117.camel@localhost.localdomain> <20041007212722.G8579@flint.arm.linux.org.uk> <20041007220851.GD2296@bouh.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041007220851.GD2296@bouh.is-a-geek.org>; from samuel.thibault@ens-lyon.org on Fri, Oct 08, 2004 at 12:08:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 12:08:51AM +0200, Samuel Thibault wrote:
> Le jeu 07 oct 2004 à 21:27:22 +0100, Russell King a écrit:
> > I can't help but wonder whether moving some of the usual modem line
> > status change processing should also be moved into the higher levels.
> 
> The more I'm thinking about it, the more I think it's not a good idea:
> that would require *every* line discipline to implement hardware flow
> control (just like xon/xoff), while I think they shouldn't really care
> about it.

Please note that I said "into the higher levels" and not "into line
disciplines" - I completely agree with you.  For the general case,
line disciplines do not need to know that the CTS signal has been
deasserted, or that DCD has deasserted - these are all meaningless
to the vast majority.

There are special cases though, such as the one being discussed in
this thread, where it does make sense for the line discipline to
override the default behaviour.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
