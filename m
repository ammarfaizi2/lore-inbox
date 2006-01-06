Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWAFVPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWAFVPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWAFVPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:15:23 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:19954 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932535AbWAFVPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:15:21 -0500
Date: Fri, 6 Jan 2006 13:11:17 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Adrian Bunk <bunk@stusta.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
In-Reply-To: <20060106180626.GV12131@stusta.de>
Message-ID: <Pine.LNX.4.62.0601061305480.334@qynat.qvtvafvgr.pbz>
References: <20060106173547.GR12131@stusta.de>
 <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com>
 <20060106180626.GV12131@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Adrian Bunk wrote:

> On Fri, Jan 06, 2006 at 06:49:55PM +0100, Jesper Juhl wrote:
>> On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
>>> Do not allow people to create configurations with CONFIG_BROKEN=y.
>>>
>>> The sole reason for CONFIG_BROKEN=y would be if you are working on
>>> fixing a broken driver, but in this case editing the Kconfig file is
>>> trivial.
>>>
>>> Never ever should a user enable CONFIG_BROKEN.
>>>
>> I disagree (slightly) with this patch for a few reasons:
>>
>> - It's very convenient to be able to enable it through menuconfig.
>
> And when do you really need it?

at various times over the years I've needed it to enable partially working 
drivers for several things.

>> - Being able to easily enable it in menuconfig, then browse through
>> the menus to look for something matching your hardware is nice, even
>> if that something is marked BROKEN at least you've then found a place
>> to start working on. A lot simpler than digging through directories.
>
> Our menus are mostly made for _users_.

true, but do you really want to raise the barrier for users to test 
things? or do you intend to have a bunch of patches that remove BROKEN for 
a config option so that people can test them during the -rc and then add 
it back for them all before a real release?

> The more common are users accidentially enabling CONFIG_BROKEN and then
> wondering why a driver isn't compiling or working.
>
> And in my experience, when searching whether hardware might be supported
> a grep through the kernel sources brings you more than reading often
> outdated Kconfig help texts. Besides this, a BROKEN driver usually has
> the same value for the user as a non-existing driver.

it depends on how broken something really is, in some cases you are 
correct, in others you aren't.

>> - Some things marked BROKEN may not be 100% broken and may actually
>> work for some specific things, so if you know that it works for your
>> use, then being able to easily enable BROKEN and then whatever it is
>> you need is nice.
>
> In reality, people accidentially turn on CONFIG_BROKEN, enable a broken
> driver, and wonder why it isn't working as expected.

so have CONFIG_BROKEN taint the kernel if you want to identify it in 
bugreports.

> If you know the driver is marked as BROKEN and if you want to use it
> despite this, editing the Kconfig file is trivial.
>
> Unless you _really_ know what you are doing, no driver for your hard
> disk is better than a broken driver.

for your hard drive you are probably right, but does this always apply for 
your network card? or your sound card?

>> Perhaps just move it below the Kernel Hacking menu instead, users
>> don't go there (or if they do they damn well should know what they are
>> doing).
>> ...
>
> Enabling MAGIC_SYSRQ for being able to sync the disks for crashed
> machines...

this is a reasonable option, although currently nothing in Kernel Hacking 
enables items in other menus. it's convienient that when useing menuconfig 
and working down from the top you first hit the selections that enable 
things in all the other menus (experimental and broken).

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

