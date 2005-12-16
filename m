Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVLPHH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVLPHH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 02:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVLPHH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 02:07:26 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:27552 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S932142AbVLPHH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 02:07:26 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Linux in a binary world... a doomsday scenario
To: Al Boldi <a1426z@gawab.com>, Helge Hafting <helge.hafting@aitel.hist.no>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 16 Dec 2005 07:57:21 +0100
References: <5jMcG-5mY-19@gated-at.bofh.it> <5jWON-3xQ-29@gated-at.bofh.it> <5jZk7-7iD-19@gated-at.bofh.it> <5k6bw-AI-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1En9Ws-00057W-3q@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi <a1426z@gawab.com> wrote:
>> Disadvantages of a stable API:

>> * It encourages binary-only drivers, while we prefer source drivers.
>>    Changing the API often and without warning is one way of
>>    hampering binary-only driver development without harming
>>    open-source drivers.
> 
> You are really shooting yourself in the foot here.

If binary drivers were a nice idea, it would be so, but unfortunately they
aren't. E.g.:

Nvidia stuffes a userspace library into the kernel. BAD.

Ati can't work correctly if there are other graphic cards in the system,
because they include functions from a different layer in their driver,
which off cause can't interface correctly. The WXP divers are affected,
too. Doubleplusungood.

Both of these drivers are about 7 times larger than the whole kernel image.
Other binary drivers are similar. That's a waste of resources.

DOS didn't have an API for non-FAT filesystems. In order to support ISO9660,
the network support was abused instead of changing the internals. Obviously
this defeated reasonable caching, and the drivers needed to add their own
cache implementation, which had to be maintained seperately. Double work,
and a waste of resources.

(The DOS internals usurally can't be changed because they are stable. The
stable API was too cumbersome for the programmer's needs, so they started
using the internal structures directly. Therefore there was no way to
increase the max. path length beyond 64 bytes.)

>> Do a stable API save us work?  No, because whoever changes the API
>> also fixes all in-kernel users of said API.
> 
> That's very inefficient.

More inefficient than adding a compatibility layer?

If each change has to add another compatibility layer, the calls will have
to traverse several functions without doing anything usefull. Multiply this
with the number of users, and you'll see that one millisecond of CPU time
will accumulate to a quarter of an hour for each million users. Multiply
this with thousands of calls each user will do within each hour, and you'll
see that within each hour, you'd waste more than eleven days of CPU time.
Within one day and a half, you have wasted a whole year. Within that time,
you can easily change the API several times. That is, unless you hold
meetings about how it should look like.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
