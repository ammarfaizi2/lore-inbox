Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUAIUYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbUAIUYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:24:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264454AbUAIUYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:24:32 -0500
Date: Fri, 9 Jan 2004 15:24:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chuck Berg <chuck@encinc.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: HPT372 DMA corruption
In-Reply-To: <20040109150501.A5891@timetrax.localdomain>
Message-ID: <Pine.LNX.4.53.0401091517390.1022@chaos>
References: <20040109150501.A5891@timetrax.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Chuck Berg wrote:

> I have an HPT372 onboard a Soyo Dragon KT400 board. I get corruption when
> reading from drives on this controller. (I don't dare write, so I don't
> know if writes are affected as well). I'm using 2.6.1, but have experienced
> this problem with older kernels (at least it's not crashing anymore).
>
> Disabling DMA on these drives stops the corruption.
>
[SNIPPED...]

>
>  51642365   0 211
>  51642366   0 154
>  51642367   0 163
>  51642368   0 120
>  63700989   0 100
>  63700990   0 153
>  63700991   0 216
>  63700992   0   2
>  89260029   0  31
>  89260030   0 327
>  89260031   0 200
>  89260032   0  13
>

Since whole bytes are not written, this looks strangely like
an attempt to DMA to cached RAM! Since the CPU didn't write
to RAM, the cache doesn't "know" that somebody wrote to it
so the subsequent read comes from cache, not RAM. Somebody
who knows the KT400 software well, should verify that DMA-able
buffers are being used and the driver isn't writing directly
to a (ultimately) user buffer.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


