Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVFVASv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVFVASv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVFVASu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:18:50 -0400
Received: from quark.didntduck.org ([69.55.226.66]:30431 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262462AbVFVAQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:16:09 -0400
Message-ID: <42B8ADDA.6060000@didntduck.org>
Date: Tue, 21 Jun 2005 20:16:26 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cutaway@bellsouth.net
CC: Jean Delvare <khali@linux-fr.org>, Denis Vlasenko <vda@ilport.com.ua>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost><200506211359.25632.vda@ilport.com.ua><20050621232409.06a3400e.khali@linux-fr.org><008401c576b1$4f2ec000$2800000a@pc365dualp2> <20050621234943.713ecc40.khali@linux-fr.org> <00d501c576b6$943da300$2800000a@pc365dualp2>
In-Reply-To: <00d501c576b6$943da300$2800000a@pc365dualp2>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cutaway@bellsouth.net wrote:
> There is a way to defeat the GCC string alignments by putting the strings in
> a dynamically sized structure if anyone cares.  A bonus side effect of this
> scheme is that kernel/driver NLS translations would become almost trivial
> because all the string texts are collected in one place.
> 
> The basic idea looks like this:
> 
> #define MSG1 "Message text blah"
> #define MSG2 "Message text blah, blah"
> #define MSG3 "Message text blah, blah, blah"
> 
> #ifndef __GCC_FORMAT_STRING_CHECKS__
> static const struct
>     {
>     char m1[sizeof(MSG1)+1];
>     char m2[sizeof(MSG2)+1];
>     char m3[sizeof(MSG3)+1];
>     } msg = {
>     {MSG1},
>     {MSG2},
>     {MSG3}
>     };
> #undef MSG1
> #undef MSG2
> #undef MSG3
> #define MSG1 msg.m1
> #define MSG2 msg.m2
> #define MSG3 msg.m3
> #endif
> 

Sometimes the cure is worse than the disease.

--
				Brian Gerst
