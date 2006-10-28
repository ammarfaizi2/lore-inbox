Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751985AbWJ1IXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbWJ1IXu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 04:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWJ1IXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 04:23:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:5215 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751985AbWJ1IXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 04:23:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=E25IqLOzMRPq7D/ieuaOj9sUNBMCvcqG6S7R2Z1u3fIBPpZQI1KhfvblLw9/dsm4O21Dlwua1HH56TOZ6891wfo5zkJfQUEXv9GPhTtqbezv7hmWktz56n1cKKoAsm9oE1suEEj/khPc5LbtIV0HIU/pV20XePVaeP5aVIeigI0=
Message-ID: <86802c440610280123m3051f6cj8d361b06b347186f@mail.gmail.com>
Date: Sat, 28 Oct 2006 01:23:47 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: linux-2.6.19-rc2 tg3 problem
Cc: "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       "David Miller" <davem@davemloft.net>
In-Reply-To: <b6a2187b0610271805w154ca251tb7db33ed0926623@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
	 <20061025013022.GG27968@stusta.de>
	 <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com>
	 <20061026152455.GI27968@stusta.de>
	 <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com>
	 <20061027203109.GZ27968@stusta.de>
	 <b6a2187b0610271805w154ca251tb7db33ed0926623@mail.gmail.com>
X-Google-Sender-Auth: 3629b5f122702d54
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/06, Jeff Chua <jeff.chua.linux@gmail.com> wrote:

it seems       pci_assign_unassigned_resource ( in
drivers/pci/setup-bus.c) is getting to smart to allocate more
unassigned resource that is not allocated by BIOS.

YH

> PCI: Bridge: 0000:00:01.0
>   IO window: disabled.
>   MEM window: fe900000-fe9fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.0
>   IO window: disabled.
>   MEM window: fe800000-fe8fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.1
>   IO window: disabled.
>   MEM window: fe700000-fe7fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1e.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.

===>

151a170,179
> PCI: Cannot allocate resource region 8 of bridge 0000:00:01.0
> PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
> PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
> PCI: Cannot allocate resource region 0 of device 0000:00:02.0
> PCI: Cannot allocate resource region 3 of device 0000:00:02.0
> PCI: Cannot allocate resource region 0 of device 0000:00:02.1
> PCI: Cannot allocate resource region 0 of device 0000:00:1d.7

> PCI: Cannot allocate resource region 2 of device 0000:00:1e.2
> PCI: Cannot allocate resource region 3 of device 0000:00:1e.2
> PCI: Cannot allocate resource region 0 of device 0000:02:00.0
164a193,199
> PCI: Failed to allocate mem resource #8:100000@e1000000 for 0000:00:1c.0
> PCI: Failed to allocate mem resource #0:80000@e1000000 for 0000:00:02.0
> PCI: Failed to allocate mem resource #0:80000@e1000000 for 0000:00:02.1
> PCI: Failed to allocate mem resource #3:40000@e1000000 for 0000:00:02.0
> PCI: Failed to allocate mem resource #0:400@e1000000 for 0000:00:1d.7
> PCI: Failed to allocate mem resource #2:200@e1000000 for 0000:00:1e.2
> PCI: Failed to allocate mem resource #3:100@e1000000 for 0000:00:1e.2
167c202
<   MEM window: fe900000-fe9fffff
---
>   MEM window: disabled.
168a204
> PCI: Failed to allocate mem resource #0:10000@0 for 0000:02:00.0
171c207
<   MEM window: fe800000-fe8fffff
---
>   MEM window: disabled.
175c211
<   MEM window: fe700000-fe7fffff
---
>   MEM window: disabled.
