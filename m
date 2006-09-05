Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWIETEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWIETEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWIETEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:04:38 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52385 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030228AbWIETEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:04:35 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44FDC9F5.3090605@s5r6.in-berlin.de>
Date: Tue, 05 Sep 2006 21:03:17 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking
 detected
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>	<20060905111306.80398394.akpm@osdl.org> <a44ae5cd0609051116k6c236ba6xa2fd0119708a6950@mail.gmail.com>
In-Reply-To: <a44ae5cd0609051116k6c236ba6xa2fd0119708a6950@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> On 9/5/06, Andrew Morton <akpm@osdl.org> wrote:
>> On Tue, 5 Sep 2006 10:37:51 -0700
>> "Miles Lane" <miles.lane@gmail.com> wrote:
>>
>>> ieee1394: Node changed: 0-01:1023 -> 0-00:1023
>>> ieee1394: Node changed: 0-02:1023 -> 0-01:1023
>>> ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0080880002103eae]
>>>
>>> =============================================
>>> [ INFO: possible recursive locking detected ]
>>> 2.6.18-rc5-mm1 #2
>>> ---------------------------------------------
>>> knodemgrd_0/2321 is trying to acquire lock:
>>>  (&s->rwsem){----}, at: [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
>>>
>>> but task is already holding lock:
>>>  (&s->rwsem){----}, at: [<f8959078>] nodemgr_host_thread+0x717/0x883 [ieee1394]

How often does this happen?

[...]
>> That's a 1394 glitch, possibly introduced by git-ieee1394.patch.
> 
> Would you like me to verify that removing the patch fixes it, or
> should I wait for the 2.6.18-rc6-mm1 tree?

My patches
"ieee1394: nodemgr: switch to kthread api, replace reset semaphore" and
"ieee1394: nodemgr: convert nodemgr_serialize semaphore to mutex"
may be relevant. They are included in git-ieee1394.patch.

Could you revert them individually and test? It should be possible to
just "patch -p1 -R < ...." the following patchfiles:
http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.18-rc5/patches/119-ieee1394-nodemgr-convert-nodemgr_serialize-semaphore-to-mutex.patch
If the problem persists, also revert
http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.18-rc5/patches/118-ieee1394-nodemgr-switch-to-kthread-api--replace-reset-semaphore.patch

If that does not help, install them again and unapply all ieee1394
patches from -mm. If you have the time.

Thanks a lot,
-- 
Stefan Richter
-=====-=-==- =--= --=-=
http://arcgraph.de/sr/
