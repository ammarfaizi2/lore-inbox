Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280720AbRKGAdQ>; Tue, 6 Nov 2001 19:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280709AbRKGAc5>; Tue, 6 Nov 2001 19:32:57 -0500
Received: from web20401.mail.yahoo.com ([216.136.226.120]:27562 "HELO
	web20401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280695AbRKGAcu>; Tue, 6 Nov 2001 19:32:50 -0500
Message-ID: <20011107003249.52102.qmail@web20401.mail.yahoo.com>
Date: Tue, 6 Nov 2001 16:32:49 -0800 (PST)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: [RFC] Don't replace /proc (Re: Digest message 23, PROPOSAL: /proc standards)
To: linux-kernel@vger.kernel.org
In-Reply-To: <200111062247.fA6Ml2E11597@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

--- linux-kernel-digest-request@lists.us.dell.com wrote:
>   23. Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc (J .
> A . Magallon)
>
>Message: 23
>Date:   Tue, 6 Nov 2001 23:53:03 +0100
>From: "J . A . Magallon" <jamagallon@able.es>
>To: erik@hensema.net
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
>
>
>>On 20011106 Erik Hensema wrote:
>>Stephen Satchell (satch@concentric.net) wrote:
>>>The RIGHT tool to fix the problem is the pen, not the coding pad.  I
>>>hereby pick up that pen and put forth version 0.0.0.0.0.0.0.0.1 of the
>>>Rules of /Proc:
>>
>>Agreed.
>>
>>>
>>>7)  The /proc data may include comments.  Comments start when an  unescaped 
>>>hash character "#" is seen, and end at the next newline \n.  Comments may 
>>>appear on a line of data, and the unescaped # shall be treated as end of 
>>>data for that line.
>>
>
>Well, perhaps this is a stupid idea. But I throw it.
>ASCII is good for humans, bin is good to read all info easily in a program.
>Lets have both.
>
>Once I thought the solution could be to make /proc entries behave
>differently in two scenarios. Lets suppose you could open files in ASCII
>or binary mode. An entry opened in ASCII returns printable info and opened
>in binary does the binay output. As there is no concept of ASCII or binary
>files in low-level file management, the O_DIRECT flag (or any new flag) could
>be used.
>
>And (supposing all fies in /proc are 0-sized) perhaps a seek position could be
>defined for reading a format string or a set of field names, ie:
>lseek(SEEK_FORMAT); read(...);
>
>Same for writing, opening in "wa" allows to write a formatted number (ie,
>echo 0xFF42 > /proc/the/fd) and  "wb" allows to write binary data
>(write("/proc/the/fd",&myValue)).
>
>Just an idea...

	I have a better idea. IMO, DON'T CHANGE /proc. Period.

	The reason is that it would take a horribly long time to actually
migrate all the broken userspace programs over to the new, changed, updated
/proc. Therefore, I have a proposal: create TWO new filesystems:

	procfs2 - PROCess FileSystem version 2
		A listing of all system processes in whatever format wins

	kernelfs - KERNEL FileSystem
		A configuration/feedback kernel interface in whatever
		format wins

	Put ALL process-related stuff in procfs2, and all kernel-related
stuff (/proc/bus, /proc/pci, /proc/sys, /proc/net, etc.......) in kernelfs.
Then choose how many kernel blocks procfs1 will remain available (i.e.
the Great Overlord Linus decrees, "Thou shalt not remove procfs1 until 2.7")

	This way, people who hate /proc get their new format, every single
person who wrote a program based on /proc can take their time migrating to the
new formats, and you get more granular control over kernel-related stuff 
(i.e. if you don't need to mess with kernel settings, don't mount kernelfs).

	Comments, anyone? From the e-mails I've been reading, it seems
that this way, everybody wins....... unless you consider code duplication.....

>
>-- 
>J.A. Magallon

Brad



=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
Alternate e-mails: kakadu@adelphia.net
		   kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
