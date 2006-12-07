Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163230AbWLGTlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163230AbWLGTlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163231AbWLGTlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:41:22 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:41032 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163230AbWLGTlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:41:21 -0500
Message-ID: <45786E58.5070308@citd.de>
Date: Thu, 07 Dec 2006 20:41:12 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [usb-storage]  single bit errors on files stored on USB-HDDs
 via USB2/usb_storage
References: <Pine.LNX.4.44L0.0612071306180.3537-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0612071306180.3537-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Wed, 6 Dec 2006, Matthias Schniedermeyer wrote:
> 
> 
>>Hi
>>
>>
>>I'm using a Bunch auf HDDs in USB-Enclosures for storing files.
>>(currently 38 HDD, with a total capacity of 9,5 TB of which 8,5 TB is used)
>>
>>After i realised about a year(!) ago that the files copied to the HDDs
>>sometimes aren't identical to the "original"-files i changed my
>>procedured so that each file is MD5 before and after and deleted/copied
>>again if an error is detected.
>>
>>My averate file size is about 1GB with files from about 400MB to 5000MB
>>I estimate the average error-rate at about one damaged file in about
>>10GB of data.
>>
>>I'm not sure and haven't checked if the files are wrongly written or
>>"only" wrongly read back as i delete the defective files and copy them
>>again.
>>
>>Today i copied a few files back and checked them against the stored MD5
>>sums and 5 files of 86 (each about 700 MB) had errors. So i copied the 5
>>files again. 4 of the files were OK after that and coping the last file
>>the third time also resulted in the correct MD5.
>>
>>This time i kept the defective files and used "vbindiff" to show me the
>>difference. Strangly in EVERY case the difference is a single bit in a
>>sequence of "0xff"-Bytes inside a block of varing bit-values that
>>changed a "0xff" into a "0xf7".
>>Also interesting is that each error is at a 0xXXXXXXX5-Position
>>
>>Attached is a file with 5 of the 6 differences named 1-5. Of each of the
>>5 2x3 lines-blocks the first 3 lines are the original the following 3
>>lines contain the error in the middle row 6th value.
>>
>>NEVER did i see any messages in syslog regarding erros or an aborting
>>program due to errors passed down from the kernel or something like that.
> 
> 
> This was almost certainly caused by hardware flaws in the USB interface 
> chips of the enclosures.  There's nothing the kernel can do about it 
> because the errors aren't reported; all that happens is that incorrect 
> data is sent to or from the drive.

So pretty much all ich can do is to pray that the errors don't corrupt
the Filesystem-Metadata (XFS).

So i should definetly consider writing me a "NO-FS" where the
"filesystem"-part is stored elsewhere and the HDD contains 100% content
(Minus a Dummy-MBR-Block for sector 0). On the plus side such a
filesystem won't have any overhead at all, but on the flipside you loose
pretty much the whole content if you lose the metadata. But i guess in
my case it would considerably lower the risk of loosing data.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

