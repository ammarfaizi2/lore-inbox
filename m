Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWIKSrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWIKSrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWIKSrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:47:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:14302 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964914AbWIKSrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:47:13 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: Rik van Riel <riel@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org
In-Reply-To: <450509EE.9010809@openvz.org>
References: <44FD918A.7050501@sw.ru>
	 <1157478392.3186.26.camel@localhost.localdomain> <44FED3CA.7000005@sw.ru>
	 <1157579641.31893.26.camel@linuxchandra> <44FFCA4D.9090202@openvz.org>
	 <1157656616.19884.34.camel@linuxchandra> <45011A47.1020407@openvz.org>
	 <1157742442.19884.47.camel@linuxchandra>  <450509EE.9010809@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 11 Sep 2006 11:47:09 -0700
Message-Id: <1158000429.6029.30.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 11:02 +0400, Pavel Emelianov wrote:
<snip>

> >> In this case multithreaded apache that tries to serve each domain in
> >> separate BC will fill the memory with BC-s, held by pages allocated
> >> and mapped in threads.
> >>     
> >
> > I do not understand how the memory will be filled with BCs. Can you
> > explain, please.
> >   
> Sure. At the beginning I have one task with one BC. Then
> 1. A thread is spawned and new BC is created;

You do not have to create a new BC for each new thread, just associate
the thread to an existing appropriate BC.

> 2. New thread touches a new page (e.g. maps a new file) which is charged
> to new BC
>     (and this means that this BC's must stay in memory till page is
> uncharged);
> 3. Thread exits after serving the request, but since it's mm is shared
> with parent
>     all the touched pages stay resident and, thus, the new BC is still
> pinned in memory.
> Steps 1-3 are done multiple times for new pages (new files).
> Remember that we're discussing the case when pages are not recharged.
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


