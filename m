Return-Path: <linux-kernel-owner+w=401wt.eu-S932708AbWLaD4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWLaD4d (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 22:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWLaD4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 22:56:33 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:38511 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932708AbWLaD4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 22:56:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=A1VOTXtID01cLuWPjVxgqr3uGcm4QhoNpQdOP9uToFLg4B1hO+IVhie3+yBlOeZ/8S6Ar6eKwbdofFH+6Or0cog3wbdDkeK6/m0RKrYfiBwIcWKkx43ISSWdly/F2p6mf1yImvY5rL3jg12lUPIEaVK034TiB7/ev11NEvEf13o=  ;
X-YMail-OSG: TKf_8oIVM1l5V47k2FbZsAb_f5ZOaUobHc7bMZAbb9TEcjk8psKGeKt_p3IMPaDhVDMTio8W4etdlK2LXuUw3gIuCKzC6iCPMSUDgEWYumPV_Zc3Ztk9xR5RygXjepJi7SMV5lzCfzdXJ5I-
Message-ID: <459734CE.1090001@yahoo.com.au>
Date: Sun, 31 Dec 2006 14:55:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Gelmini <gelma@gelma.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net>
In-Reply-To: <20061229224309.GA23445@gelma.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Gelmini wrote:
> On Fri, Dec 29, 2006 at 06:59:02PM +0000, Linux Kernel Mailing List wrote:
> 
>>Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7658cc289288b8ae7dd2c2224549a048431222b3
>>Commit:     7658cc289288b8ae7dd2c2224549a048431222b3
>>Parent:     3bf8ba38f38d3647368e4edcf7d019f9f8d9184a
>>Author:     Linus Torvalds <torvalds@macmini.osdl.org>
>>AuthorDate: Fri Dec 29 10:00:58 2006 -0800
>>Committer:  Linus Torvalds <torvalds@macmini.osdl.org>
>>CommitDate: Fri Dec 29 10:00:58 2006 -0800
>>
>>    VM: Fix nasty and subtle race in shared mmap'ed page writeback
> 
> 
> With 2.6.20-rc2-git1, which contain this patch, I have no more Berkeley
> DB corruption with Klibido.
> I'm afraid a lot of software project switched to Sqlite, from BDB,
> because the bug this patch fix (ie. http://bogofilter.sourceforge.net/).
> I've also thought, since years, it was an userland problem.

This bug was only introduced in 2.6.19, due to a change that caused pte
dirty bits to be discarded without a subsequent set_page_dirty() (nowhere
else in the kernel should have done this).

So if your corruption is years old, then it must be something else.
Maybe it is hidden by a timing change, or BDB isn't using msync properly.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
