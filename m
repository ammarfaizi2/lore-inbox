Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTEHNJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbTEHNJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:09:29 -0400
Received: from pat.uio.no ([129.240.130.16]:13961 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261411AbTEHNJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:09:25 -0400
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: hch@infradead.org
CC: alan@lxorguk.ukuu.org.uk, terje.eggestad@scali.com, hch@infradead.org,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, D.A.Fedorov@inp.nsk.su
In-reply-to: <20030508132931.A4951@infradead.org> (message from Christoph
	Hellwig on Thu, 8 May 2003 13:29:31 +0100)
Subject: Re: The disappearing sys_call_table export.
MIME-Version: 1.0
Message-Id: <E19DlI5-00011n-00@aqualene.uio.no>
Date: Thu, 8 May 2003 15:18:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Christoph Hellwig]
> On Thu, May 08, 2003 at 02:25:51PM +0200, Terje Malmedal wrote:
>> 
>> EXPORT_SYMBOL_GPL_AND_DONT_EVEN_THINK_ABOUT_SENDING_A_BUG_REPORT(sys_call_table);
>> 
>> and displaying a nasty warning message on the console whenever a
>> module used it?

> What about just adding the EXPORT_SYMBOL() yourself yo your kernels
> if you think you need it so badly because you can't screw yourself
> enough without it?

And if I wish to help somebody running a kernel I didn't compile?

Do you have anything constructive to say about situation i referred
to:

A database is starting to run slower and slower, turns out that this
is because fsync() is inefficient on large files. Rebooting the server
or restarting the database is undesirable even at night.

? 

I was able to fix this without rebooting or restarting the database.
How do you propose to fix something similar today without having
sys_call_table exported?

Also what exactly is the badness people are complaining about, if I do:

int init_module(void)
{
  orig_fsync=sys_call_table[SYS_fsync];
  sys_call_table[SYS_fsync]=hacked_fsync;
  return 0;
}

void cleanup_module(void)
{
  sys_call_table[SYS_fsync]=orig_fsync;
}

The only problem I can see is that different modules overloading the
same function needs to be unloaded in the correct order. Is this the
only reason for removing it, or am I missing something?

-- 
 - Terje
malmedal@usit.uio.no
