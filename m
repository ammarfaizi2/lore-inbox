Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUEEL63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUEEL63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 07:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUEEL63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 07:58:29 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:20184 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S264578AbUEEL6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 07:58:25 -0400
Message-ID: <4098D6CB.5050501@metaparadigm.com>
Date: Wed, 05 May 2004 19:58:03 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Libor Vanek <libor@conet.cz>, Bart Samwel <bart@samwel.tk>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
References: <20040503000004.GA26707@Loki> <4098BC2B.4080601@samwel.tk> <20040505101902.GB6979@Loki> <200405051354.43397.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200405051354.43397.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/04 18:54, Denis Vlasenko wrote:
> On Wednesday 05 May 2004 13:19, Libor Vanek wrote:
> 
>>>Libor Vanek wrote:
>>>
>>>>OK - how can I "notify" userspace process? Signals are "weak" - I need
>>>>to send some data (filename etc.) to process. One solution is "on this
>>>>signal call this syscall and result of this syscall will be data you
>>>>need" - but I'd prefer to handle this in one "action".
>>>
>>>My first thoughts are to make it a blocking call.
>>
>>You mean like:
>>- send signal to user-space process
>>- wait until user-space process pick ups data (filename etc.), creates copy
>>of file (or whatever) and calls another system call that he's finished -
>>let kernel to continue syscall I blocked
>>?
> 
> 
> I think he meant that userspace daemon should do a blocking syscall
> (a read for example). When that returns, daemon knows he has
> something to do.

Much like coda already does IIRC - kernel wakes userspace blocking on a
read to your special device, userspace 'writes' result back to special
device. This was an idea for a generic userspace upcall mechanism
originated by Alan Cox with his psdev circa 2.0/2.2 ?? which formed the
basis of the coda filesystem which does close to what you would want.

I've written a userspace block device driver interface using this
mechanism also (unpublished as of today, not wanting to compete with
nbd and enbd - it is unlike enbd which blocks on an ioctl and far
far simpler.

   http://gort.metaparadigm.com/userblk/

This way to do zero-copy by using mmap on your special device
(which I plan to do for my userspace block device interface).

~mc
