Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWEZV3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWEZV3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWEZV3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:29:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:40196 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751589AbWEZV3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:29:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h3mmIxPVEwTpXhDPTQmzb8KuETuRQ2cLwspo6GZfe4WrOquP3cxTwknxHYSAaEBoqzVWFqpKX3MoX2kQ9Gh50RKteYX0esTiUw5rYVQmdrqZcJVFg3N3IXoXKVomcke1tjIdMbRP4WyJebOLXBu/2wn6xvuMyv0+CM6jk7zvoIU=
Message-ID: <44777340.7030905@gmail.com>
Date: Sat, 27 May 2006 00:29:36 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
References: <20060526161129.557416000@gmail.com>	<20060526162902.227348000@gmail.com> <20060526141603.054f0459.akpm@osdl.org>
In-Reply-To: <20060526141603.054f0459.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Anssi Hannula <anssi.hannula@gmail.com> wrote:
> 
>>Move the input.c to input-core.c and modify Makefile so that the input module
>>can be built from multiple source files. This is preparing for the input-ff.c.
>>
>>Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
>>
>>---
>> drivers/input/Makefile     |    2 
>> drivers/input/input-core.c | 1099 +++++++++++++++++++++++++++++++++++++++++++++
>> drivers/input/input.c      | 1099 ---------------------------------------------
> 
> urgh.  There are other changes pending againt input.c and this renaming
> makes everything a huge pain.
> 
> What does "can be built from multiple source files" mean?

Well, I want to embed the input-ff.c into the input module too.

> It would be much nicer all round if we could avoid renaming this file.

Indeed... There are these 4 options as far as I see:

1. Do this rename
2. Put all the code in input-ff.c to input.c
3. Make the input-ff a separate bool "module" and add
EXPORT_SYMBOL_GPL() for input_ff_event() which is currently the only
function in input-ff.c that is called from input.c
4. Rename the input "module" to something else, it doesn't matter so
much as almost everybody builds it as built-in anyway.

WDYT is the best one?

-- 
Anssi Hannula

