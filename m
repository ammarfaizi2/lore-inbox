Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVI2UiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVI2UiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVI2UiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:38:22 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40171 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751167AbVI2UiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:38:22 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <433C5049.9020505@s5r6.in-berlin.de>
Date: Thu, 29 Sep 2005 22:36:25 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Subject: Re: Fix broken module aliases in ieee1394
References: <20050929185732.GA31117@redhat.com> <20050929121038.54d4cef0.akpm@osdl.org>
In-Reply-To: <20050929121038.54d4cef0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.019) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
>>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=134047

This bug has been reported in 12/2004 (shame on us) at 
http://bugzilla.kernel.org/show_bug.cgi?id=3966

>>The ieee1394 drivers have buggered module aliases.
>>
>>alias:          char-major-171-0 * 16
>>
>>This is because MODULE_ALIAS_CHARDEV stringifies its arguments.
> 
> hm.  There are a bunch of 1394 patches in -mm which appear to remove
> most/all of this stuff.

Yes, that is the plan. These module aliases have been unnecessary for 
some time.

> So what-the-heck I think I'll send those patches on to Linus today.  Please
> review the result and send any remaining fixups on to Linus for 2.6.14. 
> (I'm offline for ~10 days, starting tomorrow).
> 
> 
> 
>>--- linux-2.6.13/drivers/ieee1394/amdtp.c~	2005-09-29 03:50:20.000000000 -0400
>>+++ linux-2.6.13/drivers/ieee1394/amdtp.c	2005-09-29 03:50:54.000000000 -0400
>>@@ -1234,7 +1234,7 @@ static void amdtp_add_host(struct hpsb_h
>> 
>> 	hpsb_set_hostinfo_key(&amdtp_highlevel, host, ah->host->id);
>> 
>>-	minor = IEEE1394_MINOR_BLOCK_AMDTP * 16 + ah->host->id;
>>+	minor = IEEE1394_MINOR_BLOCK_AMDTP + ah->host->id;
>> 
>> 	INIT_LIST_HEAD(&ah->stream_list);
>> 	spin_lock_init(&ah->stream_list_lock);
>>@@ -1297,4 +1297,4 @@ static void __exit amdtp_exit_module (vo
>> 
>> module_init(amdtp_init_module);
>> module_exit(amdtp_exit_module);
>>-MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_AMDTP * 16);
>>+MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_AMDTP);
[...same for the other 1394 hi-level drivers]

This not a correct fix as far as I can see. Each of these drivers has a 
block of minor numbers assigned, and we would need to create aliases for 
all of the numbers in the blocks --- if we wanted these aliases badly. 
Brief discussion in August:
http://marc.theaimsgroup.com/?l=linux1394-devel&t=112341382400002
-- 
Stefan Richter
-=====-=-=-= =--= ===-=
http://arcgraph.de/sr/
