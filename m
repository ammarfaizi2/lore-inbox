Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317581AbSGJTTE>; Wed, 10 Jul 2002 15:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSGJTTD>; Wed, 10 Jul 2002 15:19:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35323 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317581AbSGJTTC>; Wed, 10 Jul 2002 15:19:02 -0400
Message-ID: <3D2C88B2.FF9ECD5C@us.ibm.com>
Date: Wed, 10 Jul 2002 12:19:14 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Perches, Joe" <joe.perches@spirentcom.com>, thunder@ngforever.de,
       bunk@fs.tum.de, boissiere@adiglobal.com, linux-kernel@vger.kernel.org,
       "'Martin.Bligh@us.ibm.com'" <Martin.Bligh@us.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [STATUS 2.5]  July 10, 2002
References: <629E717C12A8694A88FAA6BEF9FFCD440540BD@brigadoon.spirentcom.com> <E17SMM3-0007Z8-00@the-village.bc.nu> <20020710184922.GN12910@gum01m.etpnet.phys.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kurt Garloff wrote:
 
> If you want translated kernel messages, use message IDs, that can be parsed
> and translated in userspace, 

Agreed.

What's been discussed with Rusty Russell (and I believe he has 
discussed this with Alan) is not modifying the printks, but providing
logging macros that keep the format string separate from the vararg list
(but written to a log file as a single event record).

Then, a user-space utility would read the event record from the log
and do one of the following:
1)  printf-style formatting with the original format string, just like
     printk 
2a) Use a unique reference code (a hash, generated in the kernel, of 
    original format string with sourcefile name and function name, for 
    example) to look-up the non-english format string (similar to the
    catgets approach).
or
2b) Use the format string to look-up its non-english equivalent in
    a message catalog (similar to the gettext approach).

Rusty's proposal has many other benefits, which I will leave for him
to describe at the appropriate time, but translation in user-space of
kernel messages into multiple languages is one of them.

In fact, with event logging (not currently part of the base) you can
"fork" printk() messages both to the current ring buffer (formatted),
and
to a separate buffer where the format string and varargs list could
be kept separate, as described above. 

Existing parsing scripts, sys admins, etc. expect /var/log/messages,
etc.
to have pure, unmodified printk messages, so you would not want to touch
the original printk messages.  However, storing the unformatted event
data
separately in its own log file would allow the processing options
described
above.  Also, if the variable event data is stored separately from the 
format string in the event record, parsing of the data by a user-space
utility is cleaner and more efficient.  

> if somebody really needs it. 

Agreed, again.  If you don't want/need translation, there must be a way
to
completely disable it and the extra overhead that makes it possible.
