Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUCAO2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUCAO2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:28:55 -0500
Received: from x.box.net.pl ([81.210.72.13]:5262 "HELO box.net.pl")
	by vger.kernel.org with SMTP id S261295AbUCAO2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:28:51 -0500
Message-ID: <40434852.1000102@mat.uni.torun.pl>
Date: Mon, 01 Mar 2004 15:27:30 +0100
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       wrona@mat.uni.torun.pl
Subject: Re: posix message queues, was Re: 2.6.4-rc1-mm1
References: <20040229140617.64645e80.akpm@osdl.org> <20040301112631.GA28526@outpost.ds9a.nl>
In-Reply-To: <20040301112631.GA28526@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

>On Sun, Feb 29, 2004 at 02:06:17PM -0800, Andrew Morton wrote:
>
>  
>
>>- Added the POSIX message queue implementation.  We're still stitching
>>  together a decent description of all of this.  Reference information is at
>>	http://www.mat.uni.torun.pl/~wrona/posix_ipc/
>> and
>>	http://www.opengroup.org/onlinepubs/007904975/basedefs/mqueue.h.html
>>    
>>
>
>I can confirm that basic functionality is there. Both blocking and
>nonblocking operations work as advertised. Queue properly blocks when full
>or empty.
>
>mq_timedsend does not wait, it immediately returns ETIMEOUT with the queue
>is full:
>
>         struct timespec ts;
>         ts.tv_sec=1;
>    	 ts.tv_nsec=0;
>         sprintf(msgptr,"%05d %s",c,stime);
>	 
>         if ( mq_timedsend(mqd,msgptr,msglen,msg_prio, &ts) )
>	 {
>	    perror("mq_send()");
>	      break;
>	 }
>
>results in:
>
>$ ./mqreceive /Q32x128
>1: priority 0  len 64 text 00001 Mon Mar  1 12:20:11 2004  
>$ ./mqreceive /Q32x128
>1: priority 0  len 64 text 00001 Mon Mar  1 12:20:11 2004  
>$ ./mqsend  /Q32x128
>$ ./mqsend  /Q32x128
>$ ./mqsend  /Q32x128
>mq_send(): Connection timed out  <- immediately
>  
>
It _should_ return immediately. mq_timedsend timeout must be given as 
absolute value, so if you want to have one second timeout from now,
you must do:

	ts.tv_sec = time(NULL) + 1;
    	ts.tv_nsec = 0;

And I don't have idea why POSIX defines timeout as absolute not relative 
;-).

>I would very much advise Michal and Krzysztof to add some basic examples to
>their page. I had to scour the internet to find some working code.
>  
>
Thats right. The above problem also shows that such examples can be 
usefull. We are just now updating man pages for the library (there are 
some obsolete informations) and I will prepare some well commented programs.

>Mounting the queuefs works but the fs, confusingly, is called mqueue and not
>mqueuefs.
>  
>
As proc or msdos. Of course it can be changed if more people will want 
'fs' suffix. Menuconfig help gives proper name.

Regards,
Krzysiek

