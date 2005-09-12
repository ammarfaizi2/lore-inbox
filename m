Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVILSiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVILSiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVILSiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:38:16 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1249 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932091AbVILSiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:38:15 -0400
Message-ID: <4325CB10.1020902@adaptec.com>
Date: Mon, 12 Sep 2005 14:38:08 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 2/14] sas-class: README
References: <4321E4DD.7070405@adaptec.com> <432543C6.1020403@torque.net>
In-Reply-To: <432543C6.1020403@torque.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 18:38:14.0039 (UTC) FILETIME=[2238E270:01C5B7C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 05:00, Douglas Gilbert wrote:
> Luben Tuikov wrote:
> 
> <snip>
> 
>>+
>>+DISCOVERY
>>+---------
>>+
>>+The sysfs tree has the following purposes:
>>+    a) It shows you the physical layout of the SAS domain at
>>+       the current time, i.e. how the domain looks in the
>>+       physical world right now.
>>+    b) Shows some device parameters _at_discovery_time_.
>>+
>>+This is a link to the tree(1) program, very useful in
>>+viewing the SAS domain:
>>+ftp://mama.indstate.edu/linux/tree/
>>+I expect user space applications to actually create a
>>+graphical interface of this.
>>+
>>+That is, the sysfs domain tree doesn't show or keep state if
>>+you e.g., change the meaning of the READY LED MEANING
>>+setting, but it does show you the current connection status
>>+of the domain device.
> 
> 
> So in that case, user applications should ignore READY
> LED MEANING in sysfs and ask the device directly.
> For example:
>     sdparm --get RLM --transport sas /dev/sda

Yes, correct.  You and I have discussed this already.

Excerpt from that same "README" file (just above the code
you cut and pasted):

The sysfs tree has the following purposes:
    a) It shows you the physical layout of the SAS domain at
       the current time, i.e. how the domain looks in the
       physical world right now.
    b) Shows some device parameters _at_discovery_time_.

> ... and what about multiple initiators sitting on different
> machines? Should they be responsible for:
>   1) finding out about one another
>   2) and keeping the sysfs tree in the other machine
>      in sync when one changes READY LED MEANING
>      (or anything else)?

And how is this a problem of the Discover code?

There is a way to handle more than one initiator on the domain
doing discovery, but I didn't code it since _at_this_time_
I doubt people would start doing this: they don't even
have SAS hardware, a lot less two initiators on the same
domain.

> Putting distributed state information in sysfs and then
> passing off the responsibility for maintaining its state
> (because it is a difficult problem) brings into question
> the wisdom of the strategy.

No Doug, not true at all.

Sorry that "sg" isn't going to be used to communicate with
expanders, but this is just part of evolution.

If I removed "ready_led_meaning" and a couple of other
such entries: you would have NO argument.

If I left only the directory entries representing the
object and the "smp_portal" you argument falls apart.

Instead, you should've been saying how easy and
_elegant_ it is communicating with expanders on the
domain:
	* open(2) the "smp_portal" in the expander
          directory you want to talk to,
	* write(2) the SMP frame you want to send,
	* read(2) the amount of information you
	  expect to get,
	* close(2).

Done!  No addressing to figure out, no memory problems, etc.
The easiest interface: read(2)/write(2), _and_ the simplest
format to use: pure SMP frames, easy and straightforward.

GUI programs would be able to use all this to give
a GUI of the whole domain and then you can just point and
click on an expander and get information using this simple
and elegant interface.

Sorry again "sg" wouldn't fit in here.  It's just evolution.

	Luben
P.S. I _did_ mention to you in private email that this is going
to happen and you didn't reply at all.



