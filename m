Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSJYBQB>; Thu, 24 Oct 2002 21:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSJYBQB>; Thu, 24 Oct 2002 21:16:01 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:12054 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265727AbSJYBQA>;
	Thu, 24 Oct 2002 21:16:00 -0400
Message-ID: <3DB89CD9.5090409@mvista.com>
Date: Thu, 24 Oct 2002 20:22:33 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: [PATCH] NMI request/release, version 6 - "Well I thought the last
 one was ready"
References: <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk> <3DB85213.4020509@mvista.com> <20021024202910.GA16192@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I have reworked all the NMI code, moved it to it's own file, and 
converted all the NMI users to use the NMI request/release code.  The 
current code will call call the NMI handlers on an NMI, interested 
parties may detect that their NMI occurred and handle it.  Since the NMI 
into the CPU is edge-triggered, I think that's the correct way to handle 
it (although it is slower).  If someone figures out another way, that 
would be very helpful.  The include/linux/nmi.h and 
arch/i386/kernel/nmi.c files were renamed to nmi_watchdog.h and 
nmi_watchdog.c.

The biggest hole (that I know of) in these changes is that there is no 
way that I can tell to detect if an nmi_watchdog has occurred if the NMI 
source is the I/O APIC.  That code will assume that if no one else has 
handled the NMI, it was the source, which is a bad assumption (but the 
same assumption that was being made before my changes, so it's no 
worse).  Most things should be using the local APIC, anyway.

It's now too big to include in an email, so it's at 
http://home.attbi.com/~minyard/linux-nmi-v6.diff.

-Corey

