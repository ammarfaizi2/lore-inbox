Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVCGApf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVCGApf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVCGApf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:45:35 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:33727 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261613AbVCGAp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:45:28 -0500
Message-ID: <422BA422.6040802@yahoo.com.au>
Date: Mon, 07 Mar 2005 11:45:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Schmid <webmaster@rapidforum.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>
In-Reply-To: <4229E805.3050105@rapidforum.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid wrote:

> Today I tested with 5000 sockets. The problem is the same like above but 
> the more sockets there come, it just doesnt claim more bandwidth as it 
> SHOULD of course do. It seems it doesn't slow down but it just doesnt 
> scale anymore. The badwidth doesnt go over 80 MB/Sec, no matter what I 
> do. Then I did the following: I raised lower_zone_protection to 1024 
> (above I did 1024000 which is bullshit but it doesnt matter as it seems 
> to just protect the whole low-mem which is what I want) and it was at 80 
> MB. then I lowered to 0 again and suddenly it peaked up to full 
> bandwidth (100 MB) for about 5 seconds until the whole protected area 
> was in use. Then it slowed down drastically again.

This confirms my suspicion that lowmem / highmem scanning is not
properly balanced. When you raise lower_zone_protection a great
deal, lowmem is no longer used for pagecache, and your problem
goes away.

I gave you a patch to try for this - unfortunately I can't make
much more progress than that if I don't have a test case and you
can't test patches :\

Nick

