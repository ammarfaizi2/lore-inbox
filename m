Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311858AbSCUQcM>; Thu, 21 Mar 2002 11:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311868AbSCUQcE>; Thu, 21 Mar 2002 11:32:04 -0500
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:65294 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S311858AbSCUQbx>; Thu, 21 Mar 2002 11:31:53 -0500
From: nicholas black <dank@trellisinc.com>
To: linux-kernel@vger.kernel.org
Cc: Vinolin <vinolin@nodeinfotech.com>
Subject: Re: ip_options.c
In-Reply-To: <02032116405005.00890@Vinolin>
X-Newsgroups: mlist.linux-kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19ext3 (i686))
Message-Id: <20020321163151.53841A3C21@fancypants.trellisinc.com>
Date: Thu, 21 Mar 2002 11:31:51 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <02032116405005.00890@Vinolin> you wrote:
> Can i get the summary of what exactly ip_options.c is doing ?
> Through any web page or documents ...

it deals with ip options (see rfc's 791 and 1122).  

ip_options_build is called while putting together the headers, but
prior to checksumming from numerous places in net/ipv4/ip_output.c.  

ip_options_fragment does special handling for options in fragmented
datagrams (again, ip_output.c).

ip_options_echo is used to setup the options used in a reply; see
net/ipv4/icmp.c et al.

ip_options_compile and ip_options_get both seem to be used to extract raw
options from an skb.

ip_options_forward handles setting up source-routed packets, while 
ip_options_rcv_srr handles their receipt.

i am by not any mean at all an authority on these matters, so take this with
a grain of salt :).

-- 
nicholas black (dank@trellisinc.com)
"c has types for a reason.  c++ improved the type system for a reason.  perl
 and php programs have run-time failures for a reason." - lkml
