Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263270AbUJ3DGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbUJ3DGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ3DGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:06:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:9873 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263270AbUJ3DGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:06:42 -0400
Message-ID: <4183040B.3030201@osdl.org>
Date: Fri, 29 Oct 2004 20:01:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Arjan van de Ven <arjan@infradead.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reduce stack usage of NFS (was Re: How to safely reduce...)
References: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua> <1099040501.2641.9.camel@laptop.fenrus.org> <1099059626.11099.10.camel@dh138.citi.umich.edu> <200410300059.06497.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410300059.06497.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
>>>>I can convert these into kmalloc'ed variants but hesitate to do so
>>>>because of possible 'need to kmalloc in order to free memory for kmalloc'
>>>>deadlocks.
>>>
>>>how about a memory pool?
>>>
>>>It's not THE solution but I suspect the depth of callchains of these isn't too deep so it would work
>>
>>I can't see that any of the callchains Denis listed can deadlock. None
>>of them appear to lie in the memory reclaim paths.
> 
> 
> This patch reduces stack usage to below 100 bytes for
> the following functions:
> 
>                        stack usage in 2.6.9
> nfs3_proc_create:             544
> _nfs4_do_open:                516
> nfs_readdir:                  412
> nfs_symlink:                  368
> _nfs4_open_delegation_recall: 368
> nfs3_proc_rename:             364
> _nfs4_open_reclaim:           364
> nfs_mknod:                    352
> nfs_mkdir:                    352
> nfs_proc_create:              344
> nfs3_proc_link:               328
> nfs_lookup_revalidate:        312
> nfs_lookup:                   292
> 
> (btw: in function nfs_readdir: local variable 'desc' seem to be
> easily replaceable with &my_desc, or am I missing something?)
> 
> Compile tested only. I can't run test it until next Wednesday :(
> 
> Please review, especially for leaks on error paths.

Hi Denis,
I checked all of it.  Looks right & it builds.

-- 
~Randy
