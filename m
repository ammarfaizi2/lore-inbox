Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWHAXwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWHAXwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWHAXwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:52:09 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:49299 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S1750751AbWHAXwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:08 -0400
Message-ID: <44CFE8D9.9090606@mauve.plus.com>
Date: Wed, 02 Aug 2006 00:50:49 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: David Lang <dlang@digitalinsight.com>, Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of  view"expressed
 by kernelnewbies.org regarding reiser4 inclusion]
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>  <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>  <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>  <44CE7C31.5090402@gmx.de>  <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>  <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>  <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>  <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>  <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>  <20060801010215.GA24946@merlin.emma.line.org> <44CEAEF4.9070100@slaphack.com> <Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz> <44CED95C.10709@slaphack.com>
In-Reply-To: <44CED95C.10709@slaphack.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:
> David Lang wrote:
> 
>> On Mon, 31 Jul 2006, David Masover wrote:
>>
>>> Oh, I'm curious -- do hard drives ever carry enough 
>>> battery/capacitance to cover their caches?  It doesn't seem like it 
>>> would be that hard/expensive, and if it is done that way, then I 
>>> think it's valid to leave them on.  You could just say that other 
>>> filesystems aren't taking as much advantage of newer drive features 
>>> as Reiser :P
>>
>>
>> there are no drives that have the ability to flush their cache after 
>> they loose power.
> 
> 
> Aha, so back to the usual argument:  UPS!  It takes a fraction of a 
> second to flush that cache.

You probably don't actually want to flush the cache - but to write
to a journal.
16M of cache - split into 32000 writes to single sectors spread over
the disk could well take several minutes to write. Slapping it onto
a journal would take well under .2 seconds.
That's a non-trivial amount of storage though - 3J or so, 40mF@12V -
a moderately large/expensive capacitor.

And if you've got to spin the drive up, you've just added another
order of magnitude.

You can see why a flash backup of the write cache may be nicer.
You can do it if the disk isn't spinning.
It uses moderately less energy - and at a much lower rate, which
means the power supply can be _much_ cheaper. I'd guess it's the
difference between under $2 and $10.
And if you can use it as a lazy write cache for laptops - things
just got better battery life wise too.
