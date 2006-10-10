Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWJJS6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWJJS6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWJJS6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:58:16 -0400
Received: from pas38-1-82-67-71-117.fbx.proxad.net ([82.67.71.117]:45701 "EHLO
	siegfried.gbfo.org") by vger.kernel.org with ESMTP id S1751080AbWJJS6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:58:14 -0400
Date: Tue, 10 Oct 2006 20:57:47 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] kdump2gdb: analyze kdumps with gdb (well, almost)
In-Reply-To: <20061009132855.GA25559@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0610091958170.9250@erda.mds>
References: <Pine.LNX.4.64.0610061742270.9250@erda.mds> <20061009132855.GA25559@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vivek,

On Mon, 9 Oct 2006, Vivek Goyal wrote:

> On Fri, Oct 06, 2006 at 06:42:00PM +0200, Jean-Marc Saffroy wrote:
>> Hello folks,
>>
>> Following earlier discussions on how nice it would be to use gdb on kdump
>> cores, I took some time and wrote a small tool to do just that:
>>   http://jeanmarc.saffroy.free.fr/kdump2gdb/
>>
>> The main limitation is that there is absolutely no backtrace of
>> non-running tasks yet, but I will try to see how it can be done. Also, it
>> works only on x86-64, but people are welcome to contribute ports. :)
>
> Hi Jean,
>
> Interesting stuff. Documentation/kdump/gdbmacros.txt already seems to
> be containing various macros for seeing the back traces of non-running
> threads. Won't these help?

Not quite, they need an update for 2.6.18:

(gdb) source kernel/linux-2.6.18/Documentation/kdump/gdbmacros.txt
(gdb) btt
There is no member named pid_list.

BTW I think these macro could use the $task->thread_group list to find 
threads in a process (at least it seems to work for my own "ps" macro).

Anyway, genuine gdb backtraces would be worlds better, so I'll take some 
time to see how to add it. Given a proper thread context, gdb can display 
function params and locals in each frame (if they are not optimized out).

The macros you mention remain useful in adverse conditions (I used similar 
tricks in the past, with lcrash), but I suspect that on average gdb will 
do its job as expected.


Cheers,

-- 
saffroy@gmail.com
