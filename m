Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUGNK4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUGNK4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUGNK4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:56:13 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:36291 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S267358AbUGNK4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:56:11 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard filesystem types for crash dumping 
In-reply-to: Your message of "Wed, 14 Jul 2004 03:49:35 -0400."
             <40F4E58F.7040204@pobox.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Jul 2004 20:55:56 +1000
Message-ID: <3307.1089802556@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 03:49:35 -0400, 
Jeff Garzik <jgarzik@pobox.com> wrote:
>Keith Owens wrote:
>> Follow ups to lkml please, to keep any discussion on the same list.
>> 
>> Several kernel additions exist for saving crash dump information, among
>> them are lkcd, crash, kmsgdump.  They all have the same problems :-
>> 
>> * Where to store the crash data.
>> * How to write data when the kernel is unreliable, it may not be
>>   servicing interrupts.
>> * User space needs to read and clear the dump data.
>> * Performance!
>> * Coexistence of multiple dump drivers.
>
>
>Have you tried diskdump?
>
>It already exists, and seems to address these things.

diskdump adds polling mode disk I/O, but the polling code is tied to
the diskdump code path, so it cannot easily be used by other dump code.
It was while I was trying to generalize diskdump that I realized we
keep reinventing this particular wheel, both in kernel and user space.

diskdump only handles one device, that device cannot be used for other
dump tools and it needs special user space tools to extract the data.
As I said further down the original RFC, I am using the polling code
from diskdump but converting it to a clean API that can be used by any
dump code, as well as removing the need for special user space tools to
dig into partitions to see what has been dumped.

