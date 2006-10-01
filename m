Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWJAR2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWJAR2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWJAR2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:28:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3728 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932092AbWJAR2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:28:46 -0400
Message-ID: <451FFAC9.1050903@garzik.org>
Date: Sun, 01 Oct 2006 13:28:41 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/eventpoll: error handling micro-cleanup
References: <20061001124352.GA30263@havoc.gtf.org> <Pine.LNX.4.64.0610010900540.21285@alien.or.mcafeemobile.com> <451FE7E3.4050503@garzik.org> <Pine.LNX.4.64.0610010911231.21285@alien.or.mcafeemobile.com> <451FED1C.60900@garzik.org> <Pine.LNX.4.64.0610010934300.21285@alien.or.mcafeemobile.com>
In-Reply-To: <Pine.LNX.4.64.0610010934300.21285@alien.or.mcafeemobile.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Sun, 1 Oct 2006, Jeff Garzik wrote:
> 
>> Davide Libenzi wrote:
>>
>>> I just tried a `find /usr/src/linux-2.6.16/ -type f -exec grep -H -C 2
>>> PTR_ERR {} \;`
>>> and looked at the cases where the error variable is assigned in any case
>>> before the test. Same code pattern as, like:
>>>
>>> error = -EFAULT;
>>> if (copy_from_user(...))
>>> 	goto kaboom;
>> No, that's quite different.  I'm talking about
>>
>> 	ptr = get_a_pointer_from_somewhere()
>> 	error = PTR_ERR(ptr)
>>
>> See the difference?  The error variable is directly assigned from a
>> potentially-valid pointer.
> 
> So? Is PTR_ERR() defined and documented in a way that, if called with a 
> valid pointer, has an unexpected/faulty behaviour?

When called with a valid pointer, the value assigned to the return-code 
integer is essentially a random number.


> Again, I don't care either ways, but don't tell me you're not sure about 
> the countless occurrences. Take a look at:
> 
> `find $LINUXSRC -type f -exec grep -H -C 2 PTR_ERR {} \;`

Perhaps 1 out of every 100 or so hits from this find(1) is unprotected 
by IS_ERR().  IOW, what I've been describing here is quite rare.

	Jeff



