Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751985AbWJWQVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbWJWQVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWJWQVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:21:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:55753 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751985AbWJWQVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:21:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IklnNraaWE+qSZQuAZSXKzyZqmdbaf2nVr284mzlpVdKT9cQ5B67vyY7G+q7omgfM2mIHkBkb2VXi2zxr5V3w/jKLa/toHXuyigYdRQlwokQc/JWxBj+YCH6DrFWE75dy7jH+AA87iifQEnf6tijznYj/t3hwDaIDY1MoaBGX9I=
Message-ID: <653402b90610230921j595446a4xda5e6d9444e108da@mail.gmail.com>
Date: Mon, 23 Oct 2006 18:21:32 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <453CE143.3070909@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE143.3070909@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>
> [ note I'm not familiar with lcds...just try to understand what you've
>   done ]
>
> What I was worry about is that you actually wrote a frame buffer
> driver, which are normally located in drivers/video, and put it in a
> new directory drivers/auxdisplay. So now we have two places for frame
> buffer drivers. It looks like, now some frame buffer drivers in
> drivers/video should be moved in drivers/auxdisplay, shouldn't it ?
>
> Maybe just a stupid idea but why not restructuring the thing like:
>
>                 drivers
>                 |-- display
>                 |      |-- video
>                 |      |-- aux
>                 |      |-- fbmem.c
>                 |      |-- ...
>
>

Yes, I got your idea in your first message, and well, that was
discussed (however, not being a fbdev), and the people thought that
putting them together will, maybe, cause confusion; so having them out
from drivers/video should be better. Your idea, which merge them into
a "drivers/display" could be a good one, but I don't think people will
like to change such critical tree right now. Also, I'm not the one who
maintain such tree, so my opinion won't make changes about that ;)

>
> Another point: does the ks0108 controller is only used with the 'cfag'
> display ? If not, suppose I'm using the same controller with another
> lcd different from 'cfga'...Am I supposed to reuse your code in
> cfag12864b.c ?
>

No. You are supposed to _use_ the ks0108's exported functions: I split
the code into the ks0108 and the cfag12864b because I thought it was
the logical way, as the cfag12864b LCD just send the data through two
different ks0108 controllers. The same way, you can use the ks0108's
exported functions to create another whateverlcd.c which has one or
more ks0108 controllers.

>
> BTW, did you try to mmap your fbdev ? Does it work ?
>

Why it shouldn't? It doesn't work for you? AFAIK, it is a usual fbdev,
and you can map any fbdev as they are simple character file devices.

>
> Thanks
>                 Franck
>

Thanks
           Miguel Ojeda
