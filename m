Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVJUQKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVJUQKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVJUQKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:10:22 -0400
Received: from amdext4.amd.com ([163.181.251.6]:6623 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S965009AbVJUQKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:10:21 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Christoph Lameter" <clameter@engr.sgi.com>
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Date: Fri, 21 Oct 2005 11:18:09 -0500
User-Agent: KMail/1.8
cc: "Paul Jackson" <pj@sgi.com>,
       "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>,
       Simon.Derr@bull.net, akpm@osdl.org, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
 <20051021081553.50716b97.pj@sgi.com>
 <Pine.LNX.4.62.0510210845140.23212@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0510210845140.23212@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Message-ID: <200510211118.10886.raybry@mpdtxmail.amd.com>
X-WSS-ID: 6F47CD4A35K1420950-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 October 2005 10:47, Christoph Lameter wrote:
> On Fri, 21 Oct 2005, Paul Jackson wrote:
> >  * Christoph - what is the permissions check on sys_migrate_pages()?
> >    It would seem inappropriate for 'guest' to be able to move the
> >    memory of 'root'.
>
> The check is missing.
>

That code used to be there.    Basically the check was that if you could 
legally send a signal to the process, you could migrate its memory.
Go back and look and my patches for this.

Why was this dropped, arbitrarily?

> Maybe we could add:
>
>  if (!capable(CAP_SYS_RESOURCE))
>                 return -EPERM;
>
> Then we may also decide that root can move any process anywhere and drop
> the retrieval of the mems_allowed from the other task.
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

