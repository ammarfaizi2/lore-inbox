Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWFBHtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWFBHtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWFBHtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:49:40 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20390 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751280AbWFBHtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:49:39 -0400
Date: Fri, 2 Jun 2006 11:48:46 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Brian F. G. Bidulock" <bidulock@openss7.org>
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060602074845.GA17798@2ka.mipt.ru>
References: <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <87y7wgaze1.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87y7wgaze1.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 02 Jun 2006 11:48:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 07:40:38AM +0200, Florian Weimer (fw@deneb.enyo.de) wrote:
> * Evgeniy Polyakov:
> 
> > That is wrong. And I have a code and picture to show that, 
> > and you dont - prove me wrong :)
> 
> Here we go:
> 
> static inline num2ip(__u8 a1, __u8 a2, __u8 a3, __u8 a4)
> {
> 	__u32 a = 0;
> 
> 	a |= a1;
> 	a << 8;
> 	a |= a2;
> 	a << 8;
> 	a |= a3;
> 	a << 8;
> 	a |= a4;
> 
> 	return a;
> }
> 
> "gcc -Wall" was pretty illuminating. 8-P After fixing this and
> switching to a better PRNG, I get something which looks pretty normal.

:) thats true, but to be 100% honest I used different code to test for
hash artifacts...
That code was created to show that it is possible to _have_ artifacts,
but not specially to _find_ them.

But it still does not fix artifacts with for example const IP and random
ports or const IP and linear port selection.

Values must be specially tuned to be used with Jenkins hash, for example
linear port with const IP produce following hash buckets:
100 24397
200 12112
300 3952
400 975
500 178
600 40
700 3
800 1

i.e. one 800-entries bucket (!) while xor one always have only 100 of
them (for 100*hash_size number of iterations).

So, your prove does not valid :)

-- 
	Evgeniy Polyakov
