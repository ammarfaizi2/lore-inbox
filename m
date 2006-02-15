Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423046AbWBOJmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423046AbWBOJmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWBOJmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:42:49 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:17392 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932451AbWBOJms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:42:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=U6uI/MpO+5y9L+AMeUqdHmjl/l02fPuFLdpyQdzPeE3Mq1R5P+Dj8aFpsIuOFGJRiyeD1jYn3F7uxe0EMnTx+cBMQg6j2y6276QUDCEtfll8M85V25MGcPTxW0RNYxsEOwOEfHBYdkCu8GgO9BVu0gj5Rp2FXYaq92XTOiMgn0o=
Date: Wed, 15 Feb 2006 07:42:37 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATH 0/2] strndup_user, description
Message-Id: <20060215074237.cec92f44.davi.arnaut@gmail.com>
In-Reply-To: <1139971990.14831.2.camel@localhost.localdomain>
References: <20060214214747.ef05e4d8.davi.arnaut@gmail.com>
	<1139971990.14831.2.camel@localhost.localdomain>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006 02:53:10 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2006-02-14 at 21:47 -0300, Davi Arnaut wrote:
> > This patch series creates a strndup_user() function in order to avoid duplicated
> > and error-prone (userspace modifying the string after the strlen_user()) code.
> 
> Well userspace can still modify in this case. So you could still get a
> \0 mid buffer but that seems harmless.

Yes.

> However
> 
> > +#define strdup_user(s)	strndup_user(s, PAGE_SIZE)
> 
> Better this doesn't exist as it is a wrapper for a bad habit that isnt
> yet used so why encourage it.
> 

Ok, I will inline it.
 
> 
> > +	length = strlen_user(s);
> 
> What if n is very large ? Should use strnlen_user clipped by n

That's what "if (length > n) length = n" is for.
 
> Also say the length limit is 8 and the text is "hello\0"
> 
> We get length = 5  5 < 8, alloc 5 bytes set 5th to \0 and return "hell
> \0"

No, we would get length = 6, strlen_user returns the size of the string
_including_ the terminating NUL.

--
Davi Arnaut

