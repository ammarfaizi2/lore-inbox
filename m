Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRALTEc>; Fri, 12 Jan 2001 14:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbRALTEX>; Fri, 12 Jan 2001 14:04:23 -0500
Received: from [213.253.36.78] ([213.253.36.78]:53255 "HELO
	blackhole.uknet.spacesurfer.com") by vger.kernel.org with SMTP
	id <S130072AbRALTEM>; Fri, 12 Jan 2001 14:04:12 -0500
Message-ID: <3A5F55AF.9651CCF1@spacesurfer.com>
Date: Fri, 12 Jan 2001 19:06:23 +0000
From: Patrick <patrick@spacesurfer.com>
Reply-To: pim@uknet.spacesurfer.com
Organization: SpaceSurfer Ltd.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel oops in tcp_ipv4.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a medium-high traffic web server on an SMP machine. I have
always had problems with linux hanging (No syslog messages and no
console response). I have tried kernel versions 2.2.12, 2.2.14 and
2.2.16
Recently I tried 2.2.17, this kernel was up for about a month, before
there was a kernel oops. The syslog messages are:

Jan 11 21:10:06 ws2 kernel: tcp_v4_hash: bug, socket state is 1 
Jan 11 21:10:06 ws2 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000 
Jan 11 21:10:06 ws2 kernel: current->tss.cr3 = 0ca7c000, %cr3 = 0ca7c000 
Jan 11 21:10:06 ws2 kernel: *pde = 00000000 
Jan 11 21:10:06 ws2 kernel: Oops: 0002 
Jan 11 21:10:06 ws2 kernel: CPU:    0 

The code that outputs the first message is in tcp_ipv4.c, and was added
in version 2.2.17. The code deliberately causes a kernel oops when it
encounters this bug, presumably because the IP stack is unusable at this
point.

If this code was deliberately added then presumably someone knows what
might cause the problem. Is there a patch somewhere that fixes this
problem?

regards,
Patrick

-- 
Patrick Mackinlay                                patrick@spacesurfer.com
ICQ: 59277981                                        tel: +44 7050699851
                                                     fax: +44 7050699852
SpaceSurfer Limited                          http://www.spacesurfer.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
