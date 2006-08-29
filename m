Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965433AbWH2V43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965433AbWH2V43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965434AbWH2V43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:56:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965433AbWH2V42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:56:28 -0400
Date: Tue, 29 Aug 2006 14:55:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Why set ORIG_EAX(%esp) to -1 in arch/i386/kernel/entry.S:error_code?
In-Reply-To: <44F48F7D.4050908@goop.org>
Message-ID: <Pine.LNX.4.64.0608291455120.27779@g5.osdl.org>
References: <44F48F7D.4050908@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Aug 2006, Jeremy Fitzhardinge wrote:
>
> There doesn't seem much point; nothing seems to use it on the trap-handling
> paths.  Is it a historical left-over?

No. It's important that ORIG_EAX be set to some value that is _not_ a 
valid system call number, so that the system call restart logic (see the 
signal handling code) doesn't trigger.

		Linus
