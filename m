Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266740AbUFYODt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266740AbUFYODt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266742AbUFYODt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:03:49 -0400
Received: from chnmfw01.eth.net ([202.9.145.21]:45073 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S266740AbUFYODe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:03:34 -0400
Message-ID: <004e01c45abd$35f8c0b0$b18309ca@home>
From: "Amit Gud" <gud@eth.net>
To: "Pavel Machek" <pavel@ucw.cz>, "alan" <alan@clueserver.org>
Cc: "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Elastic Quota File System (EQFS)
Date: Fri, 25 Jun 2004 19:32:44 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 25 Jun 2004 13:55:52.0328 (UTC) FILETIME=[20C3F080:01C45ABC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

>> > On one school server, theres 10MB quota. (Okay, its admins are
>> > BOFHs^H^H^H^H^HSISAL). Everyone tries to run mozilla there (because
>> > its installed as default!), and immediately fills his/her quota with
>> > cache files, leading to failed login next time (gnome just will not
>> > start if it can't write to ~).
>> >
>> > Imagine mozilla automatically marking cache files "elastic".
>> >
>> > That would solve the problem -- mozilla caches would go away when disk
>> > space was demanded, still mozilla's on-disk caching would be effective
>> > when there is enough disk space.

Also this is applicable to mailboxes - automize the marking of old mails of
the mailing list as elastic, whenever the threshold is reached, you might
either want to put those mails as compressed archive or simply delete it.
This has two advantages:
 - No email bounces for the reason of 'mailbox full' and
 - Optimized utlization of the mailbox

Yes, this can be done using scripts too, but what if you are to use other
users' space that they are not using? Of course script cannot do that! You
need to have some FS support or a libquota hack.


>>
>> How does Mozilla (or any process) react when its files are deleted from
>> under it?  Would the file remain until all the open processes close the
>> file or would it just "disappear"?
>
>Of course, if mozilla marked them "elastic" it should better be
>prepared for they disappearance. I'd disappear them with simple
>unlink(), so they'd physically survive as long as someone held them
>open.
>
>>  Would it delete entire directories or
>> just some of the files?  How does it choose?  (First up against the
delete
>> when the drive space fills...)
>
>Probably just some of the files... Or you could delete directory, too,
>if it was marked "elastic". What to delete first... probably file with
>oldest access time? Or random file, with chance of being selected
>proportional to file size?

One can either even mark the whole directory as elastic. When it comes to
taking action, I think I'II opt for random deletion of the files for not
being unfair to any particular user.

AG

