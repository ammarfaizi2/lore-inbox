Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSGOSPU>; Mon, 15 Jul 2002 14:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSGOSPT>; Mon, 15 Jul 2002 14:15:19 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:8295 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S317570AbSGOSPR>; Mon, 15 Jul 2002 14:15:17 -0400
Date: Mon, 15 Jul 2002 13:18:05 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207151818.NAA10895@tomcat.admin.navo.hpc.mil>
To: FWeber@ndsuk.com, linux-kernel@vger.kernel.org
Subject: Re: Process-wise swap-on/off option
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Weber, Frank" <FWeber@ndsuk.com>:
> 
> Hello:
> 
> Is it possible to arrange that a Linux application 
> (or one of its threads) has the ability to
> 
> 	"... lock (a certain) stack and data segment ... 
> 	into memory so that it can't be swapped out"?
> 
> [This has been formulated as a requirement by one of 
> our analysts.]
> 
> I have been told that this is unlikely (except by 
> disabling swapout altogether (for all processes). 
> 
> Any hints as to where to look for a solution (i.e., 
> pointers to documentation or manuals where the ifs 
> and hows are explained) would be greatly appreciated.
> 
> Many thanks in advance,
> F.P.Weber
> 
> 
> P.S. Due to security on our mail-server i am unable to
> enrol or subscribe to the news-group. Please cc me into
> any replies. Thanks again.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

See manpage on "mlockall" system call. Also refer to the "mlock" system call.

I have a tendency to be suspicious of requirements to lock pages
in memory. If this is a dedicated, real-time task, then it is likely
to be "not really real-time" and does not really need to be locking
pages. I would suggest trying the application out without locking pages
first, since the fix for such paging is better handled by adding more
memory to the system instead. Locking pages means that you may get
failures due to the inability to handle short term memory pressure.

Another (cheap) way to prevent paging is to just not mount a swap file.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
