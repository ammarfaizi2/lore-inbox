Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWGEEID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWGEEID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 00:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWGEEID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 00:08:03 -0400
Received: from mail.tmr.com ([64.65.253.246]:52615 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932311AbWGEEIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 00:08:01 -0400
Message-ID: <44AB3BC9.2020602@tmr.com>
Date: Wed, 05 Jul 2006 00:10:49 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060701170729.GB8763@irc.pl>	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>	 <20060703205523.GA17122@irc.pl>	 <1151960503.3108.55.camel@laptopd505.fenrus.org>	 <44A9904F.7060207@wolfmountaingroup.com>	 <20060703232547.2d54ab9b.diegocg@gmail.com>	 <1152004929.3374.13.camel@elijah.suse.cz> <1152012907.23628.20.camel@lappy>
In-Reply-To: <1152012907.23628.20.camel@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Tue, 2006-07-04 at 11:22 +0200, Petr Tesarik wrote:
>> On Mon, 2006-07-03 at 23:25 +0200, Diego Calleja wrote:
>>> El Mon, 03 Jul 2006 15:46:55 -0600,
>>> "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribió:
>>>
>>>> Add a salvagable file system to ext4, i.e. when a file is deleted, you 
>>>> just rename it and move it to a directory called DELETED.SAV and recycle 
>>>> the files as people allocate new ones.  Easy to do (internal "mv" of 
>>>
>>> Easily doable in userspace, why bother with kernel programming
>> Yes and no. A simple mv is better done in userspace, but what I'd
>> _really_ appreciate would be a true kernel salvage (similar to the way
>> NetWare does things). That means marking the file as deleted in the
>> directory, marking its blocks as deleted but avoiding the use of those
>> blocks. The kernel would then prefer allocating new blocks from
>> elsewhere but once the filesystem runs out of space, it would start
>> allocating from the deleted files area and marking the blocks as well as
>> the corresponding files purged.
>>
>> Salvaging files would be done with a separate tool. Of course, if you
>> delete more files with the same name in the same directory, you'd need
>> to tell that tool which one of them you want to salvage. Yes, I really
>> mean you'd have more than one deleted file with the same name in the
>> directory.
>>
>> Anyway, I doubt we want such feature for ext4, because to make things
>> efficient, you'd need to provide some kind of pointer from the deleted
>> (but not yet purged) blocks to the corresponding file. Hard links are
>> also problematic and there is a whole lot of other troubles I haven't
>> even thought of.
> 
> Wouldn't such a scheme interfere with the block allocator algorithms,
> and hence increase the risk of fragmentation? Schemes like this realy
> put my hairs on end,
> 
>   1) if you don't want to lose your data, make backups; 
>   2) if I mean to delete a file, I want it gone proper. Silently keeping
>      it about is not unix like;
>   3) don't aid third parties in recovering your removed data. If I want
>      them to have it I'll give it to them.
> 
> Peter
> 
If you wanted to add a feature which would overwrite the file when 
removed or truncated I'd be happy. Yes I know about attributes and dban, 
and I have a version of rm which does that if people use it, but would 
be nice to have it on the whole filesystem. It's not proof against a 
TLA, but nice for casual snooping.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

