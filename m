Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWEVXSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWEVXSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWEVXSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:18:51 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:50321 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751295AbWEVXSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:18:50 -0400
Message-ID: <447246CC.4090405@vilain.net>
Date: Tue, 23 May 2006 11:18:36 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       serue@us.ibm.com
Subject: Re: [PATCH] namespaces: uts_ns: make information visible via /proc/PID/uts
 directory
References: <20060522052425.27715.94562.stgit@localhost.localdomain> <m11wumm2tv.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wumm2tv.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>>Sorry for the duplication of this to the list, stuffed up the stgit
>>command.
>>
>>After doing this I noticed that the whole way this is done via sysctls
>>in /proc/sys is much, much nicer.  I was going there to make
>>/proc/sys/kernel/osname -> /proc/self/uts/sysname (etc), but it seems
>>that symlinks from /proc/sys are not a done thing.
>>
>>Is there an argument here perhaps for some integration between the way
>>this is done for /proc/sys and /proc/PID/xxx ?
>>
>> fs/proc/base.c |  236 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 files changed, 236 insertions(+), 0 deletions(-)
>>    
>>
>
>Good intentions :)
>But since this doesn't actually fix /proc/sys/kernel/osname and friends.
>I would call this implementation a failure.
>  
>

Yes, actually my second failure from yesterday's efforts. Thought I'd
better send something though.

>Let's first fix /proc/sys/kernel/osname to be sensitive to the caller,
>and then see if we can make /proc/sys a symlink to /proc/<pid>/sys
>  
>

Ok, that sounds like a much simpler starting point, I'll see what I can
cook up.

The only thing was, the names were odd and "machine" was missing.

Isn't everything under /proc/<pid> effectively a sysctl? Wouldn't it be
much nicer to re-use that infrastructure for everything under there?

Sam.

