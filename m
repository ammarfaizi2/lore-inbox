Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVK1Nce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVK1Nce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVK1Nce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:32:34 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:44304 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932094AbVK1Nce convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:32:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <E1EfmO0-0000rX-KE@be1.lrz>
X-OriginalArrivalTime: 28 Nov 2005 13:32:31.0822 (UTC) FILETIME=[2F376EE0:01C5F420]
Content-class: urn:content-classes:message
Subject: Re: defective RAM: corrupted ext3 FS. How to identify corrupted files/directories?
Date: Mon, 28 Nov 2005 08:32:29 -0500
Message-ID: <Pine.LNX.4.61.0511280810280.7501@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: defective RAM: corrupted ext3 FS. How to identify corrupted files/directories?
Thread-Index: AcX0IC9DyFnxARAtQRuhXJw4VjDRug==
References: <5cJ9S-44L-3@gated-at.bofh.it> <E1EfmO0-0000rX-KE@be1.lrz>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <7eggert@gmx.de>
Cc: "jerome lacoste" <jerome.lacoste@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Nov 2005, Bodo Eggert wrote:

> jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
>> My RAM died, and it corrupted my file system. It seems like this
>> machine just wants to die... [1]
>>
>> After removing the faulty RAM, I can boot. I made extensive memtest86+ tests.
>> I now have my home partition mounted as read-only because of said corruption.
>>
>> I see a bunch of "ext3_readdir: directory xxxx contains a hole at
>> offset xxxxx"  when I try to access some parts of my disk.
>>
>> I postponed fscking the FS until I have identified the faulty data.
>>
>> I was thinking of doing a rsync --dry-run against a known working
>> backup and check the logs. Any better idea? Is there a way to convert
>> the directory IDs into file paths?
>>
>> I have around 500 000 files on that partition. It takes time checking them
>> all.
>
> 1) Use the backup to get a base on a completely seperate HDD.
> 1a) Feel glad about having a backup.
> 2) Find new and changed files on the corrupted disk.
> 3) For each of the files found, inspect it's contents and copy it over
>   if it's non-corrupted. You can't automatically find corrupted files
>   unless you know otherwise.
> 4) mkfs
> --
> Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
> verbreiteten Lügen zu sabotieren.
> -

Every file on that disk could be defective, even those that were never
accessed. This is because of the device buffering which is independent
of the file-system.

I'd advise copying off (using tar) all user-files to backup media.
Then initialize the file-system(s) on the device from scratch.
Reinstall your OS., then restore the user-files from backups or
the files you copied if they were not backed up previously.

Prior to reinstalling, you can save some of the initialization files
that are still readable and ASCII (like /etc/passwd, and /etc/group).
Remember to execute `pwconv` after copying them back onto the new
distribution.

This might be the time to install the "latest and greatest" distribution.
A few years ago, I had a similar situation where I had religiously made
backups every night. I had been backing up corrupt files! Fortunately
most of the data was 'C' language source-files and headers. The
users were able to find and fix them by attempting to recompile them.
One directory tree had about 3,000 files of which at least 1/2 had
to be fixed. This took one user over a month so this was not trivial.
Some of the source-file problems were not visible! There might be
added spaces after some macros. These were the killers to find!

If you have CRC capability on your RAM, make sure it's turned ON in
the BIOS. It's much better to crash as a result of a bad bit then
to have a "few" bad bits in every file.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
