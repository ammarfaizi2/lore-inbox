Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVCUQfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVCUQfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 11:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVCUQfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 11:35:39 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:22171 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261201AbVCUQf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 11:35:26 -0500
Message-ID: <423EF7B5.2030507@nortel.com>
Date: Mon, 21 Mar 2005 10:35:01 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: Short sleep precision
References: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr> <Pine.LNX.4.62.0503201335420.2501@dragon.hyggekrogen.localhost> <Pine.LNX.4.61.0503201427010.31416@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503201427010.31416@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>You can spin on the gettimeofday() result in userspace.
> 
> 
> How can I use it?

Something like:

gettimeofday(&curtime,0);
add_usecs(&curtime,  time_to_sleep);
do {
	gettimeofday(&curtime,0);
} while (time_before(&curtime, &expiry);


Of course, if someone changes the system time on you you're screwed....

Chris
