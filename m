Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWDUQyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWDUQyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWDUQyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:54:12 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:29277 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932417AbWDUQyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:54:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iORfjcOP+jTph8yfmYNbwN1lDVyTLACl0wNKyH2BgEw9df99yrEK76TuSl4l4GZCMpF/Cv0yjNhbDIcEEz0k7dV5a8oXyVjxTxBgpP8akSohbpbdzYCpEctni8bKTHa24w1B9837/TzlVCmj/QxVQiQrHnuwrzKDiyNaQlfkoo8=  ;
Message-ID: <4448B6E2.1070507@yahoo.com.au>
Date: Fri, 21 Apr 2006 20:41:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       bjorn_helgaas@hp.com, cotte@de.ibm.com
Subject: Re: [patch - repost] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net>	<Pine.LNX.4.64.0604110751510.10745@g5.osdl.org>	<yq0slojtb22.fsf@jaguar.mkp.net> <yq0acahu04h.fsf_-_@jaguar.mkp.net>
In-Reply-To: <yq0acahu04h.fsf_-_@jaguar.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:

> --- linux-2.6.orig/include/linux/mm.h
> +++ linux-2.6/include/linux/mm.h
> @@ -199,6 +199,7 @@
>  	void (*open)(struct vm_area_struct * area);
>  	void (*close)(struct vm_area_struct * area);
>  	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
> +	long (*nopfn)(struct vm_area_struct * area, unsigned long address);

Minor nit: make this unsigned long?

>  	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
>  #ifdef CONFIG_NUMA
>  	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
> @@ -612,6 +613,12 @@
>  #define NOPAGE_OOM	((struct page *) (-1))
>  
>  /*
> + * Error return values for the *_nopfn functions
> + */
> +#define NOPFN_SIGBUS	((unsigned long) -1)
> +#define NOPFN_OOM	((unsigned long) -2)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
