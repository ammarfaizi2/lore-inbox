Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319517AbSH3JQJ>; Fri, 30 Aug 2002 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319518AbSH3JQJ>; Fri, 30 Aug 2002 05:16:09 -0400
Received: from [62.70.77.106] ([62.70.77.106]:48552 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S319517AbSH3JQI> convert rfc822-to-8bit;
	Fri, 30 Aug 2002 05:16:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [BUG+FIX] 2.4 buggercache sucks
Date: Fri, 30 Aug 2002 11:21:06 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200208291000.46618.roy@karlsbakk.net> <318656043.1030603363@[10.10.2.3]>
In-Reply-To: <318656043.1030603363@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208301121.06437.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I mean - this code solved _my_ problem. Without it the server OOMs within
> > minutes of high load, as explained earlier. I'd rather like a clean fix
> > in 2.4 than this, although it works.
>
> I'm sure Andrew could explain this better than I - he wrote the
> code, I just whined about the problem. Basically he frees the
> buffer_head immediately after he's used it, which could at least
> in theory degrade performance a little if it could have been reused.
> Now, nobody's ever really benchmarked that, so a more conservative
> approach is likely to be taken, unless someone can prove it doesn't
> degrade performance much for people who don't need the fix. One
> of the cases people were running scared of was something doing
> continual overwrites of a file, I think something like:
>
> for (i=0;i<BIGNUMBER;i++) {
> 	lseek (0);
> 	write 4K of data;
> }
>
> Or something.
>
> Was your workload doing lots of reads, or lots of writes? Or both?

I was downloading large files @ ~ 4Mbps from 20-50 clients - filesize ~3GB
the box has 1GB memory minus (no highmem) - so - 900 megs. After some time it 
starts swapping and it OOMs. Same happens with several userspace httpd's

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

