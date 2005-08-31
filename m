Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVHaDpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVHaDpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 23:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHaDpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 23:45:19 -0400
Received: from smtpout.mac.com ([17.250.248.86]:7618 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932347AbVHaDpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 23:45:18 -0400
In-Reply-To: <1125459207.32272.114.camel@phantasy>
References: <20050830194632.GA13346@hsnr.de> <1125459207.32272.114.camel@phantasy>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8683E96C-A236-481D-8512-3B7728BDD955@mac.com>
Cc: Juergen Quade <quade@hsnr.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: inotify and IN_UNMOUNT-events
Date: Tue, 30 Aug 2005 23:44:54 -0400
To: Robert Love <rml@novell.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2005, at 23:33:27, Robert Love wrote:
> On Tue, 2005-08-30 at 21:46 +0200, Juergen Quade wrote:
>
>> Playing around with inotify I have some problems
>> to generate/receive IN_UNMOUNT-events (using
>> a self written application and inotify_utils-0.25;
>> kernel 2.6.13).
>>
>> Doing:
>> - mount /dev/hda1 /mnt
>> - add a watch to the path /mnt/ ("./inotify_test /mnt")
>> - umount /mnt
>>
>> results in two events:
>> 1. IN_DELETE_SELF (mask=0x0400)
>> 2. IN_IGNORED     (mask=0x8000)
>>
>> Any ideas?
>
> "/mnt" is not unmounted, stuff inside of it is.
>
> Watch, say, "/mnt/foo/bar" and when /dev/hda1 is unmounted, you  
> will get
> an IN_UNMOUNT on the watch.

I think this might work as well:
# mount /dev/hda1 /mnt
# ./inotify_test /mnt/. &
# umount /mnt

That should get the effect you are looking for

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at
it in the right way, did not become still more complicated.
   -- Poul Anderson



