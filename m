Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270600AbRHYT3G>; Sat, 25 Aug 2001 15:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270988AbRHYT24>; Sat, 25 Aug 2001 15:28:56 -0400
Received: from mailf.telia.com ([194.22.194.25]:39115 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S270600AbRHYT2v>;
	Sat, 25 Aug 2001 15:28:51 -0400
Message-Id: <200108251929.f7PJT5Q06766@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: [PATCH][RFC] simpler __alloc_pages{_limit}
Date: Sat, 25 Aug 2001 21:24:40 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200108242253.f7OMrbQ20401@mailf.telia.com> <200108250055.f7P0tGh28170@mailg.telia.com> <20010825135508.5afe1988.skraw@ithnet.com>
In-Reply-To: <20010825135508.5afe1988.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturdayen den 25 August 2001 13:55, Stephan von Krawczynski wrote:
> On Sat, 25 Aug 2001 02:48:28 +0200
>
> 2) It does not really work around the basic problem of too
> many cached pages in case of heavy filesystem action, I do get the already
> known "kernel: __alloc_pages: 2-order allocation failed." by simply copying
> files a lot. 

Hi again,

I would like to see from were these higher order allocs comes from.
Please insert something like this:

                printk("pid=%d; __alloc_pages(gfp=0x%x, order=%ld, ...)\n", 
current->pid, gfp_mask, order);
                show_trace(NULL);

(You have something resembling the first line - I added this in the beginning
 of __alloc_pages, you may add it together with the error message)
If everything is ok (correct Symbols.map) you should be able to get
a symbolic call trace in /var/logs/messages
(some are false positives, but they can be filtered out manually)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
