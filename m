Return-Path: <linux-kernel-owner+w=401wt.eu-S1753460AbWLRHhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbWLRHhG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 02:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbWLRHhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 02:37:05 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:3675 "EHLO
	argo2k.argo.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753460AbWLRHhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 02:37:04 -0500
X-Greylist: delayed 1162 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 02:37:04 EST
Message-ID: <4586408C.2050408@argo.co.il>
Date: Mon, 18 Dec 2006 09:17:32 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-cifs-client <linux-cifs-client@lists.samba.org>,
       Steve French <sfrench@samba.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19.1 bug?  tar: file changed as we read it
References: <200612180106_MC3-1-D56B-FD2F@compuserve.com>
In-Reply-To: <200612180106_MC3-1-D56B-FD2F@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2006 07:17:33.0687 (UTC) FILETIME=[96523870:01C72274]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> Trying to backup up a filesystem mounted via CIFS, I got these messages
> from tar:
>
> tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_CONNMARK.c: File shrank by 1178 bytes; padding with zeros
> tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_TCPMSS.c: File shrank by 4177 bytes; padding with zeros
> tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_DSCP.c: File shrank by 1172 bytes; padding with zeros
> tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_tos.c: file changed as we read it
> tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_ECN.c: File shrank by 1638 bytes; padding with zeros
> tar: t/2.6.10-orig/net/ipv4/netfilter/ipt_mark.c: file changed as we read it
> tar: t/2.6.10-orig/net/ipv6/netfilter/ip6t_mark.c: file changed as we read it
>
> This was with kernel 2.6.19.1 SMP on x86_64, creating a tar file on a local
> jfs filesystem (t is the source path on a cifs mount.)
>
> Using 2.6.18.6-pre2 uniprocessor i386, with smbfs instead of cifs, everything
> works fine so I'm pretty sure the server is OK.
>
> Does this match any known problems?
>   

In 2.6.20-rc1, some of these files have other files with the same name 
in the same directory (modulo case).  Perhaps this is confusing cifs.

Can you check where all of the files in your case share that property?

example:

    [avi@firebolt linux-2.6]$ find net -iname ipt_tos.c
    net/ipv4/netfilter/ipt_TOS.c
    net/ipv4/netfilter/ipt_tos.c

    [avi@firebolt linux-2.6]$ find net -iname ipt_ecn.c
    net/ipv4/netfilter/ipt_ECN.c
    net/ipv4/netfilter/ipt_ecn.c


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

