Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUGTTXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUGTTXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUGTTON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:14:13 -0400
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:50323 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266134AbUGTTJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:09:44 -0400
Message-ID: <40FD6DEE.4050208@mindspring.com>
Date: Tue, 20 Jul 2004 12:09:34 -0700
From: Steve Bangert <sbangert@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: make rpm broken in 2.6.8-rc2
References: <40FBA5D2.90107@mindspring.com> <20040719152215.GA23344@mars.ravnborg.org> <40FC15CF.9090001@mindspring.com> <20040719223148.GA9796@mars.ravnborg.org>
In-Reply-To: <20040719223148.GA9796@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sam@ravnborg.org wrote:

>>>>+ cd /usr/src/redhat/BUILD
>>>>+ rm -rf kernel-2.6.8rc1
>>>>+ /usr/bin/gzip -dc /usr/src/kernel-2.6.8rc1.tar.gz
>>>>+ tar -xf -
>>>>
>>>>gzip: /usr/src/kernel-2.6.8rc1.tar.gz: unexpected end of file
>>>>tar: Unexpected EOF in archive
>>>>tar: Unexpected EOF in archive
>>>>  
>>>>
>>>>        
>>>>
>>>tar is complaining here, even though it is reading from '-'.
>>>Is it repeatable?
>>>
>>>
>>>      
>>>
>>Yes, tried it 3 times, same result. I don,t think the "make spec" 
>>script is being executed.
>>    
>>
>
>Could you try running
>/bin/gzip -dc /home/sam/bk/kernel-2.6.8rc2.tar.gz | tar -xf -
>in an empty directory.
>  
>
Works fine

>If that fails try:
>/bin/gzip -dc /home/sam/bk/kernel-2.6.8rc2.tar.gz 
>eventually redirected to /dev/null
>
>
>Also try to check the size of the .tar.gz file.
>My tar.gz file:
> $ ll  /home/sam/bk/kernel-2.6.8rc2.tar.gz
> -rw-r--r--  1 sam users 153725342 Jul 20 00:17 /home/sam/bk/kernel-2.6.8rc2.tar.gz
>  
>
It was corrupted and the cause of the error, notice that tar was 
complaining about 2.6.8-rc1,
but I was building 2.6.8-rc2, thats because the kernel.spec file didn't 
get updated, the " make spec"
script didn't get executed after I built 2.6.8-rc1, It will execute if I 
delete the kernel.spec file and I
can successfully build the kernel with "make rpm"

Steve

>
>If the .tar.gz file is broken try uncomenting the rm from the Makefile
>and execute rpmbuild manually.
>
>	Sam
>
>  
>

