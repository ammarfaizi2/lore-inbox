Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWIRWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWIRWyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWIRWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 18:54:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:20663 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030243AbWIRWyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 18:54:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T0WOnm/C9e6DfBChU27QnQrT2I2jRXaQotNZJmS7GaIyo7pRySHNwVENEKPlvV7HfJR1qawLJVyo5Ajq3bP94NEzJyMw9wFnhJYglFV40l6mwcHoeHwPphweHOnbnfOSe0/W1fYHJaHD3ahQA3FRElZ/dXP2cJHgOQn9+Oy8n6I=
Message-ID: <6b4e42d10609181554s723b54f4y97a233a0a1f30657@mail.gmail.com>
Date: Mon, 18 Sep 2006 15:54:17 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: [KJ] potential crash fix : drivers/pcmcia/au1000_generic
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
In-Reply-To: <20060918110812.GP2585@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609171754p4054762bm5711c744b61e68a0@mail.gmail.com>
	 <20060918110812.GP2585@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/06, Matthew Wilcox <matthew@wil.cx> wrote:
> On Sun, Sep 17, 2006 at 05:54:17PM -0700, Om Narasimhan wrote:
> > Tested by compiling.
> >
> > I have not subscribed to pcmcia list. Please cc me any comments.
>
> You also haven't described what the 'potential crach' is that you're
> fixing.
Okay, I should have documented that.
Here is the explanation.
The previous code did something like,

if (error) goto out_err;
....
do {
             struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
              del_timer_sync(&skt->poll_timer);
               pcmcia_unregister_socket(&skt->socket);
out_err:
               flush_scheduled_work();
               ops->hw_shutdown(skt);
               i--;
} while (i > 0)
.....

1. On the error path, skt would not contain a valid value for the
first iteration (skt is masked by uninitialized automatic skt)
2. does not do hw_shutdown() for 0th element of PCMCIA_SOCKET

Does it sound good?

Regards,
Om.
