Return-Path: <linux-kernel-owner+w=401wt.eu-S1754213AbWLRQSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbWLRQSq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbWLRQSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:18:46 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:53629 "EHLO
	liaag1ad.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754213AbWLRQSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:18:45 -0500
Date: Mon, 18 Dec 2006 11:13:01 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.19.1 bug?  tar: file changed as we read it
To: Avi Kivity <avi@argo.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Steve French <sfrench@samba.org>,
       linux-cifs-client <linux-cifs-client@lists.samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200612181115_MC3-1-D578-937D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <4586408C.2050408@argo.co.il>

On Mon, 18 Dec 2006 09:17:32 +0200, Ava Kivity wrote:

> In 2.6.20-rc1, some of these files have other files with the same name 
> in the same directory (modulo case).  Perhaps this is confusing cifs.
> 
> Can you check where all of the files in your case share that property?
> 
> example:
> 
>     [avi@firebolt linux-2.6]$ find net -iname ipt_tos.c
>     net/ipv4/netfilter/ipt_TOS.c
>     net/ipv4/netfilter/ipt_tos.c
> 
>     [avi@firebolt linux-2.6]$ find net -iname ipt_ecn.c
>     net/ipv4/netfilter/ipt_ECN.c
>     net/ipv4/netfilter/ipt_ecn.c

Yes, that's it.

Using smbfs, both files have the same size and contents even though
they're really different:

$ ll ipt_dscp* ipt_DSCP*
-r--r-----  1 me me 2753 Jan 29  2004 ipt_dscp.c
-r--r-----  1 me me 2753 Jan 29  2004 ipt_DSCP.c
$ ll ipt_dscp.c ipt_DSCP.c
-r--r-----  1 me me 2753 Jan 29  2004 ipt_dscp.c
-r--r-----  1 me me 2753 Jan 29  2004 ipt_DSCP.c

With cifs, a directory search shows different sizes but opening
them by name gives identical contents:

$ ll ipt_dscp* ipt_DSCP*
-r-------- 1 me me 1581 Jan 28  2004 ipt_dscp.c
-r-------- 1 me me 2753 Jan 29  2004 ipt_DSCP.c
$ ll ipt_dscp.c ipt_DSCP.c
-r-------- 1 me me 1581 Jan 28  2004 ipt_dscp.c
-r-------- 1 me me 1581 Jan 28  2004 ipt_DSCP.c
$ diff ipt_dscp.c ipt_DSCP.c
$

So where is the bug? On the server?

-- 
MBTI: IXTP

