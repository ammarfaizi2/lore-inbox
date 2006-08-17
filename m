Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWHQIrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWHQIrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWHQIrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:47:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:64294 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932353AbWHQIrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:47:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O4DcHuARUY0tsLtHVKYXiT2bp5g7nLNNoc14xUA+3vRJW9234R0uca54cXyuRl72d6Qg9hq/324kZjAnbMjy2KosmJif23gx0FhKQnGDISduOYTyxvzAy21yP5qrkGU7hWMO16IRHqIv79pMUwEyfgKvvuGY1jD2Os7vTZxl4e4=
Message-ID: <9a8748490608170147o7bc9a457ud3e0a6729444c27e@mail.gmail.com>
Date: Thu, 17 Aug 2006 10:47:07 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: 'fbno' possibly used uninitialized in xfs_alloc_ag_vextent_small()
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com
In-Reply-To: <20060817084111.A2787212@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608162327.34420.jesper.juhl@gmail.com>
	 <20060817084111.A2787212@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Nathan Scott <nathans@sgi.com> wrote:
> Hi Jesper,
>
> On Wed, Aug 16, 2006 at 11:27:34PM +0200, Jesper Juhl wrote:
> > (Please keep me on Cc since I'm not subscribed to the XFS lists)
> >
> > The coverity checker found what looks to me like a valid case of
> > potentially uninitialized variable use (see below).
>
> It looks invalid, but its not, once again.  To understand why this
> isn't a problem requires looking at the xfs_alloc_ag_vextent_small
> call sites (there's only two).  If (*flen==0) is passed back out,
> then the value in *fbno is discarded, always.
>
> > So basically, if we hit the 'else' branch, then 'fbno' has not been
> > initialized and line 1490 will then use that uninitialized variable.
> >
> > What would prevent that from happening at some time??
>
> Nothing.  But its not a problem in practice.  However, that final
> else branch is very much unlikely, so theres no real cost to just
> initialising the local fbno to NULLAGBLOCK in that branch, and we
> future proof ourselves a bit that way I guess (in case the callers
> ever change - pretty unlikely, but we may as well).  How does the
> patch below look to you?
>
Looks good to me.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
