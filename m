Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWFKU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWFKU7P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 16:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWFKU7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 16:59:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:33322 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751026AbWFKU7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 16:59:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S53EhMMLDeNUqdfFf6eViGVqngVsJK1NIQJWH6XaldlZnYOUGh1AhXIjTsTVZ976euLvc+tV/dpc4ubOhyEN/c/pGSalWI9IHq6gInj8AK8h0xXjfsEJdsNw//rDvEKaTHulj669s8u+3Jg9qkha7ClI/7CdhWQl7QZC2I7oymI=
Message-ID: <9e4733910606111359o38822782oe0fd9a69659d7d06@mail.gmail.com>
Date: Sun, 11 Jun 2006 16:59:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <448BA03B.6060800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44893407.4020507@gmail.com> <448B38F8.2000402@gmail.com>
	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
	 <448B61F9.4060507@gmail.com>
	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
	 <448B6ED3.5060408@gmail.com>
	 <9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>
	 <448B8818.1010303@gmail.com>
	 <9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>
	 <448BA03B.6060800@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> My point is: 'Multiple active drivers feature' is a natural consequence
> >> of the evolution of the code, but the only way to take advantage of it
> >> is if we provide a means for the user to use it.  And we are not
> >> providing the means.
>
> Maybe you're misunderstanding me. When I say "we are not providing the
> means", I mean "we are definitely not going to provide the means", NOT,
> "so we should be providing the means".

I thought about this for a day. The problem is that in-kernel,
single-user, multi-head is not on a good development path. That path
leads to in-kernel, multi-user support which is something I  don't
think we want to do. The current in-kernel, single-user, multi-head
feature is also only partially complete, it does not work on the
majority of VGA hardware in use today.

So the question is, what do you want to do about it? If you leave it
in place it complicates new work in the VT layer. One result being the
complicated sysfs interface that you are building. You are forced into
doing more in-kernel work to support a feature that may not be on the
long term path.

Another solution would be to build a small user space console system
and use it to drive the secondary heads. That would then allow the
feature to then be removed from the kernel. People would need to
change their scripts but the user level feature will still be there.

This is an example of a case where evolutionary design gets into
trouble. Without knowing the high-level plan for the future of
multi-user, multi-head graphics support in Linux you don't know the
right way to solve this problem.

-- 
Jon Smirl
jonsmirl@gmail.com
