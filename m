Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276380AbRJPQIT>; Tue, 16 Oct 2001 12:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276381AbRJPQIA>; Tue, 16 Oct 2001 12:08:00 -0400
Received: from web20901.mail.yahoo.com ([216.136.226.223]:42789 "HELO
	web20901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276380AbRJPQH4>; Tue, 16 Oct 2001 12:07:56 -0400
Message-ID: <20011016160828.26155.qmail@web20901.mail.yahoo.com>
Date: Tue, 16 Oct 2001 09:08:28 -0700 (PDT)
From: Ravi Chamarti <ravi_chamarti@yahoo.com>
Subject: Ref: zerocopy +netfilter performance problem.
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011016175908.A2258@se1.cogenit.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all.

I am kind of new to this forum and am not sure whether
to pose this question in linux-kernel or linux-net

I am using linux kernel 2.4.4 and having performance
problem using zerocopy code and netfilter code in the
kernel.

I have been using zerocopy path through network stack
and things are going fine with that. Until I tried
enabling netfilter support in the kernel. The way I am
using zerocopy code is by passing kernel physical
pages directly to tcp_sendpage and letting network
code and NIC do the rest.


I enabled only network packet filter option inorder to
register my own nf_hook. I haven't enabled other
options like netfitler debugging/socket
filtering/conntrack/iptables/ipchains compt. 
Idea is to register my hook and do a little work with
the packet header but not with the data. I do have one
small hook which just return NF_ACCEPT and do nothing
with the packet. 

I am not intending to use any netfilter hooks for
zerocopy path, however would like to use netfiler
hooks for some non-zerocopy path traffic. 


What I see that a skb with frag list is getting copied
in the netfilter hook call (nf_hook_slow) ( I guess
skb_linearize routine is remapping all physical pages
and copies into a kernel buffer). 


My question is that is this copy is required for
netfilter to work? Do we somehow get around
with netfilter to work such that the zerocopy path
passes the packet without any copy?

Thanks
Ravi Chamarti.


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
