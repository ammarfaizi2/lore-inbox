Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318599AbSH1Cp1>; Tue, 27 Aug 2002 22:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318614AbSH1Cp1>; Tue, 27 Aug 2002 22:45:27 -0400
Received: from adsl-67-117-146-62.dsl.snfc21.pacbell.net ([67.117.146.62]:52998
	"EHLO localhost") by vger.kernel.org with ESMTP id <S318599AbSH1Cp0>;
	Tue, 27 Aug 2002 22:45:26 -0400
From: "Stephen C. Biggs" <s.biggs@softier.com>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Date: Tue, 27 Aug 2002 19:49:18 -0700
MIME-Version: 1.0
Subject: Re[2]: Bug in kernel code?
Message-ID: <3D6BD7BE.16359.B30D79@localhost>
In-reply-to: <20020827.182312.52750220.davem@redhat.com>
References: <3D6BC3CD.10889.6526BC@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2002 at 18:23, David S. Miller wrote:

>    From: "Stephen C. Biggs" <s.biggs@softier.com>
>    Date: Tue, 27 Aug 2002 18:24:13 -0700
> 
>    On 27 Aug 2002 at 18:09, David S. Miller wrote:
>    
>    > And then your mail ends.... let us know when you've fixed
>    > your email client, this isn't rocket science :-)
>    > 
>    
>    What are you talking about "And then your mail ends..."  That's all I wanted to say...
>    
> No, I thought you were going to give an example of a huge number.
> :-)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Argh.  I meant to post THIS code:

#include <stdio.h>

#define PAGE_SHIFT 12

struct list_head {
	struct list_head *next, *prev;
};

int main(void)
{
	unsigned long order;
	unsigned long mempages = ~0;

#if PAGE_SHIFT < 13
	mempages >>= (13 - PAGE_SHIFT);
#endif
	mempages *= sizeof(struct list_head);

	printf("mempages: %lu\n", mempages);

	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
		;
	printf("%lu\n",order);
	return 0;
}

