Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758892AbWLFA5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758892AbWLFA5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758915AbWLFA5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:57:15 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:33187 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758892AbWLFA5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:57:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ATaLLLDkfzY//gtMw6u4pNrT/DgIFDfWKvnAxU7X3atX0LS9TGo4RI6UVTt7XHKnxQqaLBQQM32uvc5AYLlVZMlpb5eVVhpew3ktlpZWwc/wegM93XEWYVAdHdxzS4NNRZ07kGKNr12o4cjxm47vLhPjFw1oJAHx36nZT3YsJlg=
Message-ID: <f383264b0612051657r2b62c7acnf10b2800934ab8b3@mail.gmail.com>
Date: Tue, 5 Dec 2006 16:57:12 -0800
From: "Matt Reimer" <mattjreimer@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061205.132412.116353924.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f383264b0612042338y2609dd76w8ba562394800bbd0@mail.gmail.com>
	 <20061205.132412.116353924.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, David Miller <davem@davemloft.net> wrote:
> From: "Matt Reimer" <mattjreimer@gmail.com>
> Date: Mon, 4 Dec 2006 23:38:13 -0800
>
> > In light of James Bottomsley's commit[1] declaring that kmap() and
> > friends now have to take care of coherency issues, is the patch "mm:
> > D-cache aliasing issue in cow_user_page"[2] correct, or could it
> > potentially cause a slowdown by calling flush_dcache_page() a second
> > time (i.e. once in an architecture-specific kmap() implementation, and
> > once in cow_user_page())?
>
> kmap() is a NOP unless HIGHMEM is configured.
>
> Therefore, it cannot possibly take care of D-cache aliasing issues
> across the board.

Right, but isn't he declaring that each architecture needs to take
care of this? So, say, on ARM we'd need to make kunmap() not a NOP and
call flush_dcache_page() ?

Matt
