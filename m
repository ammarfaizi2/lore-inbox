Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbQLHVTx>; Fri, 8 Dec 2000 16:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132758AbQLHVTn>; Fri, 8 Dec 2000 16:19:43 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:57745 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S132756AbQLHVTf>; Fri, 8 Dec 2000 16:19:35 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: root@chaos.analogic.com, Brian Gerst <bgerst@didntduck.org>,
        Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Message-ID: <802569AF.007255B4.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 8 Dec 2000 20:48:03 +0000
Subject: Re: Why is double_fault serviced by a trap gate?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Exactly, and you wouldn't set DPL=3 for interrupt 8 since a double-fault
can only occur from ring 0..


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> on 08/12/2000 20:31:59

Please respond to Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>

To:   Richard J Moore/UK/IBM@IBMGB
cc:   root@chaos.analogic.com, Brian Gerst <bgerst@didntduck.org>, Andi
      Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
      linux-kernel@vger.kernel.org
Subject:  Re: Why is double_fault serviced by a trap gate?




> No no. That's that the whole point of a gate. You make a controlled
> transition to ring 0 including stack switching. There are complex
> protection checking rules, however as long as the DPL of the gate
> descriptor is 3 then ring 3 is allowed to make the transition to ring 0.
A
> stack fault in user mode cannot kill the system. If it ever did it would
be
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



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
