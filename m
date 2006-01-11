Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030694AbWAKAC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbWAKAC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030698AbWAKAC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:02:59 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:24006 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030694AbWAKAC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:02:57 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
cc: Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text addres 
In-reply-to: Your message of "Tue, 10 Jan 2006 15:29:05 -0800."
             <20060110152904.A16312@unix-os.sc.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Jan 2006 11:02:55 +1100
Message-ID: <19866.1136937775@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S (on Tue, 10 Jan 2006 15:29:05 -0800) wrote:
>On Wed, Jan 11, 2006 at 10:11:26AM +1100, Keith Owens wrote:
>> Keshavamurthy Anil S (on Tue, 10 Jan 2006 13:07:37 -0800) wrote:
>> >On Tue, Jan 10, 2006 at 08:45:02PM +0000, Paulo Marques wrote:
>> >But my [patch 2/2] speeds up the lookup and that can go in, I think.
>> >Please ack that patch if you think so.
>> 
>> Your second patch changes the behaviour of kallsyms lookup w.r.t
>> duplicate symbols.
>With this send patch, kallsyms lookup first finds 
>the real text address which is what we want. If you consider
>this as the change in behaviour, what is the negetive effect of this
>I am unable to get it.

Local symbols can be (and are) duplicated in the kernel code, and these
duplicate symbols can appear in modules.  Changing the list order of
loaded modules also changes which version of a duplicated symbol is
returned by the kallsyms code.  Not a big deal, but annoying enough to
say "don't change the module list order".

Changing the thread slightly, kallsyms_lookup_name() has never coped
with duplicate local symbols and it cannot do so without changing its
API, and all its callers.  For debugging purposes, it would be nicer if
the kernel did not have any duplicate symbols.  Perhaps some kernel
janitor would like to take that task on.

