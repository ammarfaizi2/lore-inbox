Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbWF1GBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWF1GBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbWF1GBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:01:05 -0400
Received: from wasp.net.au ([203.190.192.17]:63165 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S932732AbWF1GBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:01:02 -0400
Message-ID: <44A21B0F.20304@wasp.net.au>
Date: Wed, 28 Jun 2006 10:00:47 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion
 in	-mm
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627190323.GA28863@elf.ucw.cz>
In-Reply-To: <20060627190323.GA28863@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Tue 2006-06-27 19:22:37, Brad Campbell wrote:
>> Pavel Machek wrote:
>>>> Some of the advantages of suspend2 over swsusp and uswsusp are:
>>>>
>>>> - Speed (Asynchronous I/O and readahead for synchronous I/O)
>>> uswsusp should be able to match suspend2's speed. It can do async I/O,
>>> etc...
>> ARGH!
>>
>> And the next version of windows will have all the wonderful features that 
>> MacOSX has now so best not upgrade to Mac as you can just wait for the next 
>> version of windows.
>>
>> suspend2 has it *now*. It works, it's stable.
> 
> uswsusp also has it *now*, in case you missed it. I just do not do
> benchmark runs all the time, and don't know how fast suspend2
> is. uswsusp already uses normal I/O ... and that is asynchronous.

Perhaps I was a little hasty then snipping the rest of your reply to Nigel.

You make a single point here regarding Speed, and you *may* be right. However you conveniently 
ignore all the other neat features of suspend2 that actually make it usable by stating that they 
"would/could/should" be available/doable in uswsusp. It's starting to sound like vapourware.

When I installed ubuntu 6.06 on my shiny new laptop, I pressed the hibernate button. The screen went 
black, the hard disk light locked on and it just sat there. I thought to myself "oh dear, it's 
locked up" so I pulled the battery out and restarted the machine. (Ubuntu uses the in-kernel 
swsusp). It turns out the machine was actually hibernating. Who would have known? I told me nothing 
and behaved *exactly* like a machine hard-locked. So on this one box, the in-kernel suspend actually 
works, for certain definitions of works.

On resume there is a lovely swap storm as all my apps are swapped back in. If for some reason the 
machine decides not to suspend or has a problem while doing so, I don't know about it. It just sits 
there until the battery goes flat. No progress/error reports.

And of course on my other laptop it just does weird things. I could probably help debug it if I had 
the time or inclination, but seriously.. I simply add

deb http://dagobah.ucc.asn.au/ubuntu-suspend2 dapper/

.. to my /etc/apt/sources list and type apt-get install suspend2 and all of a sudden it works. (Most 
of my machines actually run self-patched/compiled kernels, but the installation is just as easy)

Not only works, but it gives me progress information. It actually *tells* me what it's doing.. (and 
what might have gone wrong, if something does). Fancy that! And if I've hit hibernate and think "Oh 
dear, I needed to add that appointment to my calendar", I can just tap the "esc" key and it will 
abort the hibernate and put everything back where it was.

Not to mention all my apps popping back exactly the way they were, with no loss in responsiveness 
while they swap back in as soon as the machine becomes live.

I know I might be one of these strange breed of people that actually like these features, but as 
much as I love hacking, I'm sick of having to beat my machines upside the head to figure out what is 
actually going on or even make them work. Suspend2 just gives it to me out of the box, and in 
combination with the hibernate script set it works 1st time, every time.

Yes, suspend2 is more complex than what is in the kernel.. but whadda ya know.. it works. Perhaps 
that extra complexity is there for a reason..

What I'd like to see really, rather than obstinate outright rejection, is people to actually look at 
Nigel's code and give valid technical commentary on what needs to be changed, and why it needs to be 
changed. Rather than "We can do this out of tree, so we'll not accept this code". You might be able 
to do it out of tree and make it work, but the number of people using suspend2 is a pretty good 
indicator that the current in-kernel code is sub-optimal.

People want a stable, reliable hibernate, and they want it *now*. Not in the next release, or when 
someone feels like hacking on it. A number of those same people use the external suspend2 patches, 
while the rest of the population simply pine for something that works.

I know I sound like a broken record, but this has already been done to death so many times while I 
stood on the sidelines and watched. I really felt the need to throw my worthless .2c into the ring.

Let's get something that actually works into the tree.. hell we had swsusp and pmdisk in there 
"competing" for a while, and I've seen discussion about a couple of ieee802.11 stacks. Why not give 
it a try.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
