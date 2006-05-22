Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWEVXHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWEVXHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWEVXHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:07:20 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:45457 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750965AbWEVXHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:07:19 -0400
Message-ID: <44724414.5020505@vilain.net>
Date: Tue, 23 May 2006 11:07:00 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, ebiederm@xmission.com, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>, serue@us.ibm.com
Subject: Re: [PATCH] namespaces: uts_ns: make information visible via	/proc/PID/uts
 directory
References: <20060522052425.27715.94562.stgit@localhost.localdomain> <1148298318.17376.19.camel@localhost.localdomain>
In-Reply-To: <1148298318.17376.19.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2006-05-22 at 17:24 +1200, Sam Vilain wrote:
>  
>
>>From: Sam Vilain <sam.vilain@catalyst.net.nz>
>>
>>Export the UTS information to a per-process directory /proc/PID/uts,
>>that has individual nodes for hostname, ostype, etc - similar to
>>those in /proc/sys/kernel
>>    
>>
>
>Can you explain the locking being used here against the name being
>changed at the same moment ?
>

Is this a test?  :-)

Let's see, get_task_pid locks the task struct (so that it doesn't go
away while we're de-referencing the nsproxy and uts_ns etc), and the
kobj references are assumed to be enough to avoid the references
dropping away in the meantime.

I didn't grab uts_sem.  That semaphore could be made per-uts_ns, in
theory.  Whether anyone cares about contention that much is another
question.

I intended this to be exploratory, it wasn't really mergable.  Should
have added an [RFC] tag, sorry about that.

Sam.
