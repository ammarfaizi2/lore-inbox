Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbTIDQZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTIDQZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:25:35 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:57268 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265106AbTIDQZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:25:19 -0400
Message-ID: <3F57676E.7010804@namesys.com>
Date: Thu, 04 Sep 2003 20:25:18 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
References: <3F574A49.7040900@namesys.com>	<20030904085537.78c251b3.akpm@osdl.org>	<3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org>
In-Reply-To: <20030904091256.1dca14a5.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>> Perhaps the following is correct?
>>
>>     By contrast, ext3 in data=journal and data=ordered modes only guarantees the atomicity of a single write 
>> that does not span a page boundary, and it guarantees that its internal 
>> metadata will not be corrupted even if your application's data is 
>> corrupted after the crash (due to the application spreading what should be committed atomically across more than one block).
>>    
>>
>
>Correct != comprehensible ;)
>
Touche!

Let's try this then:

Ext3 guarantees that its metadata will be comitted sufficiently 
atomically that after a crash it will be consistent with itself.

In data=journal and data=ordered modes ext3 also guarantees that the metadata will be committed atomically with the data they point to.  However ext3 does not provide user data atomicity guarantees beyond the scope of a single filesystem disk block (usually 4 kilobytes).  If a single write() spans two disk blocks it is possible that a crash partway through the write will result in only one of those blocks appearing in the file after recovery.



-- 
Hans


