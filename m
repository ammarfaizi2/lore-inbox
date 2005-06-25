Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263320AbVFYDiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbVFYDiV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 23:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbVFYDiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 23:38:21 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:4104 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263320AbVFYDiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 23:38:03 -0400
Message-ID: <42BCD198.9070208@slaphack.com>
Date: Fri, 24 Jun 2005 22:38:00 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>
In-Reply-To: <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
> David Masover <ninja@slaphack.com> wrote:
> 
>>Alan Cox wrote:
>>
>>>On Iau, 2005-06-23 at 23:04, David Masover wrote:
> 
> 
> [...]

[...]

>>>>"Ain't broke" is the battle cry of stagnation.
> 
> 
>>>Its also the battle cry of everyone over the age of 20 who also has a
>>>real job to do 8)
> 
> 
>>You caught me.  I'm not over 20.  But I have a real job, with a company
>>that understands the difference between "ain't broke" and "works well".
> 
> 
> "Doesn't work well" /is/ the definition of "broken". Modulo how irritating
> the "not working well" is...

Well, I agree with you there, but to most people, "broken" = "Doesn't
work at all."  Stagnation happens when people cling to the old way of
doing something until they are actually forced to change.

One example of this is energy.  Why do we still burn coal and oil?  Even
lithium ion batteries still give a 200-300 mile range on one electric
car I was looking at.  There is enough wind in Iowa alone to power half
the country, and if we were to put up a bunch of solar panels in Nevada,
we'd be done.  With the money we would save on not buying oil, we could
finish the fuel-cell technologies being worked on, and eventually, the
US would get its energy entirely from clean sources.

For that matter, we'd easily save enough money, not to mention the
public health benefits (no more smog), to pay for the transition
(building hydrogen pumping stations and such, buying new cars...)

But people don't like to change.  So we burn oil and make smog and choke
on our own stupidity.

That debate really belongs off-list, by the way.  All flames on this
topic, hit "reply", not "reply-to-all".

>>>>But, there are some things Reiser does better and faster than ext3, even
>>>>if you don't count file-as-directory and other toys.  There's nothing
>>>>ext3 does better than Reiser, unless you count the compatibility with
>>>>random bootloaders and low-level tools.
> 
> 
>>>Certainly compared with reiser3 you've missed a few out including
>>>resilience to disk errors (nearly nil on reiser3), and SMP scaling.
> 
> 
>>Actually, I was talking about reiser4.  And Hans corrected me on that...
>>
>>Although resilience to disk errors isn't a design decision.  That's what
>>SMART and new hard drives are for.  And if you're stubborn enough to
>>keep the same FS around, there's dm-bbr.
> 
> 
>>I think Hans (or someone) decided that when hardware stops working, it's
>>not the job of the FS to compensate, it's the job of lower layers, or
>>better, the job of the admin to replace the disk and restore from
>>backups.
> 
> 
> Handling other people's data this way is just reckless irresponsibility.
> Sure, you can get high performance if you just forego some of your basic
> responsibilities.

Who's responsibility?

It's the responsibility of the user to back up their files.  Sure, this
time it was just a little dust, but maybe next time it'll be coffee
spilled on the box.  Or maybe a power surge.  Maybe someone just gets
mad enough and kicks the computer very hard.

Reiser4 has been absolutely immune to power loss for me, and quite
stable in the face of some corruption, but as soon as I see bad blocks,
I throw out the disk, I don't try to make the FS deal with it.  And
that's all that's missing right now -- a way to use a disk which has
some bad blocks -- and that's implemented by dm-bbr if you're that stubborn.

Ultimately, disks are cheap.  Cheaper than data loss.

>>>>You know how many I've had thrashed on Reiser4?  Two.  The first one was
>>>>with a VERY early alpha/beta, and the second one was when I dropped a
>>>>laptop and the disk failed.
> 
> 
>>>Entirely or bad blocks ? The latter should have a minimal cost on a well
>>>designed fs.
> 
> 
>>I was able to recover from bad blocks, though of course no Reiser that I
>>know of has had bad block relocation built in...  But I got all my files
>>off of it, fortunately.
> 
> 
> And if the bad blocks had been on files? 

Then no FS would save me.

> [...]
> 
> 
>>>In which case the features belong in the VFS as all those with
>>>experience and kernel contributions have been arguing.

[...]

>>More infuriatingly, I, at least, have a distinct feeling that once all
>>the issues are fixed, an entirely different crowd of benevolent
>>dictators will come around and say that we can't get in because we
>>change the VFS.  At least some people on this list have said things to
>>that effect.
> 
> 
> The dictators here have changed over time, sure. Their general attitude has
> been the same all the way through, since the list started. And you might
> not like it that way, but I am sure Linux is of the current high quality
> exactly because any core code that gets into the kernel (and a new
> filesystem that wants to be central is clearly of this kind) is checked by
> multiple people with (sometimes widely) diverging backgrounds, interests,
> and views. Linus himself has stated more than once that his principal job
> isn't to integrate code into the kernel, but leaving stuff out.

I mean, half of the benevolent dictators at any given time don't seem to
like reiser4 for some reason or other.  I get the feeling that if we
satisfy that half, the way in which we do it will irritate the other
half.  But I don't know, and I'm going to leave the more specific
debates soon.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrzRmHgHNmZLgCUhAQIOyw//bL4sUYQyGSwjKnKZxTznzNnchn0rpNsx
PnxrQEvETtkqFlidToJPKDEP3H32tE5W3SeONhIprbQVOK9BagI5Ojm+AhM8pXXa
8K0NJmedlnjMJp5yAxbB+dIwPQ8IN8cG7cdeZCi4ij76yKiDFEqZHXrpm/bvXcbB
jzzOF86XPVfexGOUQkwDpR0gmFeY+zIp3+7TGKwG17xHYOej7KpyQctYB7e1me9t
MKFll/2USUAglvtdHQ6on2T9slmBTRMny4OFJXKnBTo6rILBTvo6sxC3hG2lv1lN
RYXHOd/AV/JQHzhZ1f1vRAn9VxdsUkMgvcOq3k3+ofUP86b1VqxsqGP4Mv3S8uka
hghTqBh7ivOr5llCwUHudDIXjRzNw1UBwi6UBC+YB0QQzR3vzc3Q0rvkD1v6hoV+
Li+sX0GhgjaIDzTE+e1rJOAlTAIxeQ9dRMDVBOR5b9HVtkxZ20SSdagDSeHz9JPH
Lv0JmqkvYgVf703a3wt56FpTIMd7XvY6dUSR9u3k1xUGQg2jeJA0gZ3tySSogKbT
xick+z+m1THTIyA5tXA1JRS1+GNAc4yCL4mHPcUKVWPsKfxaIDB4/+6eCll7Ctxz
XzP6s8nv4HkPAsWe1iLvJmuUXdiradC87MJiDGCKM6mbNZ0hFGnKa8zG8nI4C/Ua
qHz+cXVkgi8=
=QFCz
-----END PGP SIGNATURE-----
