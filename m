Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWCDW5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWCDW5h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWCDW5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:57:37 -0500
Received: from smtpout.mac.com ([17.250.248.44]:63469 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932293AbWCDW5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:57:36 -0500
In-Reply-To: <1141421511.11092.66.camel@Rainsong.home>
References: <1141358816.3582.18.camel@Rainsong.home> <1141359278.3582.22.camel@Rainsong.home> <20060302233249.2aa918f4.mrmacman_g4@mac.com> <1141421511.11092.66.camel@Rainsong.home>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6D8D14D2-4ED3-46ED-8FB9-FF8567DC9F70@mac.com>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch] make UNIX a bool
Date: Sat, 4 Mar 2006 17:57:08 -0500
To: "James C. Georgas" <jgeorgas@rogers.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 3, 2006, at 16:31:51, James C. Georgas wrote:
> On Thu, 2006-02-03 at 23:32 -0500, Kyle Moffett wrote:
>> af_unix (IE: CONFIG_UNIX) currently uses the symbol  
>> get_max_files.  It is the only module that uses that symbol, and  
>> that symbol probably should not be exported as it's kind of an  
>> internal API.  Therefore if we mandate that CONFIG_UNIX != m, then  
>> that symbol may be properly unexported and made private, because  
>> nothing modular would use it.  Does that clear things up?
>
> Yes, I think I understand.
>
> However, even if you don't export the symbol, I don't see how you  
> can make it private (i.e. static declaration) to file_table.c,  
> since it has to remain extern, in order to be visible to af_unix.c.

You're missing some crucial information about how Linux operates.   
EXPORT_SYMBOL != extern.  Basically, Linux maintains a list of  
symbols that dynamically loaded modules are allowed to use, along  
with some technical usage restrictions on each  (Symbols exported  
with EXPORT_SYMBOL_GPL may only be used by modules that declare  
'MODULE_LICENSE("GPL");'.)  Exporting a symbol increases the  
likliehood that some module author will use it inappropriately, and  
bloats the kernel.  In this case, removing the EXPORT_SYMBOL() would  
be a good thing.

Cheers,
Kyle Moffett

