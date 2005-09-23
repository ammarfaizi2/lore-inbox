Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVIWSB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVIWSB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVIWSB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:01:28 -0400
Received: from smtpout.mac.com ([17.250.248.89]:57046 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750931AbVIWSB1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:01:27 -0400
In-Reply-To: <43343FC9.5090601@cosmosbay.com>
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de> <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de> <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com> <4332D2D9.7090802@cosmosbay.com> <20050923171120.GO731@sunbeam.de.gnumonks.org> <43343FC9.5090601@cosmosbay.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <F0FB4318-1AAF-4A84-8DCD-740877F013D3@mac.com>
Cc: Harald Welte <laforge@netfilter.org>,
       Christoph Lameter <clameter@engr.sgi.com>, Andi Kleen <ak@suse.de>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Date: Fri, 23 Sep 2005 14:00:58 -0400
To: Eric Dumazet <dada1@cosmosbay.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 23, 2005, at 13:47:53, Eric Dumazet wrote:
> Harald Welte a écrit :
>> I see a contradiction in your sentence.  "a new ip_tables is  
>> loaded" every time a user changes a single rule.  There are  
>> numerous setups that dynamically change the ruleset (e.g. at  
>> interface up/down point, or even think of your typical wlan  
>> hotspot, where once a user is authorized, he'll get different rules.
>
> But a user changing a single rule usually calls (fork()/exec()) a  
> program called iptables. The  underlying cost of all this, plus  
> copying the rules to user space, so that iptables change them and  
> reload them in the kernel is far more important than an  
> hypothetical vmalloc_node() performance problem.

Yeah, if you're really worried about the cost of iptables  
manipulations, you should probably write your own happy little C  
program to atomically load, update, and store the rules.  Even then,  
the cost of copying the whole ruleset to userspace for modification  
is probably greater than that of memory allocation issues, especially  
if the ruleset is large enough that memory allocation issues cause  
problems :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+ 
++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


