Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbULUKYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbULUKYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 05:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbULUKYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 05:24:08 -0500
Received: from piglet.wetlettuce.com ([82.68.149.69]:41088 "EHLO
	piglet.wetlettuce.com") by vger.kernel.org with ESMTP
	id S261728AbULUKYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 05:24:01 -0500
Message-ID: <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com>
Date: Tue, 21 Dec 2004 10:23:40 -0000 (GMT)
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
From: "Mark Broadbent" <markb@wetlettuce.com>
To: <mpm@selenic.com>
In-Reply-To: <20041221005521.GD5974@waste.org>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com>
        <20041216211024.GK2767@waste.org>
        <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com>
        <20041217215752.GP2767@waste.org>
        <20041217233524.GA11202@electric-eye.fr.zoreil.com>
        <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com>
        <20041220211419.GC5974@waste.org>
        <20041221002218.GA1487@electric-eye.fr.zoreil.com>
        <20041221005521.GD5974@waste.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <romieu@fr.zoreil.com>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Reply-To: markb@wetlettuce.com
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Mail is clear of Viree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt Mackall said:
> On Tue, Dec 21, 2004 at 01:22:18AM +0100, Francois Romieu wrote:
>> Matt Mackall <mpm@selenic.com> :
>> > On Mon, Dec 20, 2004 at 09:42:08AM -0000, Mark Broadbent wrote:
>> > >
>> > > Exactly the same happens, I still get a 'NMI Watchdog detected
>> > > LOCKUP' with the r8169 device using the above patch on top of
>> > > 2.6.10-rc3-bk10.
>> >
>> > Ok, that suggests a problem localized to netpoll itself. Do you have
>> > spinlock debugging turned on by any chance?
>>
>> Any chance of:
>> 1 dev_queue_xmit
>> 2 dev->xmit_lock taken
>> 3 interruption
>> 4 printk
>> 5 netconsole write
>> 6 dev->xmit_lock again
>> 7 lockup
>>
>> ?
>>
>> This is probably the silly question of the day.
>
> Maybe, but the answer isn't obvious to me at the moment as I haven't
> been thinking about such stuff enough lately. Silly response of the
> day:
>
> Mark, can you try this (again completely untested, but at least
> compiles) patch? I'm afraid I don't have a proper test rig to
> reproduce this at the moment. This will attempt to grab the lock, and
> if it fails, will check for recursion. Then it will try to print a
> message on the local console, temporarily disabling netconsole to
> allow the printk to get through..

OK, patch applied and spinlock debugging enabled.  Testing with eth1
(r1869) doesn'tyield any additional messages, just the standard 'NMI Watchdog detected
lockup'.
Thanks
Mark

-- 
Mark Broadbent <markb@wetlettuce.com>
Web: http://www.wetlettuce.com



