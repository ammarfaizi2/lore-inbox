Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267969AbUHPWAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267969AbUHPWAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267970AbUHPWAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:00:12 -0400
Received: from mail.tmr.com ([216.238.38.203]:54284 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267969AbUHPWAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:00:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: SG_IO and security
Date: Mon, 16 Aug 2004 18:00:11 -0400
Organization: TMR Associates, Inc
Message-ID: <cfradk$97j$1@gatekeeper.tmr.com>
References: <411BA0F4.9060201@pobox.com><1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092693236 9459 192.168.12.100 (16 Aug 2004 21:53:56 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 12 Aug 2004, Jeff Garzik wrote:
> 
>>Linus Torvalds wrote:
>>
>>>On Thu, 12 Aug 2004, Linus Torvalds wrote:
>>>
>>>
>>>>Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).
>>>
>>>
>>>Btw, I think the _right_ thing to check is the write access of the file 
>>>descriptor. If you have write access to a block device, you can delete the 
>>>data, so you might as well be able to do the raw commands. And that would 
>>>allow things like "disk" groups etc to work and burn CD's.
>>
>>Define raw commands.  I certainly don't want non-root users to be able 
>>to issue FORMAT UNIT on my hard drive.
> 
> 
> Ehh? The same ones you allow to write all over the raw device?
> 
> Let's see now:
> 
> 	brw-rw----    1 root     disk       3,   0 Jan 30  2003 /dev/hda
> 
> would you put people you don't trust with your disk in the "disk" group?
> 
> Right. If you trust somebody enough that you give him write access to the 
> disk, then you might as well trust him enough to do commands on it. 
> 
> Conversely, if you don't trust him enough to do things like that, you 
> shouldn't give him write access in the first place.
> 
> It's a hell of a lot easier to destroy a disk with
> 
> 	dd if=/dev/zero of=/dev/xxx bs=8k
> 
> than it is to do it with some special malicious command. 
> 
> And yes, there's clearly a difference, but in general I'd say it is the 
> _data_ on the disk that is worth something to you. The disk itself? Do you 
> really fundamentally care?

I will offer two cases which is not wildly improbable. User complains 
the CD burner will {burn faster, burn brand X media, write HD mode} if 
the firmware is upgraded. User has write to burn CDs, decides to flash 
the firmware herself, turns CD into paperweight. Or possibly user tries 
to install CD firmware on a disk drive.

Case two, user is DBA, has write on raw partitions for Oracle, can 
mangle the whole device, and through some stupidity does.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
