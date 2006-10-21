Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWJUV0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWJUV0I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 17:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbWJUV0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 17:26:08 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:49356
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1161074AbWJUV0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 17:26:07 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: NULL pointer dereference in sysfs_readdir
Date: Sat, 21 Oct 2006 23:25:18 +0200
User-Agent: KMail/1.9.5
References: <4539DDC5.80207@s5r6.in-berlin.de> <200610212204.56772.mb@bu3sch.de> <453A8CA7.5070108@s5r6.in-berlin.de>
In-Reply-To: <453A8CA7.5070108@s5r6.in-berlin.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610212325.18976.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 23:09, Stefan Richter wrote:
> Michael Buesch wrote:
> > On Saturday 21 October 2006 10:43, Stefan Richter wrote:
> ...
> >> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188140
> ...
> > Looking through the code I was not able to locate the exact line
> > at which it oopses, with the above oops message.
> > Are you able to track down the exact pointer dereference, which causes
> > this? By inserting printks, perhaps.
> 
> I need the original reporter to do this since I cannot reproduce the
> bug. Probably because I don't have an SMP machine yet.
> 
> > Maybe FC changed some of the structures. I couldn't find
> > a used structure with an interresting member at offset 00000020, at least.
> 
> Could be struct sysfs_dirent.s_dentry if I'm counting correctly in
> http://www.linux-m32r.org/lxr/http/source/include/linux/sysfs.h?v=2.6.16#L68
> The trace was from 2.6.16.

Yeah, I found that offset, too, but:

There is only one usage of s_dentry
if (next->s_dentry)

But _before_ that there already comes
if (!next->s_element)

So, if "next" was NULL, it would already oops there.

-- 
Greetings Michael.
