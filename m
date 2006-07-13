Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWGMSwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWGMSwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWGMSwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:52:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58085 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030289AbWGMSwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:52:09 -0400
In-Reply-To: <b0943d9e0607120333q7960077veef91d63d826003b@mail.gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Cc: "Catherine Zhang" <cxzhang@watson.ibm.com>, linux-kernel@vger.kernel.org,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OF77F433EA.44B73A82-ON852571AA.00677BE7-852571AA.0067A413@us.ibm.com>
From: Xiaolan Zhang <cxzhang@us.ibm.com>
Date: Thu, 13 Jul 2006 14:52:01 -0400
X-MIMETrack: Serialize by Router on D01ML605/01/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 07/13/2006 14:52:03,
	Serialize complete at 07/13/2006 14:52:03
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Catalin,

I have identified the problem and will submit a fix soon.  Could you let 
me know to which tree should I apply the fix against?

thanks,
Catherine

"Catalin Marinas" <catalin.marinas@gmail.com> wrote on 07/12/2006 06:33:54 
AM:

> Hi Catherine,
> 
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > This is most common
> > orphan pointer 0xf5a6fd60 (size 39):
> >   c0173822: <__kmalloc>
> >   c01df500: <context_struct_to_string>
> >   c01df679: <security_sid_to_context>
> >   c01d7eee: <selinux_socket_getpeersec_dgram>
> >   f884f019: <unix_get_peersec_dgram>
> >   f8850698: <unix_dgram_sendmsg>
> >   c02a88c2: <sock_sendmsg>
> >   c02a9c7a: <sys_sendto>
> >
> > cat /tmp/ml.txt | grep -c selinux_socket_getpeersec_dgram
> > 8442
> 
> I'm looking into the above leak report from kmemleak (the back trace
> to the kmalloc function). The "datagram getpeersec" patch went in as
> commit 877ce7c1b3afd69a9b1caeb1b9964c992641f52a. Have you noticed any
> abnormal increase in the slab statistics (especially size-64)?
> 
> Thanks.
> 
> -- 
> Catalin

