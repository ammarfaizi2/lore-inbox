Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWJWT7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWJWT7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWJWT7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:59:42 -0400
Received: from mout0.freenet.de ([194.97.50.131]:22242 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1030189AbWJWT7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:59:41 -0400
Date: Mon, 23 Oct 2006 22:02:03 +0200
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [PATCH] 2.6.19-rc2-mm2 sysfs: sysfs_write_file() writes zero terminated data
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-15
MIME-Version: 1.0
References: <op.tht1yneaiudtyh@master> <20061022183924.GA18032@suse.de>
Content-Transfer-Encoding: 7bit
Message-ID: <op.thv4lpt0iudtyh@master>
In-Reply-To: <20061022183924.GA18032@suse.de>
User-Agent: Opera Mail/9.02 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry, maybe i missed something, but according to the
code in fs/sysfs/file.c the "write" sequence is:

- call to sysfs_write_file(ubuf, count)
- if (!sysfsbuf->page)  alloc zeroed page
- copy count bytes from ubuf to sysfsbuf->page
- call store(sysfsbuf->page, count)

When you write again to the file before closing it
(possible?!), and count is less the the previous count
you may not pass a zero terminated string/data to store().

-Thomas


Am 22.10.2006, 20:39 Uhr, schrieb Greg KH <gregkh@suse.de>:

> On Sun, Oct 22, 2006 at 07:17:47PM +0200, Thomas Maier wrote:
>> Hello,
>>
>> since most of the files in sysfs are text files,
>> it would be nice, if the "store" function called
>> during sysfs_write_file() gets a zero terminated
>> string / data.
>> The current implementation seems not to ensure this.
>> (But only if it is the first time the zeroed buffer
>> page is allocated.)
>
> Have you seen sysfs buffers being passed to the store() function in a
> non-null terminated manner?  How?
>
> Are you seeking backward and then writing again to the file somehow?
>
> thanks,
>
> greg k-h
>
>


