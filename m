Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWJVJJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWJVJJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWJVJJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:09:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:17588 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932306AbWJVJJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:09:23 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <453B352A.5050700@s5r6.in-berlin.de>
Date: Sun, 22 Oct 2006 11:08:58 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Subject: Re: NULL pointer dereference in sysfs_readdir
References: <4539DDC5.80207@s5r6.in-berlin.de> <200610212204.56772.mb@bu3sch.de> <453A8CA7.5070108@s5r6.in-berlin.de> <200610212325.18976.mb@bu3sch.de>
In-Reply-To: <200610212325.18976.mb@bu3sch.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Saturday 21 October 2006 23:09, Stefan Richter wrote:
...
>>>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188140
[hard lockups, also one oops: 'Unable to handle kernel NULL pointer
dereference at virtual address 00000020', 'EIP is at sysfs_readdir',
'Process hald']
...
>>> Maybe FC changed some of the structures. I couldn't find
>>> a used structure with an interresting member at offset 00000020, at least.
>> Could be struct sysfs_dirent.s_dentry if I'm counting correctly in
>> http://www.linux-m32r.org/lxr/http/source/include/linux/sysfs.h?v=2.6.16#L68
>> The trace was from 2.6.16.
> 
> Yeah, I found that offset, too, but:
> 
> There is only one usage of s_dentry
> if (next->s_dentry)
> 
> But _before_ that there already comes
> if (!next->s_element)
> 
> So, if "next" was NULL, it would already oops there.

What if "next" became NULL afterwards? I know it's unlikely (but so is
the whole bug, given that we have just one reporter despite the bug's
age), but is it impossible? IOW does sysfs_readdir have any indirect
mutex protection?

Dave, do you patch sysfs datatypes in FC's kernel, or types they include?
-- 
Stefan Richter
-=====-=-==- =-=- =-==-
http://arcgraph.de/sr/
