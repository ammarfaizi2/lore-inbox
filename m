Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVCKRdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVCKRdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVCKRdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:33:55 -0500
Received: from port-212-202-144-146.static.qsc.de ([212.202.144.146]:58570
	"EHLO mail.hennerich.de") by vger.kernel.org with ESMTP
	id S261223AbVCKRdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:33:07 -0500
Date: Fri, 11 Mar 2005 18:32:07 +0100
From: Tobias Hennerich <Tobias@Hennerich.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Alexander Nyberg <alexn@dsv.su.se>
Subject: Re: Strange memory leak in 2.6.x
Message-ID: <20050311183207.A22397@bart.hennerich.de>
References: <20050308133735.A13586@bart.hennerich.de> <20050308173811.0cd767c3.akpm@osdl.org> <20050309102740.D3382@bart.hennerich.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20050309102740.D3382@bart.hennerich.de>; from Tobias@Hennerich.de on Wed, Mar 09, 2005 at 10:27:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rehi,

> > Please grab 2.6.11, apply the below patch, set CONFIG_PAGE_OWNER and follow
> > the below instructions.
> 
> thank you for you mails. We installed the patch from Alex on a test-system
> last night and will switch it to the production machine this evening. The
> problem will start after 48-72 hours, so we hope to send feedback
> on friday.

Ok, we had another crash this morning after an uptime of only 36
hours 8-(.

No oom-killer this time, but we got a very high load (>40) in the
end. Our cron-job which starts the page_owner-sort every 10 minutes
didn't return the last 4 times.

The new 2.6.11-kernel changed the graphs a little bit - values for
'MemTree' are much higher, but values for 'Cached' and 'Buffered' are
still very low.

Here the graph for the last week:

  http://download.hennerich.de/memory-leak2.png

(the left part is the same like our first graph last week
http://download.hennerich.de/memory-leak.png, the weekend is well visible)

Detailed view of the last 40 hours:

  http://download.hennerich.de/memory-leak3.png

Some output of the page_owner-sort:

  http://download.hennerich.de/page_owner_sorted_20050310_0000.bz2
  http://download.hennerich.de/page_owner_sorted_20050310_0800.bz2
  http://download.hennerich.de/page_owner_sorted_20050310_1600.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0000.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0400.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0700.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0710.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0720.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0730.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0740.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0750.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0800.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0810.bz2
  http://download.hennerich.de/page_owner_sorted_20050311_0820.bz2

If you need any other information, please ask...

Best regards	Tobias

-- 
T+T Hennerich GmbH --- Zettachring 12a --- 70567 Stuttgart
Fon:+49(711)720714-0  Fax:+49(711)720714-44  Vanity:+49(700)HENNERICH
UNIX - Linux - Java - C  Entwicklung/Beratung/Betreuung/Schulung
http://www.hennerich.de/
