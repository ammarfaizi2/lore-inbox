Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUHZJdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUHZJdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268357AbUHZJau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:30:50 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:7611 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268015AbUHZJYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:24:42 -0400
Message-ID: <412DAC59.4010508@namesys.com>
Date: Thu, 26 Aug 2004 02:24:41 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com>	<20040825152805.45a1ce64.akpm@osdl.org>	<412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org>
In-Reply-To: <20040826014542.4bfe7cc3.akpm@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>> >To get us started on this route it would really help me (and, probably,
>> >others) if you could describe what these API extensions are in a very
>> >simple way, without referring to incomprehehsible web pages,
>> >
>> what is not comprehensible....?
>>    
>>
>
>Pretty much anything at www.namesys.com.  The amount of time which is
>needed to extract the technical info which one is looking for vastly
>exceeds a gnat-like attention span.
>
>As a starting point, please prepare a bullet-point list of
>userspace-visible changes which the filesystem introduces, or is planned to
>introduce.
>
>And describe the "plugin" system.  Why does the filesystem need such a
>thing (other filesystems get their features via `patch -p1')?
>  
>
It takes 6 months or more to become competent to change a usual 
filesystem.  Creating a new reiser4 plugin is a weekend programmer fun 
hack to do.  Weekend programmers matter, because they tend to have 
clever ideas based on understanding a need they have.   How many people 
can easily add new features to ext3 or reiserfs V3?  Very few. 

What happens if you need a disk format change?

Well, in V4, you can easily compose a plugin from plugin methods of 
other plugins, write a little piece of code with the one thing you want 
different, and add it in.  Disk format changes, no big deal, add a new 
disk format plugin, or a new item plugin, or a new node plugin, etc., 
and you got your new format.

There is a huge difference between code that is designed for reuse, and 
code that is not.  That is the difference between V3 and V4.  We were 
looking at our V3 balancing code, and it special cased each different 
kind of item (an item is a piece of something, which the balancing code 
chops objects into as it squeezes them into nodes).  It looked like the 
complexity of the balancing code was going to be N squared, where N was 
the number of different kinds of items.

So, we created item handlers, and wrote balancing code that could slice 
and dice and merge any item that implemented all of the operations 
required of an item handler.  From there it grew, and we made everything 
pluggable.

Adding features to the new code is far less than the time cost of adding 
features to the old code.  I've seen Nikita complain that something 
would take 6 weeks to do (changing key assignment algorithms), and then 
it takes him 3 afternoons, and it was because of the plugins, because 
when we did something similar in V3 it took 3 man months.

>And what are the licensing implications of plugins?  Are they derived
>works?  
>
Yes.

Hans
