Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUGANj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUGANj6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 09:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUGANj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 09:39:58 -0400
Received: from mail1.village.tin.it ([195.14.96.132]:61708 "EHLO
	village.telecomitalia.it") by vger.kernel.org with ESMTP
	id S265245AbUGANjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:39:55 -0400
Message-ID: <40E41504.9030609@gandalf.sssup.it>
Date: Thu, 01 Jul 2004 15:43:32 +0200
From: michael trimarchi <trimarchi@gandalf.sssup.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Real time
References: <40E3C9AF.4000306@gandalf.sssup.it> <Pine.LNX.4.53.0407010650240.13048@chaos>
In-Reply-To: <Pine.LNX.4.53.0407010650240.13048@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>On Thu, 1 Jul 2004, michael trimarchi wrote:
>
>  
>
>>Hi,
>>I'm working on porting modular real time scheduler on linux layer ...
>>I'm using only kernel thread... Actually I dont't call the
>>kernel_thread(init, .... and I inizialize my scheduler and OS struct...
>>I schedule my kernel thread... I'm trying to use the printk in the
>>kernel_thread but sometimes I dont't having result on the console. The
>>console does't print my debug on screen... Is there an unburred printk?
>>
>>Best regards
>>Michael Trimarchi
>>
>>    
>>
>
>You probably need to set up your kernel thread correctly. You should
>use:
>	kernel_thread(your_thread, NULL, CLONE_FS|CLONE_FILES);
>
>your_thread(void *whatever)
>{
>    exit_files(current);
>    daemonize();
>    /.../ fix up signals, etc.
>}
>
>Without CLONE_FILES, the file-descriptors and handles ultimately
>used for printk() may not work.
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>            Note 96.31% of all statistics are fiction.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
I use CLONE_KERNEL but in my body I dont't call exit_files and
demonize... I change the linux scheduler width my scheduler and I use
only the switch_to  for context_switch from a task to another... I have
a task descriptor with a pointer to the task_t * ... At this time I have
a linux task_t struct and my personal task struct...

Best regards
Michael



