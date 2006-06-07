Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWFGRqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWFGRqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWFGRqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:46:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37045 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750877AbWFGRqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:46:46 -0400
Message-ID: <44870FCC.4060300@redhat.com>
Date: Wed, 07 Jun 2006 13:41:32 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: "J. Bruce Fields" <bfields@fieldses.org>, Neil Brown <neilb@suse.de>,
       NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] NFS server does not update mtime on	setattr	request
References: <4485C3FE.5070504@redhat.com>	 <1149658707.27298.10.camel@localhost> <4486E662.5080900@redhat.com>	 <20060607151754.GB23954@fieldses.org>  <4486F020.3030707@redhat.com>	 <1149694742.26188.6.camel@localhost>  <4486F479.90406@redhat.com> <1149700624.26188.15.camel@localhost>
In-Reply-To: <1149700624.26188.15.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Wed, 2006-06-07 at 11:44 -0400, Peter Staubach wrote:
>
>  
>
>>I am curious about how this would break truncate?
>>    
>>
>
>According to SuSv43, truncate should result in changes to
>mtime/ctime/suid/sgid if and only if the file size changes. The
>combination of disabling the client caching and always setting
>mtime/ctime on the server will therefore clearly break truncate.
>

Okay, I see that.

Someone should probably alert the Solaris folks that they might have a 
bug in
their NFS clients.  I suspect that they are only sending over the size 
element
in some of the over the wire SETATTR calls when they really should be 
sending
the size and mtime elements.  This might head off a potential customer issue
where they blaim Linux instead of Solaris.

    Thanx...

       ps
