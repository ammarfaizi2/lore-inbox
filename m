Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUDNPdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbUDNPdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:33:06 -0400
Received: from p4.ensae.fr ([195.6.240.202]:11717 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S264254AbUDNPci convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:32:38 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: Using compression before encryption in device-mapper
Date: Wed, 14 Apr 2004 17:32:36 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <200404141602.43695.Guillaume@Lacote.name> <407D5756.6030604@grupopie.com>
In-Reply-To: <407D5756.6030604@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404141732.36086.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your feed-back.
Le Mercredi 14 Avril 2004 17:23, Paulo Marques a écrit :
> Guillaume Lacôte wrote:
> >...
> > Actually (see my reply to Timothy Miller) I really want to do
> > "compression" even if it does not reduce space: it is a matter of growing
> > the per-bit entropy rather than to gain space (see
> > http://jsam.sourceforge.net). Moreover I do not want to use sophisticated
> > algorithms (in order to be able to compute plain text random
> > distributions that ensure that the compressed distributions will be
> > uniform, which is very difficult with for e.g zlib; in particular having
> > any kind of "meta-data", "signatures" or "dictionnary" is a no-go for
> > me). See details at the end of this post.
>
> Point taken
Please see the critic by Pascal Schmidt, as I think he has a point ...

> > Would it be possible for you to point me to the relevant material ?
>
> I just need to tidy it up a little :)
>
> Maybe I can publish it tomorrow or something like that.
Since I will be on holiday until the end of April please feel free to take 
your time (although I stay highly interested).

>
> >....
> >
> >>2 - The compression layer should report a large block size upwards, and
> >> use a little block size downwards, so that compression is as efficient
> >> as possible. Good results are obtained with a 32kB / 512 byte ratio.
> >> This can cause extra read-modify-write cycles upwards.
> >
> > I failed to understand; could you provide me with more details please ?
>
> If we are to compress on a block basis, the bigger the block the higher the
> compression ratio we'll be able to achieve (using zlib, for instance).
> However, data sent to the actual block device will have to go in blocks
> itself.
On the other hand, since I will need to interleave random data "quite often" I 
prefer my blocks not be too large (although this shall be a choice for the 
end-user).
>
> For instance, if we compress a 32kB block and it only needs 8980 bytes to
> be stored, we need 18 512byte blocks to store it. On average, we will lose
> 1/2 of the actual block size per "upper level" block size bytes of data. In
> a 32kB/512 byte ratio, we would lose on average 256 bytes per 32kb of data
> ~ 0.8% (which is more than acceptable).
I got it, thank you.
>
> >>...
> >
> > As I said earlier I my point is definetely not to gain space, but to grow
> > the "per-bit entropy". I really want to encode my data even if this grows
> > its length, as is done in http://jsam.sourceforge.net . My final goal is
> > the following: for each plain block first draw a chunk of random bytes,
> > and then compresse both the random bytes followed by the plain data with
> > a dynamic huffman encoding. The random bytes are _not_ drawn uniformly,
> > but rather so that the distribution on huffman trees (and thus on
> > encodings) is uniform. This ensures (?) that an attacker really has not
> > other solution to decipher the data than brute-force: each and every key
> > is possible, and more precisely, each and every key is equi-probable.
>
> Ok, we are definitely fighting different wars here.
>
> Anyway, I'll try to gather what I did with the network block device server
> and place it somewhere where you can look at it. It will probably help you
> do some tests, too.
Thank you in advance.
> Because it is a block device in "user space", it is 
> much simpler to develop and test different approaches, and gather some
> results, before trying things inside the kernel.
You are right.
>
> If you want to start now, just go to:
>
> http://nbd.sourceforge.net/
>
> and download the source for the network block device server. My server is
> probably more complex than the original, because of all the metadata
> handling.
I will to this once I come back from holidays (no net there).
>
> I hope this helps,
It does, thank you.
Guillaume.

