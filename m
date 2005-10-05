Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbVJEP0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbVJEP0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbVJEP0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:26:49 -0400
Received: from spirit.analogic.com ([204.178.40.4]:38162 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965221AbVJEP0s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:26:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051005145736.GB7949@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <Pine.LNX.4.61.0510051048090.5182@chaos.analogic.com> <20051005145736.GB7949@csclub.uwaterloo.ca>
X-OriginalArrivalTime: 05 Oct 2005 15:26:37.0477 (UTC) FILETIME=[2D3CFD50:01C5C9C1]
Content-class: urn:content-classes:message
Subject: Re: what's next for the linux kernel?
Date: Wed, 5 Oct 2005 11:26:36 -0400
Message-ID: <Pine.LNX.4.61.0510051108560.5318@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: what's next for the linux kernel?
Thread-Index: AcXJwS1ErqarrUzwQT+WcNYjAO2Sdg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: "Marc Perkel" <marc@perkel.com>, "Nix" <nix@esperi.org.uk>,
       <7eggert@gmx.de>, "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Oct 2005, Lennart Sorensen wrote:

> On Wed, Oct 05, 2005 at 10:52:59AM -0400, linux-os (Dick Johnson) wrote:
>> Also it has nothing at all to do with the kernel. It's what `ls`
>> or some other directory-reading program provides for the user.
>> People often forget that PATH, `pwd`, etc., are just filter
>> components!
>>
>> When you `cd` to somewhere, your location hasn't changed at
>> all!
>
> So what does bash do that makes the new location 'busy' when you cd to
> it such that you can't unmount it?


Well it doesn't make a file-system location busy! It's only files
that are open-for-write that prevent a file-system from being un-mounted!

You can properly shut down a system with the following commands from
a dumb terminal (ctrl-ALT F1,F2, etc).

kill -TERM -1	# Kill everybody but me and 'init'
sleep 1		# Wait a bit
kill -9 -1	# Really kick the hangers-on
sleep 1		# Wait again
umount -a	# Umount all file systems

After you execute `umount -a`, you can still read the file-system
because `umount` only made it R/O.

`>foo`
shows that the file-system is R/O, you can hit the reset or power
switch now.

Certain distros create a file in the top directory that is supposed
to tell startup that the system was not properly shut down, "/.autofsck",
if you deleted that before the above sequence, the machine can
be restarted with no informational error messages about the shutdown.

`cd` executes function-code 12 which makes all opens() start from the
input string "path" if it doesn't have a full path. It's just a filter.
Same for opendir() if a directory listing is to be obtained.

>
>> Without involving the kernel, one can make any kind of filter
>> to cause any sort of display that you want.
>
> An it certainly is something that should be done in user space.
>

Could be done from user-space but opening an ordinary file
would require that the full path be obtained from somewhere
because the kernel wouldn't "know" where to create it if the
full path wasn't part of the open. `cd` is a kernel-call that
conveniently stores the part of the path-name that you don't
want to have to repeat for every open.

> Len Sorensen
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
