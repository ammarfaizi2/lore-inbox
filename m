Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUDYIvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUDYIvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 04:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbUDYIvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 04:51:42 -0400
Received: from [81.219.144.6] ([81.219.144.6]:3339 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262972AbUDYIvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 04:51:40 -0400
Message-ID: <408B7C13.1000708@pointblue.com.pl>
Date: Sun, 25 Apr 2004 09:51:31 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@linuxmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au> <4089F0E5.3050006@pointblue.com.pl> <20040424183505.GB2525@elf.ucw.cz>
In-Reply-To: <20040424183505.GB2525@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>Second one, starting KDE, and when swap usage != 0 (just to be sure 
>>there is no problem with any assumption), gives me loads of error 
>>messages (see attached file).
>>    
>>
>
>Can you try CONFIG_PREEMPT=n?
>	
>
Funny, now it doesn't run BUG(), but, instead I have two way behavior. 
Either he is complaining that bash
will not stop !! or that there is not enough pages free. Both wrong and 
bizzareus. This really needs fixing before 2.6.6 is out (imo).


1:

Apr 25 09:47:58 nalesnik kernel: Stopping tasks: 
========================================================================
Apr 25 09:47:58 nalesnik kernel:  stopping tasks failed (1 tasks remaining)
Apr 25 09:47:58 nalesnik kernel: Suspend failed: Not all processes stopped!
Apr 25 09:47:58 nalesnik kernel: Restarting tasks...<6> Strange, bash 
not stopped


2:

Apr 25 10:53:52 nalesnik kernel: Stopping tasks: 
=======================================================================|
Apr 25 10:53:52 nalesnik kernel: Freeing memory: ..........|
Apr 25 10:53:52 nalesnik kernel: /critical section: counting pages to 
copy..[nosave pfn 0x44d]........................... (pages needed: 
24493+512=25005 free: 4162)
Apr 25 10:53:52 nalesnik kernel: Suspend Machine: Couldn't get enough 
free pages, on 20843 pages short
Apr 25 10:53:52 nalesnik kernel: Suspend Machine: Suspend failed, trying 
to recover...
Apr 25 10:53:52 nalesnik kernel: blk: queue c6d40e00, I/O limit 4095Mb 
(mask 0xffffffff)
Apr 25 10:53:52 nalesnik kernel: Fixing swap signatures... ok
Apr 25 10:53:52 nalesnik kernel: Restarting tasks... done



--
GJ

