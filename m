Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVL3QSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVL3QSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 11:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVL3QSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 11:18:08 -0500
Received: from web34110.mail.mud.yahoo.com ([66.163.178.108]:38259 "HELO
	web34110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932257AbVL3QSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 11:18:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gB8jWJgpI2QjLZBVZmdxBqLXiOFAlf9+mFOETk/erjaCpl0vBMWCm7xOq2sNaRSC4BFujPwTnrqUvz8mNwCSsewBHmBQkNdXUDhh+rDBaeKJp8hZLpdyYq5sRrPNnhkA+rE5D2qc2JE0ZGx20+P6PRdQg74irXg9KwdST5e7ZN0=  ;
Message-ID: <20051230161805.64631.qmail@web34110.mail.mud.yahoo.com>
Date: Fri, 30 Dec 2005 08:18:05 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: RAID controller safety
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1135955866.28365.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   Specificly, I am looking at the Adaptec RAID controllers and their i2o drivers.  I am told
> the
> > kernel's i2o driver lacks a strong guarantee on fsync, and so far am unable to determine if
> the
> > dpt_i2o driver also falls short in this reguard.
> 
> Only dpt can tell you what their firmware actually does.

Yeah, I wasn't so much interrested in the firmware just yet, just interrested if the device driver
(dpt_i2o) gave it a fighting chance of doing the right thing.

> The i2o core drivers use the following rules

> i2o_block by default assumes the card is caching. It adopts write
> through mode if the controller has no battery, write back if it shows
> battery. This can be configured differently via ioctls including the
> ability to tune write through of large I/O's (to avoid cache thrashing),
> and to do write back with no battery backup for performance in cases
> where losing the data on a crash doesn't matter (eg swap)

That's what I read in the comments too, but looking at the code I only ever see it set to
write-back.  I verified this with blktool - our controllers have no battery, and blktool showed
the i2o-wcache state as write-back.

However, I was also told that the i2o_block driver lacks barrier support, so even in the
write-back case, the controller won't be told to flush/sync.

I was sent a patch against 2.6.10 that implements barrier support in i2o_block, but the code base
has shifted too much for me to make it apply.

-Kenny



	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
