Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWC2VjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWC2VjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWC2VjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:39:13 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52622 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751005AbWC2VjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:39:13 -0500
Subject: Re: [Devel] Re: [RFC] Virtualization steps
From: Sam Vilain <sam@vilain.net>
To: Kirill Korotaev <dev@sw.ru>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@openvz.org>,
       devel@openvz.org, Kir Kolyshkin <kir@sacred.ru>,
       linux-kernel@vger.kernel.org
In-Reply-To: <442A9E1E.4030707@sw.ru>
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	 <1143228339.19152.91.camel@localhost.localdomain>
	 <4428BB5C.3060803@tmr.com> <4428DB76.9040102@openvz.org>
	 <1143583179.6325.10.camel@localhost.localdomain>
	 <4429B789.4030209@sacred.ru>
	 <1143588501.6325.75.camel@localhost.localdomain>
	 <442A4FAA.4010505@openvz.org> <20060329134524.GA14522@MAIL.13thfloor.at>
	 <442A9E1E.4030707@sw.ru>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 09:37:52 +1200
Message-Id: <1143668273.9969.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 18:47 +0400, Kirill Korotaev wrote:
> >> I wonder what is the value of it if it doesn't do guarantees or QoS?
> >> In our experiments with it we failed to observe any fairness. 
> > 
> > probably a misconfiguration on your side ...
> maybe you can provide some instructions on which kernel version to use 
> and how to setup the following scenario:
> 2CPU box. 3 VPSs which should run with 1:2:3 ratio of CPU usage.

Ok, I'll call those three VPSes fast, faster and fastest.

"fast"    : fill rate 1, interval 3
"faster"  : fill rate 2, interval 3
"fastest" : fill rate 3, interval 3

That all adds up to a fill rate of 6 with an interval of 3, but that is
right because with two processors you have 2 tokens to allocate per
jiffie.  Also set the bucket size to something of the order of HZ.

You can watch the processes within each vserver's priority jump up and
down with `vtop' during testing.  Also you should be able to watch the
vserver's bucket fill and empty in /proc/virtual/XXX/sched (IIRC)

> > well, do you have numbers?
> just run the above scenario with one busy loop inside each VPS. I was 
> not able to observe 1:2:3 cpu distribution. Other scenarios also didn't 
> showed my any fairness. The results were different. Sometimes 1:1:2, 
> sometimes others.

I mentioned this earlier, but for the sake of the archives I'll repeat -
if you are running with any of the buckets on empty, the scheduler is
imbalanced and therefore not going to provide the exact distribution you
asked for.

However with a single busy loop in each vserver I'd expect the above to
yield roughly 100% for fastest, 66% for faster and 33% for fast, within
5 seconds or so of starting those processes (assuming you set a bucket
size of HZ).

Sam.

