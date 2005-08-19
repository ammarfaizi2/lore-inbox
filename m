Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVHSVCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVHSVCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVHSVCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:02:36 -0400
Received: from magic.adaptec.com ([216.52.22.17]:47848 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965114AbVHSVCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:02:35 -0400
Message-ID: <430648E8.9070902@adaptec.com>
Date: Fri, 19 Aug 2005 17:02:32 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Anderson <andmike@us.ibm.com>
CC: Patrick Mansfield <patmans@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com> <4306290B.6080608@adaptec.com> <20050819193853.GA1549@us.ibm.com> <43063B03.8050008@adaptec.com> <20050819202954.GA22563@us.ibm.com>
In-Reply-To: <20050819202954.GA22563@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2005 21:02:33.0116 (UTC) FILETIME=[51852DC0:01C5A501]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/05 16:29, Mike Anderson wrote:
> Luben Tuikov <luben_tuikov@adaptec.com> wrote:
>>Consider this: When SCSI Core told you that the command timed out,
>>	A) it has already finished,
>>	B) it hasn't already finished.
>>
>>In case A, you can return EH_HANDLED.  In case B, you return
>>EH_NOT_HANDLED, and deal with it in the eh_strategy_handler.
>>(Hint: you can still "finish" it from there.)
>>
> 
> 
> But dealing with it in the eh_strategy_handler means that you may be
> stopping all IO on the host instance as the first lun returns
> EH_NOT_HANDLED for LUN based canceling.

Hi Mike, how are you?

Yes, this is true.  See my email to Patrick.
 
> I still think we can do better here for an LLDD that cannot execute a
> cancel in interrupt context.

This is the key!

Think about this:
	You do not need to cancel a command to cancel a command. ;-)
 
> Having a error handler that works is a plus, I would hope that
> some factoring would happen over time from the eh_strategy_handler to
> some transport (or other factor point) error handler. I would think from a
> testing, support, and block level multipath predictability sharing code
> would be a good goal.

Yes, definitely.  Hopefully I'll be posting code soon.

	Luben



