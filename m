Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbQLQI0Y>; Sun, 17 Dec 2000 03:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQLQI0P>; Sun, 17 Dec 2000 03:26:15 -0500
Received: from terminus.net.au ([203.25.143.1]:65288 "EHLO
	mail.terminus.net.au") by vger.kernel.org with ESMTP
	id <S129933AbQLQI0A>; Sun, 17 Dec 2000 03:26:00 -0500
Date: Sun, 17 Dec 2000 15:55:14 +0800 (WST)
From: Jeremy Malcolm <terminus@terminus.net.au>
To: linux-kernel@vger.kernel.org
Subject: Kernel oops caused by wl24_cs driver
Message-ID: <Pine.LNX.4.21.0012171258320.17475-100000@terminus.net.au>
X-URL: http://sf.sig.au.mensa.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This probably isn't a supported driver, so please press "delete" if you
don't want to be bothered reading about a problem with an unsupported
driver.  Thanks.

I have compiled the wl24_cs wireless PCMCIA card driver from
http://relay.boerde.de/~matthias/airnet/zcom/ using kernel 2.2.17 and
pcmcia-cs-3.0.14 (the only version that it seems to compile with).  When I
insert the card I get the following (which I have fed through ksymoops):

...begins...
Dec 16 08:11:53 jeremy kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Dec 16 08:11:53 jeremy kernel: current->tss.cr3 = 03cb9000, %cr3 = 03cb9000
Dec 16 08:11:53 jeremy kernel: *pde = 00000000
Dec 16 08:11:53 jeremy kernel: Oops: 0000
Dec 16 08:11:53 jeremy kernel: CPU:    0
Dec 16 08:11:53 jeremy kernel: EIP:    0010:[coda:coda_upcall_stat+434971/145889781]
Dec 16 08:11:53 jeremy kernel: EFLAGS: 00010246
Dec 16 08:11:53 jeremy kernel: eax: 00000000   ebx: c2cc2000   ecx: ffffffff   edx: c0932000
Dec 16 08:11:53 jeremy kernel: esi: 00000006   edi: 00000000   ebp: c0903b18   esp: c0903918
Dec 16 08:11:53 jeremy kernel: ds: 0018   es: 0018   ss: 0018
Dec 16 08:11:53 jeremy kernel: Process cardmgr (pid: 187, process nr: 8, stackpage=c0903000)
Dec 16 08:11:53 jeremy kernel: Stack: 00000080 00000003 c3004800 00000004 c3004da0 c404f142 c3c4cbb0 c2cc202a 
Dec 16 08:11:53 jeremy kernel:        0000002b c3004da0 c3004c80 08000501 c0903903 c4047707 c3c4c800 c0903b28 
Dec 16 08:11:53 jeremy kernel:        c3c4c86c a0000fff c0903b28 c3c4c800 c3004c80 c4053141 00000000 00000006 
Dec 16 08:11:53 jeremy kernel: Call Trace: [coda:coda_upcall_stat+150626/146174126] [coda:coda_upcall_stat+119335/146205417] [coda:coda_upcall_stat+167009/146157743] [coda:coda_upcall_stat+169661/146155091] [coda:coda_upcall_stat+424964/145899788] [coda:coda_upcall_stat+115690/146209062] [coda:coda_upcall_stat+116642/146208110] 
Dec 16 08:11:53 jeremy kernel: Code: f2 ae f7 d1 49 88 4b 29 8b 35 b8 85 09 c4 8b bd 1c fe ff ff 

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	f2 ae                	repnz scas %es:(%edi),%al <===
Code:  00000002 Before first symbol               2:	f7 d1                	not    %ecx
Code:  00000004 Before first symbol               4:	49                   	dec    %ecx
Code:  00000005 Before first symbol               5:	88 4b 29             	mov    %cl,0x29(%ebx)
Code:  00000008 Before first symbol               8:	8b 35 b8 85 09 c4    	mov    0xc40985b8,%esi
Code:  0000000e Before first symbol               e:	8b bd 1c fe ff ff    	mov    0xfffffe1c(%ebp),%edi

68 warnings issued.  Results may not be reliable."
...ends...

Does this mean anything to anyone?  Many thanks for any replies (please cc
by email).

-- 
Independent consulting solicitor* | _ .__ ._ _    |\/| _.| _ _ |._ _
and technology consultant.**    \_|(/_|(/_| | |\/ |  |(_||(_(_)|| | |
Personal site: http://malcolm.wattle.id.au     /   Finger for GPG key
* http://www.ilaw.com.au ** http://www.terminus.net.au jm@ilaw.com.au



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
