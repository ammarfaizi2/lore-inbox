Return-Path: <linux-kernel-owner+w=401wt.eu-S1751278AbWLLMmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWLLMmU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWLLMmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:42:20 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:44240 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbWLLMmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:42:19 -0500
Message-ID: <457EA384.2050402@gmail.com>
Date: Tue, 12 Dec 2006 13:41:40 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Jiri Kosina <jikos@jikos.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       linux-raid@vger.kernel.org
Subject: Re: oops on 2.6.19-rc6-mm2: deref of 0x28 at permission+0x7
References: <457A0F4C.9060601@gmail.com>	<Pine.LNX.4.64.0612102027350.1665@twin.jikos.cz>	<17788.48732.53210.631230@cse.unsw.edu.au>	<Pine.LNX.4.64.0612111034480.1665@twin.jikos.cz> <17789.64240.879603.161637@cse.unsw.edu.au>
In-Reply-To: <17789.64240.879603.161637@cse.unsw.edu.au>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Monday December 11, jikos@jikos.cz wrote:
>> On Mon, 11 Dec 2006, Neil Brown wrote:
>>
>>>> this nash thing is exactly the command which triggers a bit different 
>>>> oops in my case. On my side, the oops is fully reproducible. If you 
>>>> manage to make your case also reproducible, could you please try to 
>>>> revert md-change-lifetime-rules-for-md-devices.patch? This made the 
>>>> oops vanish in my case. I think Neil is working on it.
>>> Trying to work on it - not making a lot of progress.  I find it hard to 
>>> see how anything in md can cause the inode for a block-device file to 
>>> disappear... It is a bit of a long-shot, but this patch might change 
>>> things.  It changes the order in which things are de-allocated. Jiri and 
>>> Jiri: would either of both of you see if you can reproduce the bug with 
>>> this patch on 2.6.19-rc6-mm2 ???
>> Hi Neil,
>>
>> sorry to say that, but it's still there after applying your patch.
> 
> Not a big surprise, but thanks a lot for testing.  I think I'm going
> to have to try harder to duplicate it myself.

Away from that machine now, so that I can't test anything till thursday.

> If I remember rightly you are using FC - which version exactly?  (I've
> never installed FC before so this is going to be learning experience).

FC6 with latest updates.

> And you have no MD arrays at all - is that correct?

I do have. md1 md2 md3 -- raid0, 1, 0. But there is no md0 (removed in the past)
and 'raidautorun /dev/md0 | nash' causes the troubles.

> And you compile your own kernel.  Is it monolithic, or are you using
> modules?  Do you boot with an initrd or just the kernel?

Yup. Monolithic as much as possible (md is in the kernel and so dm is). / on the
lvm2 on the /dev/md1 with no initrd. All are sata disks, so sd_mod, sata_promise
and ata_piix are in the kernel.

> I'd like to duplicate your installation as closely as possible, so any
> relevant details or recipes would be greatly appreciated.

Hm, I have never seen FC6 installation process, so I can't say what special
option I have turned on -- it's 'yum upgrade'd from FC5, FC4...

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
