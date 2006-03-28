Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWC1Q2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWC1Q2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWC1Q2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:28:05 -0500
Received: from [195.23.16.24] ([195.23.16.24]:56708 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932074AbWC1Q2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:28:04 -0500
Message-ID: <4429640F.8060907@grupopie.com>
Date: Tue, 28 Mar 2006 17:27:59 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: yenganti pradeep <pradeepls143@yahoo.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: procfs question
References: <20060328153449.3321.qmail@web8409.mail.in.yahoo.com>
In-Reply-To: <20060328153449.3321.qmail@web8409.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yenganti pradeep wrote:
> Hi,

Hi,

> I've created a new entry under /proc, to make tests.
> 
> I've defined an static int var=0;
> 
> Then I link my proc entry read function to a function
> that only performs this:
> 
> int length;
> length=sprintf(page,"Value %d",var++);
> 
> return length;
> 
> But when I cat/vi the file continuosly I get:
> 
> Value 0
> Value 3
> Value 6
> 
> etc...
> 
> Why is this three numbers increment? 

'cat' will issue a read for more bytes than your function provides. As 
this read isn't fully satisfied it will issue another read for the rest 
at a different offset, etc. So your function gets called several times.

Just do a 'strace' on 'cat' to see what 'cat' really does. For more 
details search for the thread 'procfs uglyness caused by "cat"'.

Your read function really shouldn't have side effects...

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
