Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSCFV21>; Wed, 6 Mar 2002 16:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310205AbSCFV2T>; Wed, 6 Mar 2002 16:28:19 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:15346 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310202AbSCFV2J>; Wed, 6 Mar 2002 16:28:09 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200203062025.PAA03727@ccure.karaya.com> 
In-Reply-To: <200203062025.PAA03727@ccure.karaya.com> 
To: Jeff Dike <jdike@karaya.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com (H. Peter Anvin),
        bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Wed, 06 Mar 2002 21:27:41 +0000
Message-ID: <6920.1015450061@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jdike@karaya.com said:
>  Yeah, MADV_DONTNEED looks right.  UML and Linux/s390 (assuming VM has
> the equivalent of MADV_DONTNEED) would need a hook in free_pages to
> make that happen. 

       MADV_DONTNEED
              Do  not expect access in the near future.  (For the
              time being, the application is  finished  with  the
              given range, so the kernel can free resources asso­
              ciated with it.)

It's not clear from that that the host kernel is actually permitted to
discard the data.

alan@lxorguk.ukuu.org.uk said:
>  VM allows you to give it back a page and if you use it again you get
> a clean copy. What it seems to lack is the more ideal "here have this
> page and if I reuse it trap if you did throw it out" semantic. 

I've wittered on occasion about other situations where such semantics might
be useful -- essentially 'drop these pages if you need to as if they were
clean, and tell me when I next touch them so I can recreate their data'. 

UML might want that kind of thing for its (clean) page cache pages or 
something, but for pages allocated for kernel stack and task struct we 
really want the opposite -- we want to make sure they're present when we 
allocate them, and explicitly discard them when we're done.

--
dwmw2


