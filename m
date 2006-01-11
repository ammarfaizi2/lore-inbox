Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWAKAXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWAKAXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWAKAXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:23:31 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:36038 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932359AbWAKAXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:23:30 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text addres 
In-reply-to: Your message of "Tue, 10 Jan 2006 16:07:55 -0800."
             <Pine.LNX.4.58.0601101606380.12724@shark.he.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Jan 2006 11:23:28 +1100
Message-ID: <20396.1136939008@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" (on Tue, 10 Jan 2006 16:07:55 -0800 (PST)) wrote:
>On Wed, 11 Jan 2006, Keith Owens wrote:
>> Changing the thread slightly, kallsyms_lookup_name() has never coped
>> with duplicate local symbols and it cannot do so without changing its
>> API, and all its callers.  For debugging purposes, it would be nicer if
>> the kernel did not have any duplicate symbols.  Perhaps some kernel
>> janitor would like to take that task on.
>
>Jesper Juhl was doing some -Wshadow patches.  Would that detect
>duplicate symbols?

No, the duplicate symbols are (a) static and (b) in separate source
files.  Run this against a System.map.

 awk '{print $NF}' System.map | egrep -v '^__ks|^__func' | sort | uniq -dc | LANG=C sort -k2

