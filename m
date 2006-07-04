Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWGDGY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWGDGY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWGDGY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:24:27 -0400
Received: from neo-u2.ops-netman.net ([63.95.249.169]:23779 "EHLO
	neo-u2.ops-netman.net") by vger.kernel.org with ESMTP
	id S1751222AbWGDGY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:24:26 -0400
Date: Tue, 4 Jul 2006 06:24:25 +0000 (GMT)
From: Chris Morrow <morrowc@ops-netman.net>
To: morrowc+kernel@ops-netman.net
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashes of 2.4.31hf2.6  kernel (oops included)
In-Reply-To: <Pine.LNX.4.61.0607040615090.23681@arb-h2.bcf-argzna.arg>
Message-ID: <Pine.LNX.4.61.0607040620390.23681@arb-h2.bcf-argzna.arg>
References: <Pine.LNX.4.61.0607040139320.13542@arb-h2.bcf-argzna.arg>
 <20060704040953.GA2037@1wt.eu> <Pine.LNX.4.61.0607040615090.23681@arb-h2.bcf-argzna.arg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jul 2006 morrowc+kernel@ops-netman.net wrote:
>
> On Tue, 4 Jul 2006, Willy Tarreau wrote:
>
>> On Tue, Jul 04, 2006 at 02:22:00AM +0000, morrowc+kernel@ops-netman.net 
>> wrote:
>> Do all the oops report a crash in tcp_synack_timer() ? This one got a
>> wrong pointer for the call to req->class->rtx_syn_ack(). This really

apologies, I didn't catch the EIP pointer in your message, looking at the 
included 06/29 oops/ksymoops output I see:

grep -i EIP output-ksymoops-06-29-02
00000000 <_EIP>:
00000000 <_EIP>:

So, no relevant output on that one :( Looking all all after 06/15:

output-ksymoops-06-24:EIP:    0010:[<30246c8b>]    Not tainted
output-ksymoops-06-24:>>EIP; 30246c8b Before first symbol   <=====
output-ksymoops-06-25-01:EIP:    0010:[<c0122485>]    Not tainted
output-ksymoops-06-25-01:>>EIP; c0122485 <add_timer+55/110>   <=====
output-ksymoops-06-25-01:00000000 <_EIP>:
output-ksymoops-06-27-2006:00000000 <_EIP>:
output-ksymoops-06-27-2006:00000000 <_EIP>:
output-ksymoops-06-29-01:EIP:    0010:[<c0122f20>]    Not tainted
output-ksymoops-06-29-01:>>EIP; c0122f20 <count_active_tasks+20/50> <=====
output-ksymoops-06-29-02:00000000 <_EIP>:
output-ksymoops-06-29-02:00000000 <_EIP>:
output-ksymoops-2006-07-03-01.txt:EIP:    0010:[<c024b03f>]    Not tainted
output-ksymoops-2006-07-03-01.txt:>>EIP; c024b03f <tcp_synack_timer+ff/1f0>   <=====
output-ksymoops-2006-07-03-01.txt:00000000 <_EIP>:
output-ksymoops-2006-07-03-01.txt:   5:   0f 85 8b 00 00 00         jne   96 <_EIP+0x96>

only the 07/03-01 points at synack-timer. This might mean it's more memory 
related than anything else, eh?

