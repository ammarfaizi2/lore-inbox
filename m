Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUB2Jwf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 04:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUB2Jwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 04:52:35 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:21402 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262027AbUB2Jw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 04:52:29 -0500
Date: Sun, 29 Feb 2004 17:52:13 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Arjan van de Ven" <arjanv@redhat.com>
Subject: Re: Why no interrupt priorities?
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>, mgross@linux.co.intel.com,
       tim.bird@am.sony.com, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com> <20040226190259.7965cc76.rddunlap@osdl.org> <opr34h04mx4evsfm@smtp.pacific.net.th> <20040229083656.GB7264@devserv.devel.redhat.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr34lpbmt4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040229083656.GB7264@devserv.devel.redhat.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004 09:36:57 +0100, Arjan van de Ven <arjanv@redhat.com> wrote:

> On Sun, Feb 29, 2004 at 04:32:54PM +0800, Michael Frank wrote:
>>
>> Most interrupt controllers can read back IRQ's to see whether it is
>> active. A shared IRQ would be readback active while any device
>> connected to it desires service.
>>
>> x86 example for 8259A AT-PIC's Returns the state of IRQ0-15 in ax
>> Note that jmp $+2 is only needed on some old 286/386 hardware
>> to meet (real) 8259A cycle time requirements.
>>
>> - Intel syntax :)
>>
>> 	mov	al,0ah
>> 	out	0a0h,al
>> 	jmp	$+2
>> 	in	al,0a0h
>> 	mov	ah,al
>> 	mov 	al,0ah
>> 	jmp	$+2
>> 	out 	20h,al
>> 	jmp	$+2
>> 	in 	al,20h
>
> interesting; however with modern cpus I suspect that a series of in/outs
> like that is more expensive than one or two "surious" hardirq handler
> calls...
>

Yes, Four 8259A IO cycles would take almost 2us, which is several 1000
instructions worth of burning electricity.

Racehorse is still best at going straight :)

However on-chipset PIC's may be better and in on-CPU APICs should be
much better in this regard, but I have not studied data(sheet).

Regards
Michael


