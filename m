Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWHHKHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWHHKHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWHHKHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:07:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:30810 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964778AbWHHKH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:07:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TQjMf1ZTAoP9LWeZneHM/yne3wtMNPkRPjAsPJPzxS2qHy44v01U5QV9kTJjpAaBo27o0tBU7rTAiYd8bvdRS6yf+YJZvfZf5Tk5ukgp1+M+LiRY71MamqY2oys7AbItGj8+UXonGGz1MQDZSc8Nd51I56P0XOXm+qmXSqLTjiQ=
Message-ID: <44D8626F.4020101@gmail.com>
Date: Tue, 08 Aug 2006 12:07:20 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Jason Lunz <lunz@gehennom.net>, Jiri Slaby <jirislaby@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com> <20060807162322.GA17564@knob.reflex> <200608072247.59184.rjw@sisk.pl>
In-Reply-To: <200608072247.59184.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Monday 07 August 2006 18:23, Jason Lunz wrote:
>> In gmane.linux.kernel, you wrote:
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
>>> I tried it and guess what :)... swsusp doesn't work :@.
>>>
>>> This time I was able to dump process states with sysrq-t:
>>> http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
>>>
>>> My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
>>> suspending device 2.0
>> Does it go away if you revert this?
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
>>
>> That should only affect resume, not suspend, but it does mess around
>> with ide power management. Is this maybe happening on the *second*
>> suspend?
>>
>>> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
>>> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
>> This looks suspicious. -mm does have several ide-fix-hpt3xx patches.
> 
> I found that git-block.patch broke the suspend for me.  Still have no idea
> what's up with it.

I suspect elevator changes. The wait_for_completion is not woken in ide-io by 
ll_rw_blk. But I don't understand block layer too much. Where the 
blk_end_sync_rq should be called from (why is not called at all)?

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
