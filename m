Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265070AbTFRTf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTFRTf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:35:27 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:12744
	"EHLO jumper") by vger.kernel.org with ESMTP id S265070AbTFRTfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:35:23 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi>
	<20030615191125.I5417@flint.arm.linux.org.uk>
	<87el1vcdrz.fsf@jumper.lonesom.pp.fi>
	<20030615212814.N5417@flint.arm.linux.org.uk>
	<87he6qc3bb.fsf@jumper.lonesom.pp.fi>
	<20030616085403.A5969@flint.arm.linux.org.uk>
	<3EEE173A.8040802@telia.com>
	<20030616212700.J13312@flint.arm.linux.org.uk>
	<3EEEAA9C.5060801@telia.com>
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Wed, 18 Jun 2003 22:49:54 +0300
In-Reply-To: <3EEEAA9C.5060801@telia.com> (Peter Lundkvist's message of
 "Tue, 17 Jun 2003 07:43:56 +0200")
Message-ID: <87wufjmahp.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Lundkvist <p.lundkvist@telia.com> writes:

> Russell King wrote:
>> Great, this helps a lot.  While I remove the bullet from my foot, could
>> you test this patch please?
>> 
>> --- linux/drivers/pcmcia/cs.c.old	Mon Jun 16 21:17:45 2003
>> +++ linux/drivers/pcmcia/cs.c	Mon Jun 16 21:24:23 2003
>> @@ -817,7 +817,8 @@
>>  				if ((skt->state & SOCKET_PRESENT) &&
>>  				     !(status & SS_DETECT))
>>  					socket_shutdown(skt);
>> -				if (status & SS_DETECT)
>> +				if (!(skt->state & SOCKET_PRESENT) &&
>> +				    status & SS_DETECT)
>>  					socket_insert(skt);
>>  			}
>>  			if (events & SS_BATDEAD)
>
> A quick test with this patch against 2.5.71: Works OK now!

 Confirmation. Booted 2.5.72 with this patch and tried swapping and switching
 cards about 50 times, and things look stable.

 Next, how to get my d-link dwl-650 wlan card up and running. If I insert it,
 link light on it lights up, and cardctl sees it in socket. However the drivers
 do not find it, and there is no interface available. This happens at least
 with 2.5.70 to .72. Anyone got suggestions where to start looking?

 Thanks.

                        --j
