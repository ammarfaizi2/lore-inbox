Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbRB1XFT>; Wed, 28 Feb 2001 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbRB1XFG>; Wed, 28 Feb 2001 18:05:06 -0500
Received: from gateway.sequent.com ([192.148.1.10]:29330 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129319AbRB1XEy>; Wed, 28 Feb 2001 18:04:54 -0500
Date: Wed, 28 Feb 2001 15:04:44 -0800
From: "Martin J. Bligh" <mbligh@mail.com>
Reply-To: "Martin J. Bligh" <mbligh@mail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Confused by local APIC addressing in setup_IO_APIC_irqs()
Message-ID: <4120141070.983372684@W-MBLIG.svc.sequent.com>
In-Reply-To: <4104841651.983357385@W-MBLIG.svc.sequent.com>
X-Mailer: Mulberry/2.0.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But cpu_online map seems to be a 32 bit bitmask of which
> CPUs are online .... are we stuffing this directly into an 8-bit
> logical desitination register?
>
> Ironically, if I'm understanding this right, it kind of works anyway
> for most systems - the low nibble of the logical ID is a bitmask
> anyway, so it works normally for up to 4 way. For 8 way or more,
> the high nibble will be set to 1111, which is the broadcast cluster ID,
> so it'll direct interrupts anywhere .... but I can't believe that was
> intentional ;-) For a start, a 7 way system would send to some
> non-existant cluster ID ....

Damn ... sorry - figured this out. The way Linux is doing it will work
up to 8 CPUs. I'd forgotten that earlier on in my changes I'd switched
the CPUs local APICs from FLAT logical addressing mode to
CLUSTERED logical addressing mode. I need to switch the IO APIC code
to match ...

Thanks,

Martin.

