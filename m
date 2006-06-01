Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWFAXO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWFAXO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWFAXO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:14:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:34489 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750821AbWFAXO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:14:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rz1ugR2MtSBV+Y+M6tzmznJxIWlmzTJLeGOpyJBnmPEwpvc+LCCDoayEdMm6Miwatw6v6bZxW7ePH6LemUFte+6jSuISVdIrd7FQjdKPQKtmgBIPIfih73JzLCXeeGMlArkc04H0pK5LZKssyhVPXY7bIUEYglwit7+OGWQetPY=
Message-ID: <447F74DC.5030302@gmail.com>
Date: Fri, 02 Jun 2006 07:14:36 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "D. Hazelton" <dhazelton@enter.net>, David Lang <dlang@digitalinsight.com>,
       Ondrej Zajicek <santiago@mail.cz>, Dave Airlie <airlied@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>	 <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>	 <200606011603.57421.dhazelton@enter.net>	 <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>	 <447F56A0.8030408@gmail.com>	 <9e4733910606011423u75fa076hce22547c28c0a987@mail.gmail.com>	 <447F5CB3.7000107@gmail.com> <9e4733910606011448x32246dfcy2a2d448e238bdab3@mail.gmail.com>
In-Reply-To: <9e4733910606011448x32246dfcy2a2d448e238bdab3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/1/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > On 6/1/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> Jon Smirl wrote:
>> >> > On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
>> >> >
>> >>
>> >> Console writes are done with the console semaphore held. printk
>> will also
>> >> just write to the log buffer and defer the actual console printing
>> >> for later, by the next or current process that will grab the
>> semaphore.
>> >
>> > That was my original position too. But Alan Cox has drilled it into me
>> > that this is not acceptable for printks in interrupt context, they
>> > need to print there and not be deferred.
>> >
>>
>> Just to clarify, it's not my position, that's how the current printk code
>> works.
> 
> I haven't looked at the code, but if there is just normal console
> running and nothing like X is around, doesn't the console system
> always have the semaphore? If it always has the semaphore then
> interupt context printk's aren't blocked.
> 
> I think that interrupt context printk's work today, I have definitely
> seen one printk get inserted into the middle of another on my console.
> How else could you achieve that?
> 

foreground calls acquire_console_sem()
foreground process does a printk, printk writes to log buffer
interrupt-> does a printk -> message inserted to log buffer
foreground process calls release_console_sem
release_console_sem() dumps log buffer contents to console driver

Tony
