Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbUKEW5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbUKEW5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUKEW5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:57:15 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:52917 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261229AbUKEW5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:57:12 -0500
Date: Fri, 5 Nov 2004 17:54:57 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: <linux-kernel@vger.kernel.org>, <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, <arjanv@redhat.com>
Subject: Re: breakage: flex mmap patch for x86-64
In-Reply-To: <200411052351.11940.rjw@sisk.pl>
Message-ID: <Pine.GSO.4.33.0411051751290.9358-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Rafael J. Wysocki wrote:
>> This prevents 32bit apps from running on x86_64.  Backing out the Makefile
>> and processor.h changes has everything working again.  Perhaps something
>> needs to check for a 32bit environment?  I don't know if it's the change
>> to TASK_SIZE or the "backwards" mmaps that's the real breakage.  And at this
>> point, I don't have time to test.
>>
>> (64bit apps work just fine.)
>
>Confirmed, and apparently it is not sifficient to change the TASK_SIZE
>definition in include/asm-x86_64/processor.h to make the 32-bit userland
>work.  Hence, it seems that the "backwards" mmaps break things.

Looks like checking for PER_LINUX32 might fix it...

>>>      if (current->personality & (ADDR_COMPAT_LAYOUT|PER_LINUX32))

--Ricky


