Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWCLL1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWCLL1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 06:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCLL1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 06:27:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751423AbWCLL1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 06:27:48 -0500
Date: Sun, 12 Mar 2006 03:25:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Suresh B Siddha <suresh.b.siddha@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
Message-Id: <20060312032523.109361c1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
	<20060311210353.7eccb6ed.akpm@osdl.org>
	<Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Oledzki <olel@ans.pl> wrote:
>
> On Sat, 11 Mar 2006, Andrew Morton wrote:
> 
>  > Krzysztof Oledzki <olel@ans.pl> wrote:
>  >>
>  >> After upgrading to 2.6.16-rc6 I noticed this strange message:
>  >>
>  >>  More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
>  >>  Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
>  >>
>  >> This is a Dell PowerEdge SC1425 with two P4 Xeons with HT enabled (so with
>  >>  totoal of 4 logical CPUs).
>  >
>  > Please send full dmesg output for the failing kernel, thanks.
>  Attached.
> 
>  > Which is the most-recently-tested kernel which behaved correctly?
>  2.6.15.6

OK, thanks.  I assume the machine's working OK?

>From my reading, you have CONFIG_HOTPLUG_CPU enabled and the machine has an
APIC.  I'd expect that lots of people would hit that warning but for some
reason they don't - possibly because most APICs don't have sufficiently
high version numbers?

Anyway, various people cc'ed.  I _think_ it's harmless, although the way in
which def_to_bigsmp propagates into the DMI and APIC code might be a
problem, depending upon config options.

Certainly the warning is incorrect, but I'm not sure what is the best thing
to do about it?

