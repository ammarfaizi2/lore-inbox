Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVAEDLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVAEDLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 22:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVAEDLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 22:11:09 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:22928 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262218AbVAEDLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 22:11:06 -0500
Message-ID: <41DB5ADB.9060102@cwazy.co.uk>
Date: Tue, 04 Jan 2005 22:11:23 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net,
       lethal@linux-sh.org
Subject: Re: [PATCH /3] sh64: remove cli()/sti() from arch/sh64/*
References: <20050105022304.22296.7672.51691@localhost.localdomain> <20050105023405.GE26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050105023405.GE26051@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 21:11:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Tue, Jan 04, 2005 at 08:22:47PM -0600, James Nelson wrote:
>  
>
>>This series of patches is to remove the last cli()/sti() function calls in arch/sh64.
>>    
>>
>
>Wait a minute.  Is that just a blanket search-and-replace job?  There is
>a reason why cli/sti is marked obsolete instead of being silently #define'd
>that way.  Namely, in a lot of cases users of cli/sti are actually racy.
>
>For such instances replacing these with local_... would not improve anything
>(obviously) *and* would hide a trouble spot by silencing a warning.
>
>I'm not familiar with the architectures in question, so it might very well
>be that all replacements so far had been correct.  However, I would really
>like to see rationale for each of those warning removals to go along with
>the patches.
>
>Note that basically you are doing "remove the warning in foo.c:42 and
>keep the current behaviour".  The missing part is "current behaviour is,
>in fact, correct in that place and does not deserve a warning because
><list of reasons>".
>
>  
>
Everything I've looked at so far has been for single-processor systems 
AFAICT - embedded processors, evaluation boards, etc.  I do not pretend 
to have intimate familiarity with the hardware in question, and I will 
be much more careful when I reach anything that can be plugged into an 
SMP box, but I was grabbing the low-hanging fruit first.  The nasty 
stuff (drivers/char, for example) will come later.

That's why I cc'd the arch maintainers - figured they'd whack me with a 
cluebat if I'd overlooked something.

