Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWFLAqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWFLAqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 20:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWFLAqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 20:46:49 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:61197 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751166AbWFLAqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 20:46:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 12 Jun 2006 00:46:36.0070 (UTC) FILETIME=[A86B2C60:01C68DB9]
Content-class: urn:content-classes:message
Subject: Re: Discovering select(2) parameters from driver's poll method 
Date: Sun, 11 Jun 2006 20:46:33 -0400
Message-ID: <Pine.LNX.4.61.0606112030540.13769@chaos.analogic.com>
In-reply-to: <200606092341.k59Nf6RJ003396@laptop11.inf.utfsm.cl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Discovering select(2) parameters from driver's poll method 
Thread-Index: AcaNuah0wExocFh7R7uGb97+Q8v8Ow==
References: <200606092341.k59Nf6RJ003396@laptop11.inf.utfsm.cl>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Cc: "Ozan Eren Bilgen" <oebilgen@uekae.tubitak.gov.tr>,
       "Linux e-posta listesi" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jun 2006, Horst von Brand wrote:

> Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr> wrote:
>> I agree you, but your assumption is correct for a generic device, not
>> mine.  The purpose of my driver is slightly different and is not to
>> realize user space request, like other drivers in Linux kernel do.  My
>> goal is to forward the userspace system call to a remote computer, and
>> therefore I need information about these variables in order to call them
>> correctly via an user space application on the remote host.
>
> In that case, this is /not/ a device... The "If it waddles like a duck, and
> quacks like a duck, it is (probably) a duck" can be turned around...
> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
> -

The driver's poll procedure is not the same as the kernel's poll.
Only the names seem similar. As previously told, the driver's poll
procedure is sometimes (many times) executed by the kernel, and not
necessarily when the user executes poll or select. Attempting to
find what the input parameters were, from inside the kernel, will
fail because 'current', dereferenced from the driver poll() hook
will not represent the caller's task.

To find out what the calling parameters were, the driver needs to
attach the kernel's poll vector, not the hook in the driver. It could
get the parameters, plus the caller's pid and, if the pid is the
same as the pid saved during a driver open(), put the parameters
somewhere in the driver before executing the previous vector.

An ioctl() call to the driver could obtain the saved parameters.

Also, there are existing remote procedure calls that are designed
for executing tasks on remote computers. One doesn't need to
destroy the integrity of the kernel. If one wants to invent ones
own, that's fine but that simply involves executing poll() or
select() on the remote computer -- directly by a RPC server
task.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
