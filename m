Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWDQQwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWDQQwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWDQQwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:52:44 -0400
Received: from mga06.intel.com ([134.134.136.21]:37667 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750978AbWDQQwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:52:43 -0400
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24051498:sNHT33104820"
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24051472:sNHT46023047"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24059125:sNHT49570122"
Date: Mon, 17 Apr 2006 09:50:27 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@sgi.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Dean Nelson <dcn@sgi.com>
Subject: Re: Is notify_die being overloaded?
Message-ID: <20060417095026.B20168@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060415104355.GA7156@lnx-holt.americas.sgi.com> <2059.1145260330@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2059.1145260330@ocs3.ocs.com.au>; from kaos@sgi.com on Mon, Apr 17, 2006 at 05:52:10PM +1000
X-OriginalArrivalTime: 17 Apr 2006 16:52:28.0882 (UTC) FILETIME=[4FDA8320:01C6623F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 05:52:10PM +1000, Keith Owens wrote:
> 
> [*] It does not help that IA64 break.b <n> does not store the value of
>     <n> in cr.iim.  All break.b values look like break.b 0.  There used
>     to be code in traps.c to detect this and extract the value of
>     break.b, but a kprobes patch removed that code.
Yes, Kprobes code removed it because, by the time this cpu reads the ia64 instruction
to decode the break value,  at the same time on the other cpu, due to unregister_kprobes()
call, this instruction might be replace with the original instruction. Hence the 
reading/decoding the instruction might result in wrong break number. So not a good idea to 
decode the instruction.

-Anil
