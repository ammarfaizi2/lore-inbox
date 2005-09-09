Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbVIIVjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbVIIVjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVIIVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:39:15 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:29755 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030347AbVIIVjO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:39:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XjYNg7cHAufenbpdwdIs+h7Bx1ipv+uB/6abCFn29RV5X1IL4sGfjsfN2IQ0vRVJ9ouMkS+V9UjI+kVOZyg7ccI+79zm8bxPT2ePrzoLKe6rpqwVq0fHWzu6AiqKMDKjbEoxUhHyVTXLpSpOwB78ZPI/BauKeT2Ojz2J84O3BD4=
Message-ID: <5c49b0ed05090914394dba42bf@mail.gmail.com>
Date: Fri, 9 Sep 2005 14:39:07 -0700
From: Nate Diller <nate.diller@gmail.com>
Reply-To: nate.diller@gmail.com
To: Roger Heflin <rheflin@atipa.com>
Subject: Re: kernel 2.6.13 buffer strangeness
Cc: awesley@acquerra.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432151B0.7030603@acquerra.com.au>
	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Roger Heflin <rheflin@atipa.com> wrote:
> 
> I saw it mentioned before that the kernel only allows a certain
> percentage of total memory to be dirty, I thought the number was
> around 40%, and I have seen machines with large amounts of ram,
> hit the 40% and then put the writing application into disk wait
> until certain amounts of things are written out, and then take
> it out of disk wait, and repeat when it again hits 40%, given your
> rate different it would be close to 40% in 50seconds.
> 
yes, on 2.6 there are two tunables which are important here. 
dirty_background_ratio is the threshold where the kernel will begin
flushing dirty buffers, so it should change how soon the disk becomes
active.  dirty_ratio changes when the write-throttling code kicks in,
which is what Anthony is seeing.  The purpose of the write throttling
code is to limit the dirtying process to disk bandwidth, so that is a
Feature.  Anthony, try *increasing* dirty_ratio, you can go up to 100,
but you could trigger an OOM if you let it get too high, so maybe try
setting it at 85 or so.  This should effectively disable the write
throttling and give you the bandwidth you want.

NATE

> And I think that you mean MB(yte) not Mb(it).
> 
>                            Roger
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org 
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> > Anthony Wesley
> > Sent: Friday, September 09, 2005 4:11 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: kernel 2.6.13 buffer strangeness
> > 
> > Thanks David, but if you read my original post in full you'll 
> > see that I've tried that, and while I can start the write out 
> > sooner by lowering /proc/sys/vm/dirty_ratio , it makes no 
> > difference to the results that I am getting. I still seem to 
> > run out of steam after only 50 seconds where it should take 
> > about 3 minutes.
> > 
> > regards, Anthony
> > 
> > --
> > Anthony Wesley
> > Director and IT/Network Consultant
> > Smart Networks Pty Ltd
> > Acquerra Pty Ltd
> > 
> > Anthony.Wesley@acquerra.com.au
> > Phone: (02) 62595404 or 0419409836
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in the body of a message to 
> > majordomo@vger.kernel.org More majordomo info at  
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
