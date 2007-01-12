Return-Path: <linux-kernel-owner+w=401wt.eu-S1161035AbXALIur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbXALIur (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 03:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbXALIur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 03:50:47 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:41722 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161035AbXALIuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 03:50:46 -0500
Message-ID: <45A74B89.4040100@hitachi.com>
Date: Fri, 12 Jan 2007 17:49:13 +0900
From: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) 
    Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
References: <457FA840.5000107@hitachi.com> 
    <20061213132358.ddcaaaf4.akpm@osdl.org> <20061220154056.GA4261@ucw.cz> 
    <45A2EADF.3030807@hitachi.com> <20070109143912.GC19787@elf.ucw.cz>
In-Reply-To: <20070109143912.GC19787@elf.ucw.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>>>  $ echo 1 > /proc/self/coremask
>>>>  $ ./some_program
>>>
>>>User can already ulimit -c 0 on himself, perhaps we want to use same
>>>interface here? ulimit -cmask=(bitmask)?
>>
>>Are you saying that 1) it is good to change ulimit (shell programs)
>>so that shell programs will read/write /proc/self/coremask when
>>the -cmask option is given to ulimit?
>>Or, 2) it is good to change ulimit and get/setrlimit so that shell
>>programs will invoke get/setrlimit with new parameter?

>>But the second approach is problematic because the bitmask doesn't
>>conform to the usage of setrlimit.  You know, setrlimit controls amount
>>of resources the system can use by the soft limit and hard limit.
>>These limitations don't suit for the bitmask.
> 
> Well, you can have it as set of 0-1 "limits"...

I have come up with a similar idea of regarding the ulimit
value as a bitmask, and I think it may work.
But it will be confusable for users to add the new concept of
0-1 limitation into the traditional resouce limitation feature.
Additionaly, this approach needs a modification of each shell
command.
What do you think about these demerits?

The /proc/<pid>/ approach doesn't have these demerits, and it
has an advantage that users can change the bitmask of any process
at anytime.

So I'm going to post the 2nd version patchset with /proc/<pid>/
interface.  If the 2nd version has crucial problems, I'll try
the ulimit approach.

Best regards,
-- 
Hidehiro Kawai
Hitachi, Ltd., Systems Development Laboratory



