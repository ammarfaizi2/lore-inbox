Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVFNRkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFNRkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFNRkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 13:40:10 -0400
Received: from [80.71.243.242] ([80.71.243.242]:8155 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261267AbVFNRja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 13:39:30 -0400
To: P@draigBrady.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: optimal file order for reading from disk
References: <42AEBDC4.2050907@draigBrady.com>
	<20050614121320.GA4739@outpost.ds9a.nl> <42AEE2D5.50902@draigBrady.com>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Tue, 14 Jun 2005 21:39:31 +0400
In-Reply-To: <42AEE2D5.50902@draigBrady.com> (P.'s message of "Tue, 14 Jun
 2005 14:59:49 +0100")
Message-ID: <m1br6896ss.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P@draigBrady.com writes:

> bert hubert wrote:
>> On Tue, Jun 14, 2005 at 12:21:40PM +0100, P@draigBrady.com wrote:
>>
>>>I know this will be dependent on filesystem, I/O scheduler, ...
>>>but given a list of files, what is the best (filesystem
>>>agnostic) order to read from disk (to minimise seeks).
>>>
>>>Should I sort by path, inode number, getdents, or something else?
>> I know several projects that sort on inode number and benefit from
>> that,
>> sometimes in a big way. The effect of this will probably be less on a
>> matured filesystem image.
>
> Thanks for that. Yep I'm torn between sorting by inode which
> should be good for new filesystems, but maybe sorting by
> path would be better for mature filesystems?

Sorting by either inode number, or file name is not "file system
agnostic" way to minimize seeks.

You should call fibmap ioctl on all files, to obtain lists of block
numbers used by them, and then sort file list to minimize seeks.

>
>> I can't really explain why it helps though. I don't think the kernel will do
>> 'crossfile readahead', although your disk might do so.
>> Google on 'orlov allocator', is enlightning.
>
> I found some interesting into here thanks:
> http://kerneltrap.org/node/2157
>
> cheers,
> Pádraig.

Nikita.
