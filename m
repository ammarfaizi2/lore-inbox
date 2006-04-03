Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWDCNfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWDCNfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 09:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWDCNfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 09:35:46 -0400
Received: from web33012.mail.mud.yahoo.com ([68.142.206.76]:13448 "HELO
	web33012.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750866AbWDCNfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 09:35:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hfta9F8J+8lyWHRGkdXCMOvcbUpyTxMPa86MoL3lHXk1xe6+wp+Ba5tbLfXlJPFJi9K3m3JakWCDRRiNHEQfYocV7zn2hMI7A89xAc6wbf2HY3bw+7InyAaAww0+CJaUM+IP4L7RL+nzzTe70pZC26KPt09rEyCIZJpCWKMoXRs=  ;
Message-ID: <20060403133545.52779.qmail@web33012.mail.mud.yahoo.com>
Date: Mon, 3 Apr 2006 06:35:45 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Re: Problem with diskstats (kernel 2.6.15-gentoo-r1)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Toon van der Pas wrote:
 
> This morning I discovered a strange problem with the output of
> /proc/diskstats; the cciss driver only produces the first 4 fields:
>

It's working correctly so far as I can tell. 
Check block/genhd.c, diskstat_show().

It prints per-disk and per-partition information.
There are 4 fields printed for each partition, but more
fields per each disk.  (check your output again, and note
the lines for cciss/c0d0 and cciss/c0d1 (the disks) vs.
the lines for cciss/c0d?p? (the partitions.) Most of your 
devices in there don't have any partition information so 
you just see the per-disk lines, not the per-partition lines
since there are no partitions.  Cciss looks different
than the others because you actually have partitions on that 
device.

-- steve



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
