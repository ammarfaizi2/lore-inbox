Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWANUkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWANUkv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWANUkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:40:51 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:22839 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1751094AbWANUku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:40:50 -0500
Message-ID: <43C961D2.90303@suse.com>
Date: Sat, 14 Jan 2006 15:40:50 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs mount time
References: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr> <20060114203410.GB21901@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060114203410.GB21901@atrey.karlin.mff.cuni.cz>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:
>   Hello,
> 
> 
>>brought to attentino on an irc channel, reiser seems to have the largest 
>>mount times for big partitions. I see this behavior on at least two 
>>machines (160G, 250G) and one specially-crafted virtual machine
>>(a 1.9TB disk / 1.9TB partition - took somewhere over 120 seconds).
>>Here's a dig http://linuxgazette.net/122/misc/piszcz/group001/image002.png 
>>from http://linuxgazette.net/122/TWDT.html#piszcz
>>So, any hint from the reiserfs developers how come reiserfs takes so long?
>>Standard mkreiserfs options (none extra passed).
> 
>   If I remember correctly, the problem is reiserfs loads bitmaps on mount
> and that takes most of the time. Jeff Mahoney <jeffm@suse.com> has
> patches fixing this but I think Hans rejected them because he wants only
> bugfixes in reiser3...

Yeah, that's the right analysis. ReiserFS caches bitmaps on mount and
for large file systems it can take a quite a long time. I've heard
reports of up to 15 minutes on multi-TB file systems.

As far as these patches getting accepted, Hans was opposed to them
initially, but emailed in September saying he decided that they should
be accepted after all.

These were against 2.6.12.1, and I remerged and split the patches out
yesterday evening. I'm going to do a bit of testing and send them out on
Monday for inclusion in -mm.

-Jeff

--
Jeff Mahoney
SUSE Labs
