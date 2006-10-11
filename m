Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWJKCji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWJKCji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 22:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWJKCji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 22:39:38 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:47593 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932411AbWJKCjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 22:39:37 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Potential fix for fdtable badness.
Date: Tue, 10 Oct 2006 19:39:35 -0700
User-Agent: KMail/1.9.1
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Olof Johansson <olof@lixom.net>,
       Linas Vepstas <linas@austin.ibm.com>, Bryce Harrington <bryce@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200610101908.18442.vlobanov@speakeasy.net> <20061010193111.82a15ece.akpm@osdl.org>
In-Reply-To: <20061010193111.82a15ece.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101939.35840.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 19:31, Andrew Morton wrote:
> On Tue, 10 Oct 2006 19:08:18 -0700
>
> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> > Would you prefer me to resend a fixed patch #4, or a new fix (#5) on top
> > of what's in your tree?
>
> Incremental updates are preferred.
>
> > diff -Npru old/fs/file.c new/fs/file.c
> > --- old/fs/file.c	2006-10-10 18:58:21.000000000 -0700
> > +++ new/fs/file.c	2006-10-10 19:01:03.000000000 -0700
> > @@ -164,9 +164,8 @@ static struct fdtable * alloc_fdtable(un
> >  	 * the fdarray into page-sized chunks: starting at a quarter of a page,
> >  	 * and growing in powers of two from there on.
> >  	 */
> > -	nr++;
> >  	nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
> > -	nr = roundup_pow_of_two(nr);
> > +	nr = roundup_pow_of_two(nr + 1);
> >  	nr *= (PAGE_SIZE / 4 / sizeof(struct file *));
> >  	if (nr > NR_OPEN)
> >  		nr = NR_OPEN;
>
> Like that.

I'll wrap the fixes up in incremental patches once the problem has been 
eradicated.
