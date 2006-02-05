Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWBERFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWBERFh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 12:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWBERFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 12:05:37 -0500
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:18617 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1751184AbWBERFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 12:05:36 -0500
Message-ID: <43E630AB.6060006@kolumbus.fi>
Date: Sun, 05 Feb 2006 19:06:51 +0200
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
References: <20060205150259.1549.qmail@web33007.mail.mud.yahoo.com>
In-Reply-To: <20060205150259.1549.qmail@web33007.mail.mud.yahoo.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2|September 12, 2005) at 05.02.2006 19:05:28,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 05.02.2006 19:05:29,
	Serialize complete at 05.02.2006 19:05:29,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 05.02.2006 19:05:28,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 05.02.2006 19:05:29
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel wrote:

>Hi,
>
>It seems rotate_reclaimable_page fails most of the
>time due the page not being on the LRU when kswapd
>calls writepage().  The filesystem in my tests is
>ext3.  The attached patch against 2.6.16-rc2 moves the
>page to the LRU before calling writepage().  Below are
>results for a write test with:
>
>dd if=/dev/zero of=test bs=1024k count=1024
>
>To trigger the writeback path with the default dirty
>ratios, I set swappiness to 55 and mapped memory to
>about 80%.
>
>w/o patch (/proc/sys/vm/wb_put_lru = 0):
>
>pgrotcalls              25852
>pgrotnonlru             25834
>pgrotated               18
>
>with patch (/proc/sys/vm/wb_put_lru = 1):
>
>pgrotcalls              26616
>pgrotated               26616
>
>Thanks,
>Shantanu
>
>
>__________________________________________________
>  
>
 I think this BUGs easily because shrink_cache doesn't expect to see 
unfreeable pages put back to LRU.

--Mika

