Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311735AbSDDWbn>; Thu, 4 Apr 2002 17:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSDDWbY>; Thu, 4 Apr 2002 17:31:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:35083 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311735AbSDDWbP>; Thu, 4 Apr 2002 17:31:15 -0500
Message-ID: <3CACD3BC.1EB55BCC@zip.com.au>
Date: Thu, 04 Apr 2002 14:29:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ricardo Galli <gallir@uib.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Report: 2.4.18 very high latencies (with lowlat. and pre-empt 
 patches)
In-Reply-To: <E16tEL4-0006fr-00@antoli.gallimedina.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli wrote:
> 
> Hi all (second try),
>         Linux becomes somehow unusable when I edited sound files and also
> during NFS copy. I've noticed the same effects also during i/o loads, for
> example when closing kmail after I deleted some messages.
> 

It would help if you could come up with a simple test case
which exhibits this problem - some sequence of steps which
is reproducible by others, and which has repeatable effects.

Is your I/O system performing properly?  Try running

	hdparm -t /dev/hdaX

where /dev/hdaX refers to your root filesystem.  You
should get 15-30 megabytes per second.

You also report that your PPC-based laptop has processes
unexpectedly terminating when the machine is under VM
pressure.  You should check your kernel logs (usually
/var/log/messages) to see if the process was killed
due to an out-of-memory condition.  If it's not that,
and if it's not due to application bugs then the ppc
kernel may be dropping modified- or dirty-bits in its
PTEs, which is rather unlikely.

-
