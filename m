Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWJWPfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWJWPfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWJWPfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:35:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:28408 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964944AbWJWPfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:35:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=oCb9FHCQEbdR6yJ0K+Ziwwb8Q1aeinv6pQ1yWKYDFrQRQE9EElLxkP8IilAOCTeHqFb7SOIcwlz9C3sonHcqxPSevp4g9mxNXBH7zw7Q3KqLTGVByd1RWNk0zDa++X3O1Deksz5ur8lM/n3enng2OSo2vEWT/w+DKnaEmnIHFm0=
Message-ID: <453CE143.3070909@innova-card.com>
Date: Mon, 23 Oct 2006 17:35:31 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Franck <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com> <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
In-Reply-To: <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ note I'm not familiar with lcds...just try to understand what you've
  done ]

Miguel Ojeda wrote:
> The driver is waiting in the -mm tree (-mm2 right now) for being
> included in the mainline kernel sometime in the future. If it is
> included, I will maintain it as I coded it as it apears in the
> MAINTAINERS file. Why are you so worried about it if I can ask? Do you
> want some more features or something like that?
> 
> I missed the other two questions you wrote few days ago. About the
> second one, that was discussed a lot in the past and the people

yeah I found the thread and indeed it has been discussed very deeply ;)

> decided that (it wasn't my idea). About the first one, well, my ks0108
> code is the one for the wiring of an auxiliary LCD, so if you read the
> discussion you will find the people wanted to split video things and
> other auxiliary displays, so I think it is better to split it.
> (Anyway, I'm answering quickly, I haven't checked the code you talk
> about, but I will anyway).
> 

What I was worry about is that you actually wrote a frame buffer
driver, which are normally located in drivers/video, and put it in a
new directory drivers/auxdisplay. So now we have two places for frame
buffer drivers. It looks like, now some frame buffer drivers in
drivers/video should be moved in drivers/auxdisplay, shouldn't it ?

Maybe just a stupid idea but why not restructuring the thing like:

		drivers
		|-- display
		|      |-- video
		|      |-- aux
		|      |-- fbmem.c
		|      |-- ...

Another point: does the ks0108 controller is only used with the 'cfag'
display ? If not, suppose I'm using the same controller with another
lcd different from 'cfga'...Am I supposed to reuse your code in
cfag12864b.c ?

BTW, did you try to mmap your fbdev ? Does it work ?

Thanks
		Franck
