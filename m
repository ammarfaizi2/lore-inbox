Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUBYVmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUBYVlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:41:06 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:51926 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261616AbUBYVja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:39:30 -0500
Message-ID: <403D1608.7060706@blue-labs.org>
Date: Wed, 25 Feb 2004 16:39:20 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
References: <403C014F.2040504@blue-labs.org> <20040225091425.GA16783@elektroni.ee.tut.fi>
In-Reply-To: <20040225091425.GA16783@elektroni.ee.tut.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

powerix root # grep cpu /proc/stat; cat /proc/uptime
cpu  403880 466666 580559 15017904 475868 10864 3030
cpu0 403880 466666 580559 15017904 475868 10864 3030
186882.63 154999.74

(gdb) p 403880 +466666 +580559 +15017904 +475868 +10864 +3030
$1 = 16958771

(gdb) p 16958771/186882.63
$2 = 90.745571164104447

Hmm, not quite 100.0

david

Petri Kaukasoina wrote:

>Hi,
>
>I reported the same problem some time ago. Could you type
>
>grep cpu /proc/stat; cat /proc/uptime
>
>for example, I get
>
>cpu  140708 1489 43735 21209021 292168 4879 4192
>cpu0 140708 1489 43735 21209021 292168 4879 4192
>216925.15 215037.34
>
>Then add jiffies and divide by uptime:
>
>(140708+1489+43735+21209021+292168+4879+4192)/216925.15 = 100.01695
>
>which is not 100 here as it should be. (On kernel 2.2.* I have it exactly
>100). ps uses Hertz=100 but it should be 170 ppm larger which makes an error
>of about 15 seconds a day. (Running without ntpd doesn't fix it.)
>  
>
