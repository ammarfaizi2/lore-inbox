Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTEFOeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTEFOeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:34:16 -0400
Received: from www1.mail.lycos.com ([209.202.220.140]:47449 "HELO lycos.com")
	by vger.kernel.org with SMTP id S263771AbTEFOeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:34:13 -0400
To: "Matti Aarnio" <matti.aarnio@zmailer.org>
Date: Tue, 06 May 2003 10:45:22 -0400
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <DCFLDJPJGNMBCDAA@mailcity.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: Write file in EXT2
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the details,

But I would like to know when each FS is being accessed, and by which application. Isnt there a single path, say something in the driver code, from where all write/read commands pass? So that we can have a function call from that place, and create a log? 

And also, how do I create a logfile on my own. With my own function within the kernel. I dont wish to go to Userland and do the write process.

Thanks in advance.

Sumit

--

On Tue, 6 May 2003 10:17:08   
 Matti Aarnio wrote:
>On Mon, May 05, 2003 at 11:14:46PM -0400, Sumit Narayan wrote:
>> Hi,
>> 
>> I would like to create a log file containing the reads and writes made 
>> on a disk, by adding a function in the kernel. And once this log table 
>> reaches a limit, say 10,000 records, I would like it to be written on 
>> hard disk automatically. I am unable to do this, since I dont know how 
>> to write to a file, while in the kernel. I tried System Calls, but they 
>> dont seem to work. Could someone tell me what is the list of functions 
>> that I need to use to do this job. I think I have to play with 
>> super-blocks and inodes. But I dont know how to do that. :) Please help 
>> me.
>
>
>  Considering how to do that log writing:
>
>  Kernel contains several codes that are writing data to disk for
>  various "logging" tasks.  Most promimnent example of them is:
>
>      kernel/acct.c
>
>  It keeps kernel internal file descriptor ("filp") for its
>  internal use.  It has code that opens a file for writing
>  to it, actual writer (one smallish block at the time, but
>  that is merely size parameter issue), and it also closes
>  the file when wanted (e.g. under administrator control).
>
>  All that completely independent of target filesystem.
>
>  Oh, and of course it has management interface, so that
>  sysadmin can tell to it:
>    - when to activate / deactivate
>    - into which file to log
>
>
>  In your application there is a danger of snaring
>  yourself:  disk activity must not stop at logging
>  something, when the log buffer is full and flushing
>  it is under way.  Otherwise you are in danger of
>  halting the log-flush, and then you have a dead
>  machine.
>
>> Thanks.
>> Sumit
>> 
>> p.s. I am using Kernel 2.4.20 and want this in EXT2 FS
>
>/Matti Aarnio
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
