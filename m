Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132708AbQLHVDl>; Fri, 8 Dec 2000 16:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbQLHVDb>; Fri, 8 Dec 2000 16:03:31 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:34569 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132708AbQLHVDW>; Fri, 8 Dec 2000 16:03:22 -0500
Date: Fri, 8 Dec 2000 21:31:59 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: richardj_moore@uk.ibm.com
cc: root@chaos.analogic.com, Brian Gerst <bgerst@didntduck.org>,
        Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <802569AF.002F7247.00@d06mta06.portsmouth.uk.ibm.com>
Message-ID: <Pine.LNX.3.96.1001208212349.14511A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No no. That's that the whole point of a gate. You make a controlled
> transition to ring 0 including stack switching. There are complex
> protection checking rules, however as long as the DPL of the gate
> descriptor is 3 then ring 3 is allowed to make the transition to ring 0.  A
> stack fault in user mode cannot kill the system. If it ever did it would be
> a blatant bug of the most crass kind.

Setting DPL == 3 of any interrupt/trap/fault gate is bad idea because it
allows the user to kill the machine with INT 8 or something like that. DPL
is checked only if interrupt is generated with INT, INT3 or INTO (IA
manual, vol 3, section 5.10.1.1).

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
