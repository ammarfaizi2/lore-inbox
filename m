Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSJIMBC>; Wed, 9 Oct 2002 08:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbSJIMBC>; Wed, 9 Oct 2002 08:01:02 -0400
Received: from michael.checkpoint.com ([199.203.73.68]:28086 "EHLO
	michael.checkpoint.com") by vger.kernel.org with ESMTP
	id <S261574AbSJIMBA>; Wed, 9 Oct 2002 08:01:00 -0400
From: "Ofer Raz" <oraz@checkpoint.com>
To: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Ofer Raz'" <oraz@checkpoint.com>
Cc: <wagnerjd@prodigy.net>, <linux-kernel@vger.kernel.org>
Subject: RE: FW: 2.4.9/2.4.18 max kernel allocation size
Date: Wed, 9 Oct 2002 14:06:08 +0200
Message-ID: <032101c26f8c$413e9440$8b705a3e@checkpoint.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <20021008121853.A23798@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done some additional testing.
In order to avoid huge allocations, I've tried allocating 100 blocks of 3MB
each on 2.4.18-10 using vmalloc.

On 1GB physical memory machine I can allocate only 80MB.
When adding memory limit to grub.conf (mem=999M) I get 900MB.

- Ofer


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Arjan van de Ven
Sent: Tuesday, October 08, 2002 6:19 PM
To: Ofer Raz
Cc: 'Arjan van de Ven'; wagnerjd@prodigy.net; linux-kernel@vger.kernel.org
Subject: Re: FW: 2.4.9/2.4.18 max kernel allocation size


On Tue, Oct 08, 2002 at 06:17:17PM +0200, Ofer Raz wrote:
> The following code was used in kernel module & called from IOCTL context
in
> order to test the max allocation size possible:

I think you misunderstood. I was asking for the source
of the PROBLEM you
were having, not the test. You are doing something wrong for needing
such a huge vmalloc area, but without the source (it
is gpl code, right?) nobody can do suggestions on how to improve your code.

>
> #define BLOCK_SIZE xxx
>
> for (size = BLOCK_SIZE; size; size--)
> {
>     tmp = vmalloc(size * 1024 * 1024);
>
>     if (tmp)
>     {
>         printk("Allocation of %dMB bytes succeeded!\n", size);
>         vfree(tmp);
>         break;
>     }
> }
>
y
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

