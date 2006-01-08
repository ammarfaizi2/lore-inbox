Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWAHBwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWAHBwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 20:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWAHBwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 20:52:39 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:48324 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1161132AbWAHBwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 20:52:38 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: reference_discarded addition 
In-reply-to: Your message of "Fri, 06 Jan 2006 02:40:19 CDT."
             <20060106074019.GA1226@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jan 2006 12:52:35 +1100
Message-ID: <31103.1136685155@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones (on Fri, 6 Jan 2006 02:40:19 -0500) wrote:
>Error: ./fs/quota_v2.o .opd refers to 0000000000000020 R_PPC64_ADDR64    .exit.text
>
>Been carrying this for some time in Red Hat trees.
>
>Signed-off-by: Dave Jones <davej@redhat.com>
>
>diff -urNp --exclude-from=/home/davej/.exclude linux-3022/scripts/reference_discarded.pl linux-10000/scripts/reference_discarded.pl
>--- linux-3022/scripts/reference_discarded.pl
>+++ linux-10000/scripts/reference_discarded.pl
>@@ -88,6 +88,7 @@ foreach $object (keys(%object)) {
> 		    ($from !~ /\.text\.exit$/ &&
> 		     $from !~ /\.exit\.text$/ &&
> 		     $from !~ /\.data\.exit$/ &&
>+		     $from !~ /\.opd$/ &&
> 		     $from !~ /\.exit\.data$/ &&
> 		     $from !~ /\.altinstructions$/ &&
> 		     $from !~ /\.pdr$/ &&

For our future {in}sanity, add a comment that this is the ppc .opd
section, not the ia64 .opd section.  ia64 .opd should not point to
discarded sections.

Any idea why ppc .opd points to discarded sections when ia64 does not?
AFAICT no ia64 object has a useful .opd section, they are all empty or
(sometimes) a dummy entry which is 1 byte long.  ia64 .opd data is
built at link time, not compile time.

It is a pity that ppc is generating .opd entries at compile time.  It
makes it impossible to detect a real reference to a discarded function.

