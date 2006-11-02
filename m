Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752619AbWKBAaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbWKBAaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbWKBAaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:30:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:48576 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752617AbWKBAaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:30:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=csy+UbHMnq77OCCM6Uxf4cDVh3RawwNE0oTZIPy3vMnfRGj9JBJdHXbLC7iX9WV86xKlFyG5RLuYhl62dzIfoDFNdOaRzrbdwbDBf/b30F10DYIoMNoFpDNMNB++6oGTx0mArNre/uU7NlfBdjWFcO5j8k3dSPox0Qf3f4xS03M=
Message-ID: <9a8748490611011630t43bebed8i808cba2f4c08f026@mail.gmail.com>
Date: Thu, 2 Nov 2006 01:30:22 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] LLC: Avoid potential NULL dereference in net/llc/af_llc.c::llc_ui_accept() .
Cc: linux-kernel@vger.kernel.org, jschlst@samba.org, acme@conectiva.com.br
In-Reply-To: <20061101.162758.10298784.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611020121.53368.jesper.juhl@gmail.com>
	 <20061101.162758.10298784.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/06, David Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Date: Thu, 2 Nov 2006 01:21:53 +0100
>
> > Since skb_dequeue() may return NULL we risk dereferencing a NULL pointer at
> >   if (!skb->sk)
> > This patch avoids that by also testing for a NULL skb.
> >
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>
> It can't return NULL in this context because we just checked
> skb_queue_empty() with the socket lock held and llc_wait_data()
> will return zero only if skb_queue_empty() is false.
>
> I know it's hard for automated tools to see this, but it's not
> reasonable to put this extra check in there since it is
> superfluous due to the above mentioned invariants.
>
Fair enough. Ignore the patch.
Thank you for the explanation.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
