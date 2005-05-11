Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVEKQDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVEKQDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVEKQDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:03:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:32743 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261187AbVEKQDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:03:36 -0400
Subject: Re: [RFC/PATCH 2/5] mm/fs: add execute in place support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Carsten Otte <cotte@freenet.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <428225E7.4070605@freenet.de>
References: <428216F7.30303@de.ibm.com>
	 <20050511150924.GA29976@infradead.org>  <428225E7.4070605@freenet.de>
Content-Type: text/plain
Organization: 
Message-Id: <1115826428.26913.1069.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2005 08:47:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 08:33, Carsten Otte wrote:
> Christoph Hellwig wrote:
> 
> > This is a lot of code for a very special case.
> >
> >Could you try to put all the xip code into a separate file, e.g. mm/xip.c
> >that's only built when CONFIG_XIP is set?  It would probably require
> >duplicating a little more code if you want clean interfaces, e.g. probably
> >a separate set of generic operations.
> >
> >  
> >
> Indeed that seems reasonable. There is no exact reason to have
> this built into a kernel on a platform that does not have a bdev
> for this. On the other hand, I believe the code should stay in
> filemap.c, because it fits there conceptually. And I personally
> dislike #ifdef in the middle of a file.

While I agree with your reasoning, since you are affecting very hot
code path for every architecture, irrespective of "bdev" support
for this - you may want to look into some how eliminating few
function pointer de-refs and checks for those who don't care.
(#ifdef, unlikely(), or some arch & config magic).

To be honest, that file is already complicated enough - every time
I look at it my head hurts :(

Thanks,
Badari

