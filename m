Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWDGXxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWDGXxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 19:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDGXxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 19:53:12 -0400
Received: from mexforward.lss.emc.com ([168.159.213.200]:48003 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751356AbWDGXxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 19:53:11 -0400
Message-ID: <4436FB9C.40706@emc.com>
Date: Fri, 07 Apr 2006 19:54:04 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Douglas McNaught <doug@mcnaught.org>
CC: Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: How to know when file data has been flushed into disk?
References: <4ae3c140604070842x537353c4s9a60706c2a2d25d9@mail.gmail.com> <87slop1ix2.fsf@suzuka.mcnaught.org>
In-Reply-To: <87slop1ix2.fsf@suzuka.mcnaught.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.04.07.161104
X-PerlMx-Spam: Gauge=, SPAM=2%, Reason='EMC_FROM_0+ -2, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Douglas McNaught wrote:

>"Xin Zhao" <uszhaoxin@gmail.com> writes:
>
>  
>
>>3. Does sys_close() have to  be blocked until all data and metadata
>>are committed? If not, sys_close() may give application an illusion
>>that the file is successfully written, which can cause the application
>>to take subsequent operation. However, data flush could be failed. In
>>this case, file system seems to mislead the application. Is this true?
>>If so, any solutions?
>>    
>>
>
>The fsync() call is the way to make sure written data has hit the
>disk.  close() doesn't guarantee that.
>
>-Doug
>
>  
>
You should also make sure, if you care about data recovery after a power 
outage, that you have either disabled the write cache on your drives or 
have a working write barrier.  Without this, fsync will move the data 
from the page cache to the disk's write cache where it is up to the 
drive firmware to write it back to permanent, safe storage on the disk 
platter.

ric

