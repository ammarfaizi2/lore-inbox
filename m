Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbREWOSE>; Wed, 23 May 2001 10:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263097AbREWORy>; Wed, 23 May 2001 10:17:54 -0400
Received: from mail.inup.com ([194.250.46.226]:11027 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S263096AbREWORo>;
	Wed, 23 May 2001 10:17:44 -0400
Date: Wed, 23 May 2001 16:16:54 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: sk_buff destructor in 2.2.18
Message-ID: <20010523161654.C7531@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to figure out how to use the destructor function in the skbuff
object. 
I've read (the source code and) the alan cox's article from linuxjournal
but it refers to linux 2.0.
Perhaps someone can tell me what's wrong in the following :

Normally the rx code of a network driver do the following code :
allocate a skbuff
	skb=dev_alloc_skb(length);
	if (skb==NULL) ...
fill data
	skb_put(skb,length);
	memcpy((void *)skb->data, buf,length);
end so on ...

In my case, I own the incomming buffer so I would like to use it directly
without copying data.
I've written a new allocation function.
And use the destructor to free my buffer (replacing it on a free list).

First I imagine something is wrong because the destructor is called before
kfree_skbmem() so If I don't lie to skb->cloned (I set it to 1), an
unexpected skb->head occured.
I think the destructor method is provided to free privates data not the
main data. But I can't see an another way to do it.

Secondly, When my destructor function is called, the cloned flag is already
set (and datarefp indicates also that data is referenced elsewhere).
When is a skbuff cloned?
Is there a way to avoid this?
Where can I register a function to free (= replace it in my list) the data
buffer?

Thank you,
Christophe

-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com

