Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268063AbRGZPmP>; Thu, 26 Jul 2001 11:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268107AbRGZPlz>; Thu, 26 Jul 2001 11:41:55 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:14605 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268063AbRGZPlw>;
	Thu, 26 Jul 2001 11:41:52 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Gerald Walden" <thepond@charter.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: debug of a kernel panic leading nowhere... 
In-Reply-To: Your message of "Wed, 25 Jul 2001 21:57:18 -0400."
             <20010726015721Z267509-720+6404@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Jul 2001 01:41:38 +1000
Message-ID: <22993.996162098@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001 21:57:18 -0400, 
"Gerald Walden" <thepond@charter.net> wrote:
>During the rmmod of a fairly simple driver, I get a kernel
>panic which crashes the system.  I believe I have taken all
>the proper steps to attempt to debug the problem to no
>avail.
>perhaps there is a more appropriate list that I should be
>sending this to) would greatly be appreciated.
>before <1>Unable to handle kernel paging request at virtual
>address 5a5a5a5e

That bit pattern indicates an attempt to access storage that has been
freed and poisoned by the slab cache.

>>>EIP; c482424a <__module_parm_watchdog+4fd2/????>   <=====
>Trace; c482777b <END_OF_CODE+8503/????>
>Trace; c482779d <END_OF_CODE+8525/????>
>Trace; c482190f <__module_parm_watchdog+2697/????>
>Trace; c4854c20 <END_OF_CODE+359a8/????>

At the time the oops occurred, the module symbols had already been
removed.  You need to run ksymoops against ksyms and lsmod data from
*before* the rmmod.  man insmod, see ksymoops assistance, in particular
directory /var/log/ksymoops.  Run ksymoops against the symbols saved
after the module was loaded.

