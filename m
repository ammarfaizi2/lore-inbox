Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291885AbSBHWNt>; Fri, 8 Feb 2002 17:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291884AbSBHWNj>; Fri, 8 Feb 2002 17:13:39 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:10515 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S291877AbSBHWN3>; Fri, 8 Feb 2002 17:13:29 -0500
Date: Fri, 8 Feb 2002 17:13:27 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, axboe@suse.com
Subject: Re: patch: aio + bio for raw io
Message-ID: <20020208171327.B12788@redhat.com>
In-Reply-To: <20020208025313.A11893@redhat.com> <200202082107.g18L7wx26206@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202082107.g18L7wx26206@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Fri, Feb 08, 2002 at 01:07:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 01:07:58PM -0800, Badari Pulavarty wrote:
> I am looking at the 2.5 patch you sent out. I have few questions/comments:
> 
> 1) brw_kvec_async() does not seem to split IO at BIO_MAX_SIZE. I thought
>    each bio can handle only BIO_MAX_SIZE (ll_rw_kio() is creating one bio
>    for each BIO_MAX_SIZE IO). 

Sounds like a needless restriction in bio, especially as one of the design 
requirements for the 2.5 block work is that we're able to support large ios 
(think 4MB page support).

>    And also, currently BIO_MAX_SIZE is only 64K. Infact, if I try to issue
>    64K IO using submit_bio(), I get following BUG() on my QLOGIC controller.

Jens?  Also, why does the bio callback return a value?  Nothing could ever 
possibly use it as far as I can see.

> 2) Could you please make map_user_kvec() generic enough to handle mapping
>    of mutliple iovecs to single kvec (to handle readv/writev). I think
>    this is a very easy change:
> 
> 	* Add alloc_kvec() and take out the kmalloc() from map_user_kvec().
> 	* Change map_user_kvec() to start mapping from kvec->veclet[kvec->nr]
>       	  instead of kvec->veclet[0]
> 
>   This way allocation for kvec to hold all the iovecs can be done at higher
>   level and map_user_kvec() can be called in a loop once for each iovec.

Sounds good.

		-ben
