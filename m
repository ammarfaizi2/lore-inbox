Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWILKaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWILKaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWILKaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:30:35 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:63882 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030184AbWILKae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:30:34 -0400
Date: Tue, 12 Sep 2006 15:59:43 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: sekharan@us.ibm.com, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user memory)
Message-ID: <20060912102943.GA28128@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1157478392.3186.26.camel@localhost.localdomain> <44FED3CA.7000005@sw.ru> <1157579641.31893.26.camel@linuxchandra> <44FFCA4D.9090202@openvz.org> <1157656616.19884.34.camel@linuxchandra> <45011A47.1020407@openvz.org> <1157742442.19884.47.camel@linuxchandra> <450509EE.9010809@openvz.org> <20060911130428.GA16404@in.ibm.com> <45068AD9.50308@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45068AD9.50308@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 02:24:25PM +0400, Pavel Emelianov wrote:
> Srivatsa Vaddagiri wrote:
> > On Mon, Sep 11, 2006 at 11:02:06AM +0400, Pavel Emelianov wrote:
> >   
> >> Sure. At the beginning I have one task with one BC. Then
> >> 1. A thread is spawned and new BC is created;
> >>     
> >
> > Why do we have to create a BC for every new thread? A new BC is needed
> > for every new service level instead IMO. And typically there wont be
> > unlimited service levels.
> >   
> That's the scenario we started from - each domain is served in a separate
> BC with *threaded* Apache.

Sure ..but you can still meet that requirement by creating fixed set of
BCs (for each domain) and let each new thread be associated with a
corresponding BC (w/o requiring to create BC for every new thread),
depending on which domain's request it is serving?

> >   
> >> 2. New thread touches a new page (e.g. maps a new file) which is charged
> >> to new BC
> >>     (and this means that this BC's must stay in memory till page is
> >> uncharged);
> >> 3. Thread exits after serving the request, but since it's mm is shared
> >> with parent
> >>     all the touched pages stay resident and, thus, the new BC is still
> >> pinned in memory.
> >> Steps 1-3 are done multiple times for new pages (new files).
> >> Remember that we're discussing the case when pages are not recharged.
> >>     
> >
> >
> >   
> 
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
Regards,
vatsa
