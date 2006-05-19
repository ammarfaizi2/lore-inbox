Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWESDM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWESDM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 23:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWESDM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 23:12:58 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:38544 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932202AbWESDM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 23:12:57 -0400
Message-ID: <446D37A6.9010308@vilain.net>
Date: Fri, 19 May 2006 15:12:38 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] namespaces: utsname: switch to using uts namespaces
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518154936.GE28344@sergelap.austin.ibm.com> <20060518170234.07c8fe4c.rdunlap@xenotime.net> <20060519022114.GB19373@sergelap.austin.ibm.com>
In-Reply-To: <20060519022114.GB19373@sergelap.austin.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:

>I suppose I could insert a separate patchset fixing up the spacing in
>those blocks but making no real changes at all, then apply my patch on
>top of that...?
>  
>

While you're fixing whitespace, patch 1 and 6 add trailing whitespace.
Use a current version of git to see the warnings.

Sam.

>  
>
>>>--- a/arch/mips/kernel/syscall.c
>>>+++ b/arch/mips/kernel/syscall.c
>>>@@ -232,7 +232,7 @@ out:
>>>  */
>>> asmlinkage int sys_uname(struct old_utsname __user * name)
>>> {
>>>-	if (name && !copy_to_user(name, &system_utsname, sizeof (*name)))
>>>+	if (name && !copy_to_user(name, utsname(), sizeof (*name)))
>>>      
>>>
>>OK, here's my big comment/question.  I want to see <nodename> increased to
>>256 bytes (per current POSIX), so each field of struct <variant>_utsname
>>needs be copied individually (I think) instead of doing a single
>>struct copy.
>>
>>I've been working on this for the past few weeks (among other
>>things).  Sorry about the timing.
>>I could send patches for this against mainline in a few days,
>>but I'll be glad to listen to how it would be easiest for all of us
>>to handle.
>>
>>I'm probably a little over half done with my patches.
>>They will end up adding a lib/utsname.c that has functions for:
>>  put_oldold_unmame()	// to user
>>  put_old_uname()	// to user
>>  put_new_uname()	// to user
>>  put_posix_uname()	// to user
>>    
>>
>
>Ok, so long as these functions accept a utsname, we should be able to
>just change what we pass in to these functions to being the namespace's
>utsname, right?  Or am I missing the really nasty part?
>
>thanks,
>-serge
>  
>

