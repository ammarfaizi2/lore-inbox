Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbSBKLQi>; Mon, 11 Feb 2002 06:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287002AbSBKLQ1>; Mon, 11 Feb 2002 06:16:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40716 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287518AbSBKLQT>;
	Mon, 11 Feb 2002 06:16:19 -0500
Date: Mon, 11 Feb 2002 12:09:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, axboe@suse.com
Subject: Re: patch: aio + bio for raw io
Message-ID: <20020211120923.D1014@suse.de>
In-Reply-To: <20020208025313.A11893@redhat.com> <200202082107.g18L7wx26206@eng2.beaverton.ibm.com> <20020208171327.B12788@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208171327.B12788@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08 2002, Benjamin LaHaise wrote:
> >    And also, currently BIO_MAX_SIZE is only 64K. Infact, if I try to issue
> >    64K IO using submit_bio(), I get following BUG() on my QLOGIC controller.
> 
> Jens?  Also, why does the bio callback return a value?  Nothing could ever 
> possibly use it as far as I can see.

WRT max size, Linus already replied why this is so. The other thing --
the callback return value was really to have it return 'done or not'
when doing partial completions. It was later decided that the end_io
callback should only be called for final completion, so really the
nr_sectors and return value is not used now. I'll clean that up next
time around.

-- 
Jens Axboe

