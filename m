Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUBVQzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbUBVQzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:55:17 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:40870 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261696AbUBVQzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:55:13 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Date: Sun, 22 Feb 2004 16:55:12 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c1amtg$1up$1@news.cistron.nl>
References: <16435.61622.732939.135127@samba.org> <20040220120417.GA4010@elte.hu> <m3vfm1trj8.fsf@zoo.weinigel.se> <20040222150753.GB25664@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1077468912 2009 62.216.29.200 (22 Feb 2004 16:55:12 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040222150753.GB25664@mail.shareable.org>,
Jamie Lokier  <jamie@shareable.org> wrote:
>Christer Weinigel wrote:
>> > 	long sys_mark_dir_clean(dirfd);
>> > 
>> > the syscall returns whether the directory was valid/clean already.
>> 
>> Isn't this rather bad, it's only possible to have one process that
>> does this magic clean bit thing.  Other applications such as Wine or
>> a DOS emulator might want to get the same speedups.
>
>No.  The magic clean bit is associated with dirfd - different file
>descriptors have separate magic clean bits.
>
>> Add a new create syscall with the same idea as your one bit syscall,
>> which checks that the generation number matches.  If the generation
>> number doesn't match the create call fails.
>> 
>>     int create_synchronized(name, mode, generation);
>
>Hmm.  That's an interesting idea.

Generalize it. sys_set_required_generation(generation) - works
with all create/rename/delete/link calls. Setting it to zero
turns it off.

Mike.

