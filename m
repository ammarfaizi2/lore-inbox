Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTEZFRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTEZFRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:17:24 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:43784 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264264AbTEZFRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:17:22 -0400
Message-ID: <3ED1A7E2.6080607@kolumbus.fi>
Date: Mon, 26 May 2003 08:36:34 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: rmk@arm.linux.org.uk, akpm@digeo.com, hugh@veritas.com,
       LW@KARO-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
 least))
References: <20030523193458.B4584@flint.arm.linux.org.uk>	<1053919171.14018.2.camel@rth.ninka.net>	<3ED1A0FE.3000101@kolumbus.fi> <20030525.220852.42800415.davem@redhat.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 26.05.2003 08:31:42,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 26.05.2003 08:31:13,
	Serialize complete at 26.05.2003 08:31:13
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ah, ok. so there are cache issues even if if the user pte is not 
established yet? Then it seems natural to couple flush_dcache_page with 
pte establishing, not at the driver level.

--Mika


David S. Miller wrote:

>   From: **UNKNOWN CHARSET** <mika.penttila@kolumbus.fi>
>   Date: Mon, 26 May 2003 08:07:10 +0300
>
>   I don't think the flush_dcache_page thing is done almost anywhere in the 
>   block/driver level right now.
>
>It isn't and it shouldn't :-)
>
>   And we shouldn't be doing io reads to pagecache pages with user
>   mappings anyway normally. direct-io is a different thing.
>   
>We are talking about the case where we are bringing in the
>data for the first time, on the page cache lookup miss.
>
>  
>


