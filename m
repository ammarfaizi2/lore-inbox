Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUBHJJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 04:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUBHJJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 04:09:16 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:64004 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262965AbUBHJJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 04:09:13 -0500
Date: Sun, 8 Feb 2004 10:08:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Len Brown <len.brown@intel.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] ACPI for 2.4
Message-ID: <20040208090854.GE29363@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4> <20040208082059.GD29363@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208082059.GD29363@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself...

On Sun, Feb 08, 2004 at 09:20:59AM +0100, Willy Tarreau wrote:
> 
> So I've added printk's into acpi_power_off(), and I see that the system
> doesn't return from acpi_enter_sleep_state_prep(S5), which itself hangs
> on the call to acpi_evaluate_object(NULL, "\\_PTS",...). If I comment
> out this line, it now goes on through the next calls, then normally leaves
> acpi_enter_sleep_state_prep(), then powers off correctly.

Searching for _PTS on google directed me to the ACPI spec. I found in
section 9 that _PTS (prepare to sleep) is only used for S1-S4, but 9.1.7
says that it should be called for S5 too. I suspect that depending on the
paragraph they read, hardware makers do or don't implement _PTS(S5) correctly
:-/ BTW, 9.1.5 says that "S5 is not a sleeping state, but a G2 state". So it
might seem logical not to call something named "prepare to sleep" in this
case.

I checked the last working version. It was acpi-030424 + the two little
patches I sent to you at this time and which were merged. This version
called _PTS and _GTS in acpi_enter_sleep_state_prep(), while now we call
_PTS, _GTS, and _SI._SST. So I'm amazed that in previous version, _PTS
worked and that it does not anymore !

Regards,
Willy

