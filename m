Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVEPPyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVEPPyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVEPPyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:54:41 -0400
Received: from holomorphy.com ([66.93.40.71]:41420 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261722AbVEPPye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:54:34 -0400
Date: Mon, 16 May 2005 08:54:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org
Subject: Re: How to use memory over 4GB
Message-ID: <20050516155422.GM9304@holomorphy.com>
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it> <42889890.8090505@tls.msk.ru> <6.2.1.2.2.20050516150628.06682cd0@mail.tekno-soft.it> <20050516151023.GK9304@holomorphy.com> <6.2.1.2.2.20050516174053.07185270@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.2.1.2.2.20050516174053.07185270@mail.tekno-soft.it>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17.10 16/05/2005, William Lee Irwin III wrote:
>> This approach has already been used in production by various major
>> applications and is even obsolete, now replaced by remap_file_pages()
>> (in Linux), where it and its counterparts in other operating systems
>> have been in use in production by various major applications for some time.
>> remap_file_pages() allows virtual pages in an mmap() area to correspond
>> in an unrestricted fashion to the pages of the underlying file, and to
>> alter this correspondence at will.
>> In particular, Oracle's "vlm" option does this.

On Mon, May 16, 2005 at 05:47:31PM +0200, Roberto Fichera wrote:
> So, you are suggesting to create one big tmpfs area, 6GB for example, than 
> mmap() it to the user process and use the remap_file_pages() for all
> the objects I want make "addressable" on the user process taking care
> the return value of -1 which implies to munmap() something to free vm space?

I don't have any specific suggestion regarding layout or usage patterns
besides pointing to remap_file_pages() being significantly lighter-weight
than mmap() for the purposes of virtual windowing. The other aspects of
all this (and even the use of remap_file_pages() at all) are, of course,
at your own discretion. It is, however, notable that Oracle has had some
success with a tactic similar to what you describe, where few objects are
used and the application instead manages space within the objects
dedicated to various purposes.

In general, I'd recommend experimenting with different strategies to see
which works best for you. This is all rather vague, and the mechanics of
getting all this working with your application are sure to have enough
alternative implementations to merit some decision-making and the like.


-- wli
