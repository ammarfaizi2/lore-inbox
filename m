Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWGOXb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWGOXb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 19:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWGOXb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 19:31:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:45216 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964811AbWGOXb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 19:31:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QTMfw0rAOdQ310BuXqv98WnUoHyEJOLcQMA7+YrFBWqAcg5jLAO9YaY1YC6p0yStkAIo1yrPAkuwh8V6sCYKu4zEC6oJ3LZ06Nu8H9dkh+xvl4iPlJNfEGdriAgFIy3XwXF2Rm/BOnMDwn+5PrlntnAom1Pkw23hXGMLpollTVM=
Message-ID: <44B97ADD.5000302@gmail.com>
Date: Sun, 16 Jul 2006 01:31:41 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc1-mm2: process `showconsole' used the removed sysctl
 system call
References: <44B8FE64.6040700@imap.cc> <20060715154200.e9138a6b.akpm@osdl.org>
In-Reply-To: <20060715154200.e9138a6b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
> On Sat, 15 Jul 2006 16:40:36 +0200
> Tilman Schmidt <tilman@imap.cc> wrote:
> 
>> After installing a 2.6.18-rc1-mm2 kernel without sysctl syscall support
>> on a standard SuSE 10.0 system, I find the following in my dmesg:
>>
>>> [   36.955720] warning: process `showconsole' used the removed sysctl system call
>>> [   39.656410] warning: process `showconsole' used the removed sysctl system call
>>> [   43.304401] warning: process `showconsole' used the removed sysctl system call
>>> [   45.717220] warning: process `ls' used the removed sysctl system call
>>> [   45.789845] warning: process `touch' used the removed sysctl system call
>> which at face value seems to contradict the statement in the help text
>> for the CONFIG_SYSCTL_SYSCALL option that "Nothing has been using the
>> binary sysctl interface for some time time now". (sic)
>>
>> Meanwhile, the second part of that sentence that "nothing should break"
>> by disabling it seems to hold true anyway. The system runs fine, and
>> activating CONFIG_SYSCTL_SYSCALL in the kernel doesn't seem to have any
>> effect apart from changing the word "removed" to "obsolete" in the above
>> messages.
> 
> Thanks.
> 

date and salsa also use sysctl.

warning: process `date' used the removed sysctl system call
warning: process `salsa' used the removed sysctl system call

> Eric, that tends to make the whole idea inviable, doesn't it?

How about _very_ long term to remove sysctl (i.e. January 2010)?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotowski@gmail.com>

diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/Documentation/ABI/obsolete/sysctl linux-mm/Documentation/ABI/obsolete/sysctl
--- linux-mm-clean/Documentation/ABI/obsolete/sysctl	1970-01-01 01:00:00.000000000 +0100
+++ linux-mm/Documentation/ABI/obsolete/sysctl	2006-07-16 01:22:51.000000000 +0200
@@ -0,0 +1,15 @@
+What:		sys_sysctl
+Date:		January 2010
+Contact:	Eric W. Biederman <ebiederm@xmission.com>
+Description:
+	sys_sysctl uses binary paths that have been found to be a major
+	pain to maintain and use.  The interface in /proc/sys is now
+	the primary and what everyone uses.
+	
+	Nothing has been using the binary sysctl interface for some time
+	time now so nothing should break if you disable sysctl syscall
+	support, and you kernel will get marginally smaller.
+
+Users:
+
+date, ls, salsa, showconsole, touch
