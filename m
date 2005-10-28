Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVJ1UTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVJ1UTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVJ1UTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:19:47 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:23799 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750708AbVJ1UTq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:19:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OMNmZu46fnDx86UUUfMKkVm6cW3yLiZUwNpZDuDwGSCUf4JLyCwAuLzuMAIp0/p/QNEuFh6LzQ4c7FVjjJpK2o4u+KKjgBnNEIv1dC3HX/LV4Hb4E/S1c2ZbyMCFD1UNHeqob3cJKvccXZpUOENA62Ecomb1Xh9dA+6cBTy5rIw=
Message-ID: <86802c440510281319y667427fj38ffd7a37b8cb77b@mail.gmail.com>
Date: Fri, 28 Oct 2005 13:19:45 -0700
From: Yinghai Lu <yinghai.lu@amd.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: x86_64: calibrate_delay_direct and apic id lift for BSP
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
In-Reply-To: <6F7DA19D05F3CF40B890C7CA2DB13A4201E061EC@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6F7DA19D05F3CF40B890C7CA2DB13A4201E061EC@ssvlexmb2.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if 8111 only support 4 bit apicid, so it can not send irq to
BSP at apic id 0x10....

YH

On 10/28/05, Lu, Yinghai <yinghai.lu@amd.com> wrote:
> I have tried latest code..., except that, it works well.
>
> YH
>
> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de]
> Sent: Friday, October 28, 2005 11:53 AM
> To: Lu, Yinghai
> Cc: discuss@x86-64.org; linux-kernel@vger.kernel.org;
> linuxbios@openbios.org
> Subject: Re: x86_64: calibrate_delay_direct and apic id lift for BSP
>
> On Friday 28 October 2005 20:42, Yinghai Lu wrote:
> > andi,
> >
> > I tried to lift apic id in LinuxBIOS for all cpus after 0x10.
> >
> > When using MB with AMD8111, the jiffies was not moving. So it is
> > locked at calibrate_delay_direct...
>
> Have you tried it with 2.6.14? It has some new code to handle
> high apic ids better
>
> > but  MB with Nvidia ck804, jiffies is moving.
>
> The timer is wired different on nvidia than on 8111. They can
> go either through the 8259 or through the IOAPIC.  There is still
> some code that falls back to the 8259 if IOAPIC doesn't work,
> which may make it appear working on Nvidia.
>
> As a warning I'm about to remove that code so don't rely on it.
>
> > If I don't change BSP apic id ( keep it to 0), It changes....
> >
> > I have no idea how the jiffies changes, there is another thread change
> it....?
>
> They change when interrupt 0 fires. So it's probably misrouted
> or similar.
>
>
> -Andi
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
