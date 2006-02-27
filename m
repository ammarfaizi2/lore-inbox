Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWB0QNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWB0QNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 11:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWB0QNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 11:13:05 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:22316 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751477AbWB0QNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 11:13:04 -0500
In-Reply-To: <1140986335.8697.139.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org> <1140986335.8697.139.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <77448EF2-4D5F-4E7C-B1A5-6164A88E43C7@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for !MULTIPLATFORM
Date: Mon, 27 Feb 2006 10:12:44 -0600
To: Dave Hansen <haveblue@us.ibm.com>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 26, 2006, at 2:38 PM, Dave Hansen wrote:

> On Fri, 2006-02-24 at 10:54 -0600, Kumar Gala wrote:
>> +       if (strstr(cmd_line, "mem=")) {
>> +               char *p, *q;
>> +               unsigned long maxmem = 0;
>> +
>> +               for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
>> +                       q = p + 4;
>> +                       if (p > cmd_line && p[-1] != ' ')
>> +                               continue;
>> +                       maxmem = simple_strtoul(q, &q, 0);
>> +                       if (*q == 'k' || *q == 'K') {
>> +                               maxmem <<= 10;
>> +                               ++q;
>> +                       } else if (*q == 'm' || *q == 'M') {
>> +                               maxmem <<= 20;
>> +                               ++q;
>> +                       } else if (*q == 'g' || *q == 'G') {
>> +                               maxmem <<= 30;
>> +                               ++q;
>> +                       }
>> +               }
>> +               memory_limit = maxmem;
>> +       }
>
> You may want to check out lib/cmdline.c's memparse() function.  I  
> think
> it does this for you.

Yeah, found it after I sent the patch.  Since Linus applied this  
version, I'll provide Paul a version that changes this code to use  
memparse for post 2.6.16.

- kumar
