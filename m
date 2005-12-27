Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVL0Kz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVL0Kz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 05:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVL0Kz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 05:55:29 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:21085 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932166AbVL0Kz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 05:55:28 -0500
Message-ID: <43B11D9C.6000601@tls.msk.ru>
Date: Tue, 27 Dec 2005 13:55:24 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Mikado <mikado4vn@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-c-programming@vger.kernel.org
Subject: Re: How to obtain process ID that created a packet
References: <20051227014710.43609.qmail@web53708.mail.yahoo.com> <Pine.LNX.4.61.0512270925020.10069@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0512270925020.10069@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>The question is: when do you test for the PID? You would have to do it 
>>>within send(), because anywhere else, you do not know. A socket may be 
>>>shared among multiple processes (most simple way: fork()).
>>
>>I'm hooking in NF_IP_LOCAL_OUT of netfilter code using nf_register_hook() function.
> 
> 
> In sys_send(), I would have said you could use "current", but in netfilter 
> I can't tell exactly whether it is going to work on SMP.
> 
> Check net/ipv4/netfilter/ipt_owner.c, it provides a way to match packets vs 
> pids, but it's not easy to find out.

In current 2.6 kernel, net/ipv4/netfilter/ipt_owner.c:checkentry() :

        if (info->match & (IPT_OWNER_PID|IPT_OWNER_SID|IPT_OWNER_COMM)) {
                printk("ipt_owner: pid, sid and command matching "
                       "not supported anymore\n");
                return 0;
        }

So... even netfilter, breaking backward compatibility, does not support
pid match anymore...

/mjt
