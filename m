Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTEQQVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 12:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTEQQVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 12:21:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:5116 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261631AbTEQQVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 12:21:19 -0400
Subject: Re: time interpolation hooks
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, Arjan van de Ven <arjanv@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       David Mosberger <davidm@napali.hpl.hp.com>
In-Reply-To: <20030516142311.3844ee97.akpm@digeo.com>
References: <20030516142311.3844ee97.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053189093.27770.12.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 May 2003 09:31:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 14:23, Andrew Morton wrote:
> Gents, the below patch comes from David M-T, out of the ia64 tree.  It may
> be a suitable solution to the "gettimeofday goes backwards when interrupts
> were blocked" problem.
> 
> It will need per-arch support.  I'm not sure what that looks like; maybe
> David can outline what the reset/update functions should do?

Yea, I'd like to see a sample reset/update implementation as well. 

Right now in i386 land we do the compensation for lost ticks in
mark_offset_tsc/cyclone. The reason for this is that every interrupt we
only want to read the high-res timesource once in order to avoid any
atomicity issues. So all the interpolation and compensation has to
happen in the same place (or atleast using the same data).

I probaly need to spend some more time looking over this. However the
sample implementation would likely give me the "aha!" i need. 

thanks
-john


