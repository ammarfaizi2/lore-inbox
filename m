Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTDKR7A (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbTDKR7A (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:59:00 -0400
Received: from mail.zmailer.org ([62.240.94.4]:36225 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261323AbTDKR66 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:58:58 -0400
Date: Fri, 11 Apr 2003 21:10:39 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
Message-ID: <20030411181039.GL29167@mea-ext.zmailer.org>
References: <200304111259_MC3-1-3405-E080@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304111259_MC3-1-3405-E080@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 12:57:28PM -0400, Chuck Ebbert wrote:
> Alan Cox wrote:
... 
>   I still see some problems...
>   For one, there are 131 instances of:
>       printk("%s\n", blurb);
> 
> in various forms in 2.5.66.  Besides possible ritual immolation of
> those responsible for such things, something would have to be done
> about them.

Think again.  In case the "blurp" COULD have "%" in them...

>   Another problem is the one of getting that text onto the console
> in readable form. The only thing I can think of is have a two-stage
> process where printk puts the data into the log buffer as
> zero-terminated strings and then the console write routines format
> it for display.  They'd probably need their own buffers to do that.

Many of kernel's terse messages do need small encyclopedic articles
to explain them.  Present  gobble-de-gook  can not be made clear by
merely supplying  l10n  translations of them to other gobble-de-gook.

Having ANCIENT STYLE numeric message code references will help users
to find definitive explanations of them.   "My machine said: 
'1-00234-0627 eth0 link down'  and  then it said: '1-00234-0626 eth0 link up'"
(Where initial digit is severity qualifier, then subsystem id, and
finally codepoint within subsystem.  All within 32-bit integer.)
(And probably base64-ish presentation in dmesg buffer, not base10..)

Some tool can produce HTML hyperlinked presentation of the messages
with colour coding telling message classifications as text line backgrounds:
  green:  info/chatty, can ignore
  blue:   something notable happened (like linkstate jumps)
  yellow: something possibly serious
  red:    something definitely serious

at the same time the tool can produce hyperlinks with user's language
preferences (picked from environment/desktop parameters), and point
all that to some site with e.g. a twiki to accumulate documentation.
Vendors could also pull database snapshots into those tools.


That message-code style was introduced, when machines had very little
memory,  but style being in use from the dawn of computing is not
a good reason to shun it.  It really has benefits.


> > %s: went up in flames\n\0eth0\0\0
> 
>   Is that "\n" an actual ASCII newline or the printk escape sequence?

The backslash is not "printk escape".  It is C-string compilation 
notation.

/Matti Aarnio
