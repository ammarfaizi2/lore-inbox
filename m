Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUCEKdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 05:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUCEKdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 05:33:49 -0500
Received: from mailhost.compaq.com ([161.114.1.206]:13330 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261895AbUCEKdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 05:33:46 -0500
Message-ID: <40485803.7060102@toughguy.net>
Date: Fri, 05 Mar 2004 16:05:47 +0530
From: Raj <obelix123@toughguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, okir@monad.swb.de
Subject: Re: [TRIVIAL][PATCH]:/proc/fs/nfsd/
References: <404843B5.1010409@toughguy.net> <16456.20875.670811.900445@notabene.cse.unsw.edu.au>
In-Reply-To: <16456.20875.670811.900445@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Friday March 5, obelix123@toughguy.net wrote:
>  
>
>>Hi,
>>
>>Kernel Version: 2.6.3
>>Even if NFSD is not selected, the proc entry /proc/fs/nfsd is getting 
>>created.
>>    
>>
>
>Is it a problem??
>  
>
Theoritically no, but behavior wise , yes.

>  
>
>>The following patch fixes it.
>>    
>>
>
>Does it need fixing??
>
>If you remove this, then people who compile a kernel without nfsd
>support, and then later decide to compile an nfsd module and load it,
>will not be able to mount the nfsd filesystem at the right place.
>  
>

I guess choosing nfsd either builtin or as a module will cause a rebuild 
of some components of the main kernel and hence a
reboot is anyway need. Pls correct me if i am wrong.

>
>  
>
>>Pls apply.
>>
>>/Raj
>>--- linux-2.6.3/fs/proc/root.c	2004-02-19 09:52:32.000000000 +0530
>>+++ linux-2.6.3-fixed/fs/proc/root.c	2004-03-05 13:48:28.448516568 +0530
>>@@ -65,7 +65,11 @@ void __init proc_root_init(void)
>> #endif
>> 	proc_root_fs = proc_mkdir("fs", 0);
>> 	proc_root_driver = proc_mkdir("driver", 0);
>>+
>>+#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
>> 	proc_mkdir("fs/nfsd", 0); /* somewhere for the nfsd filesystem to be mounted */
>>+#endif
>>+
>> #if defined(CONFIG_SUN_OPENPROMFS) || defined(CONFIG_SUN_OPENPROMFS_MODULE)
>> 	/* just give it a mountpoint */
>> 	proc_mkdir("openprom", 0);
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


