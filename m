Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbUAIT6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbUAIT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:58:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40978 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263638AbUAIT6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:58:03 -0500
Message-ID: <3FFF07B2.70801@zytor.com>
Date: Fri, 09 Jan 2004 11:57:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: viro@parcelfarce.linux.theplanet.co.uk, Ian Kent <raven@themaw.net>,
       autofs mailing list <autofs@linux.kernel.org>,
       "Ogden, Aaron A." <aogden@unocal.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <3FFC96FE.9050002@zytor.com> <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net> <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk> <3FFF03EA.4060603@sun.com>
In-Reply-To: <3FFF03EA.4060603@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
>>
>> Special vfsmount mounted somewhere; has no superblock associated with it;
>> attempt to step on it triggers event; normal result of that event is to
>> get a normal mount on top of it, at which point usual chaining logics
>> will make sure that we don't see the trap until it's uncovered by removal
>> of covering filesystem.  Trap (and everything mounted on it, etc.) can
>> be removed by normal lazy umount.
>>
>> Basically, it's a single-point analog of autofs done entirely in VFS.
>> The job of automounter is to maintain the traps and react to events.
>>
> Is there any clear advantage to doing this in the VFS other than saving
> a superblock and a dentry/inode pair or two?
> 
> I remember talking to you about this, and I seem to recall that these
> mount traps would probably communicate using a struct file, so a
> trap-user would somehow receive events about when the trap was set
> off.   Will this communication model continue to work within a cloned
> namespace?  What happens if the trap-client closes the file?
> 

The biggest issue is to ensure that the appropriate atomicity guarantees
can be maintained.  In particular, it must be possible to umount the
underlying filesystem and all mount traps on top of it atomically.
Anything less will result in race conditions.

	-hpa

