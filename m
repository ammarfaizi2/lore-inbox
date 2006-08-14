Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWHNADY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWHNADY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 20:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWHNADY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 20:03:24 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:57903 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751473AbWHNADX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 20:03:23 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH for review] [123/145] i386: make fault notifier unconditional and export it 
In-reply-to: Your message of "Sun, 13 Aug 2006 22:17:48 +0200."
             <200608132217.48966.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Aug 2006 10:03:30 +1000
Message-ID: <16501.1155513810@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Sun, 13 Aug 2006 22:17:48 +0200) wrote:
>On Sunday 13 August 2006 17:28, Adrian Bunk wrote:
>> > It's needed for external debuggers and overhead is very small.
>> >...
>> 
>> We are currently trying to remove exports not used by any in-kernel 
>> code.
>
>That ``we'' doesn't include me at least.
>
>> 
>> The patch description also lacks the name of what you call "external 
>> debuggers" (I assume the exports are not for a theoretical usage but for 
>> an already existing debugger?).
>
>The fault chain is needed for pretty much any debugger, including
>kgdb, kdb, nlkd. The one in this case was NLKD.

No.  The page fault event was only used by kprobes, but it slowed down
all code.  That is why it was changed to only be present if kprobes was
in the system.  kdb and AFAIK kgdb do not need the page fault chain.
nlkd might need it, but that does not seem to have been explicitly
stated.

