Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWAZQ1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWAZQ1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWAZQ1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:27:16 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15117 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964789AbWAZQ1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:27:15 -0500
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
References: <200601212108.41269.a1426z@gawab.com>
	<20060123162624.5c5a1b94.diegocg@gmail.com>
	<87zmlkq6yo.fsf@amaterasu.srvr.nix>
	<200601261713.03834.vda@ilport.com.ua>
From: Nix <nix@esperi.org.uk>
X-Emacs: the prosecution rests its case.
Date: Thu, 26 Jan 2006 16:23:57 +0000
In-Reply-To: <200601261713.03834.vda@ilport.com.ua> (Denis Vlasenko's
 message of "Thu, 26 Jan 2006 17:13:03 +0200")
Message-ID: <87u0brhs9u.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Denis Vlasenko announced authoritatively:
> On Thursday 26 January 2006 00:27, Nix wrote:
>> Well, to some extent it depends on your access patterns. The backup
>> program I use (`dar') is an enormous memory hog: it happily eats 5Gb on
>> my main fileserver (an UltraSPARC, so compiling it 64-bit does away with
>> address space sizing problems). That machine has only 512Mb RAM, so
>> you'd expect the thing would be swapping to death; but the backup
>> program's locality of reference is sufficiently good that it doesn't
>> swap much at all (and that in one tight lump at the end).
> 
> Totally insane proggie.

For incremental backups, it has to work out which files have been added
or removed across the whole disk; whether it stores this in temporary
files or in memory, if there's more file metadata than fits in physical
RAM, it'll be disk-bound working that out at the end no matter what you
do. And avoiding temporary files means you don't have problems with
those (growing) files landing in the backup.

(Now some of its design decisions, like the decision to represent things
like the sizes of files with a custom `infinint' class with a size of
something like 64 bytes, probably were insane. At least you can change
it at configure-time to use long longs instead, vastly reducing memory
usage to the mere 5Gb mentioned in that post...)

(Lovely feature set, shame about the memory hit.)

-- 
`Everyone has skeletons in the closet.  The US has the skeletons
 driving living folks into the closet.' --- Rebecca Ore
