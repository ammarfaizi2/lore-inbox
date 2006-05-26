Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWEZWWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWEZWWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWEZWWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:22:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:46697 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751012AbWEZWWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:22:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ksk7U9bmQwrnUTerYnFWFgdODJ0W4w4b4PTrbWL9b8EdshuzQSr24vQaXZOwomp7lVp7HxPv1T+7Grsz2/LfVejo3B8d4/KmZDODMadeT3SqshM4aDUaz0B1xSz2rNlSaLFeFMIs+SUgY1hIPZUiGquOF1wOfWb8KFWusO405ns=
Message-ID: <44777F98.4080004@gmail.com>
Date: Sat, 27 May 2006 01:22:16 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
References: <20060526161129.557416000@gmail.com>	<20060526162902.227348000@gmail.com>	<20060526141603.054f0459.akpm@osdl.org>	<44777340.7030905@gmail.com>	<20060526144309.60469bcd.akpm@osdl.org>	<447778DA.8080507@gmail.com> <20060526150804.0ae11b1f.akpm@osdl.org>
In-Reply-To: <20060526150804.0ae11b1f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Anssi Hannula <anssi.hannula@gmail.com> wrote:
> 
>>
>>>>>It would be much nicer all round if we could avoid renaming this file.
>>>>
>>>>Indeed... There are these 4 options as far as I see:
>>>>
>>>>1. Do this rename
>>>>2. Put all the code in input-ff.c to input.c
>>>>3. Make the input-ff a separate bool "module" and add
>>>>EXPORT_SYMBOL_GPL() for input_ff_event() which is currently the only
>>>>function in input-ff.c that is called from input.c
>>>>4. Rename the input "module" to something else, it doesn't matter so
>>>>much as almost everybody builds it as built-in anyway.
>>>>
>>>>WDYT is the best one?
>>>
>>>
>>>I still don't know what problem you're trying to solve so I cannot say.
>>
>>Maybe you know now.
> 
> 
> yup, thanks.
> 
> I'd have thought that 3) is the path of least resistance.
> 
> But it does require that input.c "knows" that input-ff.c was included in
> the build, which is not a thing we like to do.

Well, it's going to be included as built-in and can't be built as a
module at all, so I think it's okay for us to do so?

> Why should things in input.c call into input-ff.c, btw?  The way we
> normally would handle that is to add a register_something() API to input.c
> and input-ff.c would insert its callback via that interface.

Yes, we could easily add a callback to e.g. struct input_dev, but is
that really preferred if the input-ff.c is built-in?

And it's built-in only because: If I were to implement
register_something() stuff for this, no module would require input-ff
and it would not be loaded, even if there are ff-capable device drivers
present.

-- 
Anssi Hannula

