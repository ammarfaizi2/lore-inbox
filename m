Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269568AbRHLX2J>; Sun, 12 Aug 2001 19:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269569AbRHLX2B>; Sun, 12 Aug 2001 19:28:01 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:27597 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S269568AbRHLX1t>; Sun, 12 Aug 2001 19:27:49 -0400
Message-Id: <200108122327.f7CNRvh15403@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: multiply NULL pointer
Date: Sun, 12 Aug 2001 19:28:14 -0400
X-Mailer: KMail [version 1.3]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3B72BA01.34D2A67F@pcsystems.de> <3B770C04.C8FDD6E6@zip.com.au>
In-Reply-To: <3B770C04.C8FDD6E6@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would that bug also affect httpd (read-heavy), or is it limited to 
write-heavy tasks?

Thanks,
	-- Brian

On Sunday 12 August 2001 07:06 pm, Andrew Morton wrote:
> Nico Schottelius wrote:
> > Hello!
> >
> > Running a p2 400 mhz box with a 3com 3c905, with
> > _very_ heavy nfs traffic and disc io the following NULL
> > pointers were produced. I attached the whole dmesg output.
> > If more informations are needed, I will send them.
> >
> > After every NULL pointer printed on the console
> > I took a new dmesg, so the one with the highest number
> > should be relevant.
>
> Please tell us exactly which kernel you're using.  It appears
> to be a flavour of 2.4.7 with ext3, yes?
>
> Also, please take the very first oops output which occurs
> after a reboot and feed that into
>
> 	ksymoops -m System.map < oops-trace-file.txt
>
> Make sure you have the correct System.map!
>
> The fact that your bdflush and kupdate daemons have gone zombie
> suggests that the kernel died in the new buffer flushing code.
> There was a bug fixed in that area late in the 2.4.8-pre series.
>
> From memory, the bug was a missing test for a null bh in
> fs/buffer.c:sync_old-buffers():
>
>         for (;;) {
>                 struct buffer_head *bh;
>
>                 spin_lock(&lru_list_lock);
>                 bh = lru_list[BUF_DIRTY];
>                 if (!bh || time_before(jiffies, bh->b_flushtime))
>                     ^^^^^^
>
> You should try 2.4.8.
>
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
