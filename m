Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTE0R7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTE0R57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:57:59 -0400
Received: from adsl-67-122-203-155.dsl.pltn13.pacbell.net ([67.122.203.155]:54202
	"EHLO ext.storadinc.com") by vger.kernel.org with ESMTP
	id S264010AbTE0R4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:56:37 -0400
Message-ID: <3ED3A9D2.4030200@storadinc.com>
Date: Tue, 27 May 2003 11:09:22 -0700
From: manish <manish@storadinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <200305271936.34006.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva> <200305271952.34843.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>
>On Tue, 27 May 2003, Marc-Christian Petersen wrote:
>
>>On Tuesday 27 May 2003 19:47, Marcelo Tosatti wrote:
>>
>>Hi Marcelo,
>>
>>>>A pause is _not_ perfectly fine, even not to some extent. That pause we
>>>>are discussing about is a pause of the _whole_ machine, not just disk i/o
>>>>pauses. Mouse stops, keyboard stops, everything stops, who knows wtf.
>>>>
>>>Do you also notice them?
>>>
>>I do, people I know do also, numbers of those people only _I_ know are about
>>~30. I've reported this problem over a year ago while 2.4.19-pre time.
>>
>
>Can you please try to reproduce it with -aa?
>
>>>>That behaviour is absolutely bullshit for desktop users. For serverusage
>>>>you may not notice it in this dimension (mostly no X so no mouse), but
>>>>also for a server environment this may be very bad.
>>>>
>>>Agreed.
>>>
Hello !

After several tests, I have noticed that I can produce this problem 
easily when my bdflush settings are:

30   50      32      100     50      300   60       0       0

and it occurs very less frequently when my settings are:

2       50      32      100     50      300     1       0       0


Right now, I noticed the following stack trace for one such stuck process:

sys_read
generic_file_read
do_generic_file_read
page_cache_read
__alloc_pages
balance_classzone
try_to_free_pages
shrink_caches
shrink_cache
try_to_release_page
try_to_free_buffer
sync_page_buffers
wait_on_buffer
__wait_on_buffer
schedule

Thanks
-Manish









