Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUB0KFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUB0KFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:05:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:28346 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261777AbUB0KF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:05:27 -0500
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arief# <arief_m_utama@telkomsel.co.id>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1077876373.843.3.camel@damai.telkomsel.co.id>
References: <1077863238.2522.6.camel@damai.telkomsel.co.id>
	 <1077865490.22215.217.camel@gaston>
	 <1077876373.843.3.camel@damai.telkomsel.co.id>
Content-Type: text/plain
Message-Id: <1077875802.22215.267.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 20:56:42 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 21:06, arief# wrote:
> Dear all.
> 
> 
> This patch from Benjamin solved my problem.
> 
> To Zilvinas <zilvinas@gemtek.lt>, I've tried your suggestion to change
> my XF86Config-4 file to include UseFBDev line. But it doesnt work. It
> made my Xserver wont even start. But I'm not sure, it could be X problem
> (Debian Unstable got some updated X package that I haven't got a chance
> to upgrade to).

There is a problem with recent radeonfb's an X + UseFBDev. I think the
problem is that XFree is claiming a mode whose virtual resolution is very
large. I have to verify that (it works for me here). Radeonfb has
limitations on what it allows on the virtual resolution in recent
version to limit the ioremap'ing done in the kernel. Unfortunately,
there is no simple way to "detach" one from the other at this point. 

I should modify radeonfb to crop the virtual resolution instead of
failing though...

Can you try hacking in drivers/video/aty/radeon_base.c, function
check_mode() and see why it fails ? (I think it's that function
that is failing).

Ben.


