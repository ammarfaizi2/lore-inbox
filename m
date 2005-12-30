Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVL3S6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVL3S6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVL3S6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:58:42 -0500
Received: from web34113.mail.mud.yahoo.com ([66.163.178.111]:29805 "HELO
	web34113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751285AbVL3S6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:58:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GOwsMSG3qykAbKJOjNd0jovsbLe4e5MT2j8s+bEyazH4Int6G5TZh7rrivwqpUlzlfsabRbp3KfJCZ5MvPJF0QVmX1VlbqIcDiymSVqZAfUpM8VkpUENED5m5qL/J3InaSXKgdCm5HINg0B5a7B9yeTSUKo4En3oxKlkBX5pQwI=  ;
Message-ID: <20051230185840.52264.qmail@web34113.mail.mud.yahoo.com>
Date: Fri, 30 Dec 2005 10:58:40 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: RAID controller safety
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1135966830.28365.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-12-30 at 08:18 -0800, Kenny Simpson wrote:
> > That's what I read in the comments too, but looking at the code I only ever see it set to
> > write-back.  I verified this with blktool - our controllers have no battery, and blktool
> showed
> > the i2o-wcache state as write-back.
> 
> blktool doesn't support i2o control as far as I am aware. The blk level
> generic ioctls are just too crude to control it properly.

>From man blktool dated August 2004:
       i2o-wcache
              Query or set an I2O block device's write cache.

> 
> > However, I was also told that the i2o_block driver lacks barrier support, so even in the
> > write-back case, the controller won't be told to flush/sync.
> 
> Correct, but it should only ever enable this in the battery backed case.
> Otherwise it uses the per command control bits to decide what mode it
> wishes to use for each I/O

So all writes would be treated as syncronous in the write-through case (no battery), making fsync
a no-op?

-Kenny



	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
