Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266084AbUAUTeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUAUTeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:34:16 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:50011 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S266084AbUAUTeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:34:06 -0500
Message-ID: <400ED428.20301@samwel.tk>
Date: Wed, 21 Jan 2004 20:34:00 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Micha Feigin <michf@post.tau.ac.il>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reiserfs support for laptop_mode
References: <20040117061354.GB4768@luna.mooo.com> <16395.45959.836058.398889@laputa.namesys.com> <20040121182846.GB29494@luna.mooo.com>
In-Reply-To: <20040121182846.GB29494@luna.mooo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin wrote:
> On Mon, Jan 19, 2004 at 01:37:59PM +0300, Nikita Danilov wrote:
> 
>>Micha Feigin writes:
>> > I've been using this since 2.4.22 and since laptop_mode is in the
>> > kernel since 2.4.23-pre<something> and I haven't seen that anyone else
>> > has implemented this so I decided to post it on the list in case anyone
>> > is interested.
>> > It a patch to modify the journal flush time of reiserfs to support
>> > laptop_mode (same functionality as ext3 has already).
>> > The times are taken from bdflush.
>>
>>Support for reiserfs laptop mode is in 2.6 now. It is done by adding new
>>mount option "commit=N" that sets commit interval in seconds.
>>
> 
> 
> First of all its nice to know that laptop mode has finally made it
> into 2.6. On the other hand setting commit=N on mount is not a good
> solution since you want different flush times for when laptop mode is
> activated and when it is disabled.
> When laptop mode is disabled the default of 5 seconds is good since the
> disk is always spinning. When laptop mode is enabled you want to change
> the journal flush time to the linux buffer flush time so that the
> journal won't keep waking up the disk. Its a bigger risk of loosing the
> data so you don't want the longer journal flush time when laptop mode
> isn't activated.
> 
> 
>>It doesn't look right to just plainly set reiserfs commit interval to be
>>the same as the ext3 commit interval.
> 
> 
> I am not setting it to the same value as ext3. When laptop mode isn't
> activated it is set to the default value used by reiserfs if bdflush
> isn't modified (it does give you the ability to play with the flush
> interval if you want even when reiserfs isn't activated).
> If laptop mode is activated the flush time is set to the linux buffer
> flush time so that the journal won't wake up the disk.

A couple of comments:

* You might want to take a look at Hugang's patch to support laptop mode 
on reiserfs in 2.6. This patch was posted somewhere last month. It adds 
a "commit=" option to reiserfs, so that you can change this externally 
by remounting. I think this solution is a lot cleaner than to have 
reiserfs code directly depend on laptop mode.

* If you decide to port that patch, you might want to look at the 
documentation for laptop mode in 2.6. The control script that's in there 
works for both 2.4 and 2.6, and it automatically remounts your ext3 and 
reiserfs filesystems with the appropriate commit options (and remounts 
them without the commit options when laptop mode is stopped). (There is 
also some ACPI event binding code in the documentation, which 
automatically enables laptop_mode when using battery power and disables 
it when your laptop is plugged in. I don't know if that works with 2.4 
though.)

-- Bart
