Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWIZA7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWIZA7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWIZA7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:59:15 -0400
Received: from pas38-1-82-67-71-117.fbx.proxad.net ([82.67.71.117]:32914 "EHLO
	siegfried.gbfo.org") by vger.kernel.org with ESMTP id S1751802AbWIZA7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:59:13 -0400
Date: Tue, 26 Sep 2006 02:59:43 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Dave Anderson <anderson@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: oops in :snd_pcm_oss:resample_expand+0x19c/0x1f0
In-Reply-To: <20060925233750.GA9791@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0609260205290.4825@erda.mds>
References: <Pine.LNX.4.64.0609241825280.4838@erda.mds>
 <20060924135417.c0c18b76.akpm@osdl.org> <Pine.LNX.4.64.0609242256540.4950@erda.mds>
 <20060925153047.GA19794@in.ibm.com> <Pine.LNX.4.64.0609252034030.4825@erda.mds>
 <20060925233750.GA9791@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006, Vivek Goyal wrote:

>> One thing I like *very much* in gdb is its ability to display function
>> params and local variables in any stack frame, and I haven't found out how
>> to do it with crash.
>
> Agreed. AFAIK, crash does not display the function params and local
> variables. gdb has got this advantage, though last time I looked
> at local variables dispalyed by gdb, they seemed to be junk. Not very
> sure why it was so?

Most probably this is due to compiler optimizations, eg. the register is 
reused for another purpose. Recently I was pleased to discover that gdb 
6.5 is smart enough to tell the user that a variable has been optimized 
out (certainly with help from debug info produced by gcc).

>> I agree that gdb is sometimes very slow, but maybe it's easier to 
>> optimize gdb than to make crash smarter?
>
> I beg to differ here. Not sure why it is easier to optimize gdb. If we 
> try to optimize gdb by writing scripts, then IMHO, writing C program is 
> easier and faster. If the idea is to optimize gdb by modifying gdb code 
> then its no different than crash. In fact, why to reinvent the wheel if 
> crash already does so many things for us. Yes, but probably we need to 
> modify crash to be able to obtain function parameters and local 
> variables.

Oh I only meant that *maybe* gdb deserved some optimizations that would be 
suitable for general use, but this is pure speculation. I agree that a 
custom modified gdb is in a way akin to crash.

>> For this particular problem (listing threads), the real fix would be to 
>> add the PT_NOTE entry that each thread deserves, then gdb would let you 
>> do "info threads" instead, and dump nice backtraces of each.
>
> Displaying even the currently non executing threads using "info threads" 
> and their backtraces is interesting. Crash can already do that. I am 
> apprehensive about traversing through the task list and dumping every 
> thread's register state after a crash. There is no gurantee that list is 
> in a sane state. And in general, we are trying to make crash handler as 
> small as possible to improve the reliability of dumping operation.
>
> Register state of every non-executing thread is already present in the
> vmcore and IMHO, we should write scripts to get info about other
> threads then doing it in kernel.

This is exactly what I had in mind, for the very reasons you mentioned. 
:-)


-- 
saffroy@gmail.com
