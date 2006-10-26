Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423537AbWJZOzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423537AbWJZOzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWJZOzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:55:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:31613 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751698AbWJZOzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:55:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EWLwOG4tYz82vazKs9b9/cgHGfwf/jL0TixtSJqQa5d2N2Fg7r0sq2cybdFQCFHWILq6YPdkkAXojKehsvKaFVWQefNrfuUNUZAthXsQnETihHlDE5HSUBZz0qVeM70K/X0kaOGQvsA7P0OTa2L6zkkK1oigAmMqAnJVwaYuXvk=
Message-ID: <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>
Date: Thu, 26 Oct 2006 14:55:36 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE85B.2080702@innova-card.com>
	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> On 10/23/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> > Yes, we are sure. AFAIK there is no need to lock when it is a fbdev.
> > The older version were "alone" drivers: they needed to lock because
> > they used fops and they exported functions.
> >
>
> ok, so no other driver than fb could use 'cfag12864b_buffer'. Maybe
> I'm missing something but why did you split your fb driver into
> cfag12864b.c and cfag12864fb.c ?
>

To be clearer. And you are wrong: you can write other modules which
want to know what the LCD is showing, or use it; without worrying
about framebuffer things. They can read / write "cfag12864b_buffer" as
well as cfag12864bfb do. Why not?

The cfag12864b module is the real driver, which uses ks0108 module.
The cfag12864bfb is just the framebuffer device.

>
> BTW, 'cfag12864b_cache' could have been static...

Right, I saw that in the meantime I was adding the mmap feature. Thanks.

>
>                 Franck
>
