Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTEUHv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTEUHmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:42:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58838 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261506AbTEUHl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:28 -0400
Date: Wed, 21 May 2003 08:41:40 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Menno Smits <menno@netbox.biz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic with pptpd when mss > mtu
In-Reply-To: <20030521091442.1bfb41b6.menno@netbox.biz>
Message-ID: <Pine.LNX.4.44.0305210831540.8188-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Menno,

> I'm seeing a kernel oops with 2.4.20 which seems to be related to the
> PopTop PPTP server.

> Decoded oops and module list follow. The crash is reproducable on a
> variety of different hardware. PopTop version is 1.1.3-20030409. PPP
> version is 2.4.1 with MPPE patches.

> Trace; c4b63442 <END_OF_CODE+902b/????>
> Trace; c4b6344a <END_OF_CODE+9033/????>

Unfortunately, your Oops doesn't contain symbol infomartion for modules.
Did you really follow the steps in Documentation/oops-tracing.txt?

> Module                  Size  Used by    Tainted: PF
> ppp_mppe               23320   0  (autoclean)

However, i still have a sneeky suspicion, that the bug is in ppp_mppe (why
did you have to load it using insmod -f?). IIRC from discussions before, a
compressor is not allowed to grow a packet, but when using encryption this
might well happen. If then ppp_mppe calls skb_put to update the len field,
it will trigger the above bug() and cause the oops.

So better check why the above trace misses the module information and if
the trace really shows ppp_mppe in the path, forward the problem to the
PopTop people ;-)

--jochen

