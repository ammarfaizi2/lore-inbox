Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWILUfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWILUfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWILUfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:35:14 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:41489 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030422AbWILUfM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:35:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 Sep 2006 20:35:09.0008 (UTC) FILETIME=[F03EF500:01C6D6AA]
Content-class: urn:content-classes:message
Subject: Re: R: Linux kernel source archive vulnerable
Date: Tue, 12 Sep 2006 16:35:08 -0400
Message-ID: <Pine.LNX.4.61.0609121619470.19976@chaos.analogic.com>
In-Reply-To: <ee72if$sng$1@taverner.cs.berkeley.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: R: Linux kernel source archive vulnerable
thread-index: AcbWqvBG+NaCs4jESLuJL6qdGifYnA==
References: <20060907182304.GA10686@danisch.de> <D432C2F98B6D1B4BAE47F2770FEFD6B612B8B7@to1mbxs02.replynet.prv> <Pine.LNX.4.61.0609111334460.2498@soloth.lewis.org> <8E63F0FB-DDD3-41D4-AFA7-88E66D0E9C8D@mac.com> <ee72if$sng$1@taverner.cs.berkeley.edu>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2006, David Wagner wrote:

> Kyle Moffett  wrote:
>> Please see these threads and quit bringing up this topic like crazy:
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=113304241100330&w=2
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=114635639325551&w=2
>
> I've read those threads in detail.  Those threads give no justification
> whatsoever about why the files are stored in tar with world-writeable
> permissions.  The posts to those threads just blame the victim, blame
> the maintainers of tar, and point fingers at everyone else.  I cannot
> see any good reason why the files in tar need to have world-writeable
> permissions.  It seems to me like a simple and reasonable request to make
> them non-world-writeable.  It can't hurt, and it might help a few users.
> I cannot fathom why there is such resistance to such a simple request.
>
> Just because it is a bug in tar doesn't mean that Linux developers have
> to create their tarfile in a way that tickles the bug.  Two wrongs don't
> make a right.
>
> Just because it doesn't affect you doesn't mean that it isn't an issue.
> You're not the only person in the world.
> -

Try `info umask`. That will tell you how, tar created files in the
achieve that are world writable. The automatic daemon that executed
tar was root, using this mask for world-write permission. It's not
a tar bug, it is how it __must__ create files so that when a non-
root user executes tar, tar can change the owner to the person un-
tarring the achieve, AND, incidentally, set the permissions to the
new owners file creation mask set with `unmask`. If the files were not
world-writable in the archieve, you'd be up the creek trying to extract
files into your directories, with your ownership, and with your
permissions. Tar would have to execute as SUID root, and I don't
think even you would like that! Tar could then overwrite anything,
anywhere, NotGood(tm).

If you persist in un-tarring files as root, you get what you've got
and it is not a bug.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
