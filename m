Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVDUJml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVDUJml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 05:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVDUJmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 05:42:40 -0400
Received: from cernmx04.cern.ch ([137.138.166.167]:19242 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S261231AbVDUJmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 05:42:37 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding; 
	b=UBPhXY32FjDwaxnYfoCjOPPaWvx2rp+SftZgfTsDcZ3GhIcbV1y3b/qtQiBWIVA3CpihCLx1dpQFQbChyRSy0wjYgr7+GimoJkAZIOhL7ZPuURp0JJpRupX8KCfUgk9M;
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX04 CERN MX v2.0 050413.1147 Release
Message-ID: <42677587.8030707@cern.ch>
Date: Thu, 21 Apr 2005 11:42:31 +0200
From: Bartlomiej ZOLNIERKIEWICZ <Bartlomiej.Zolnierkiewicz@cern.ch>
Organization: CERN
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Red Hat/1.7.6-1.4.2.cern
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Hirstius <Andreas.Hirstius@cern.ch>
CC: Gelato technical <gelato-technical@gelato.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7
 and later
References: <42669357.9080604@cern.ch> <42668977.5060708@utah-nac.org>	 <42676501.8030805@cern.ch> <58cb370e05042102272ce70f2@mail.gmail.com>
In-Reply-To: <58cb370e05042102272ce70f2@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2005 09:42:35.0054 (UTC) FILETIME=[7268F4E0:01C54656]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> A small update.
> 
> Patching mm/filemap.c is not necessary in order to get the improved
> performance!
> It's sufficient to remove roundup_pow_of_two from  |get_init_ra_size ...
> 
> So a simple one-liner changes to picture dramatically.
> But why ?!?!?

roundup_pow_of_two() uses fls() and ia64 has buggy fls() implementation
[ seems that David fixed it but patch is not in the mainline yet]:

http://www.mail-archive.com/linux-ia64@vger.kernel.org/msg01196.html

That would also explain why you couldn't reproduce the problem on ia32 
Xeon machines.

Bartlomiej
