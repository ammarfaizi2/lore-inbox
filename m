Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWEZCKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWEZCKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 22:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWEZCKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 22:10:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:59101 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030215AbWEZCKh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 22:10:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zlfj5xj+3rklIVwMAuVcAzrkC53JAMCsUwaumVjFvE5lqY2ddN5juINTMnt7aKU0DReL60UxC2qQWLKYRnVOg3e1NW0ZIEBVViAV8tyTj45dOugFhLKuDiexxoiPmj8UIqDfTH8ddy+MDjR4M/pJcqTn+sJukqyxqsXaenUA6xQ=
Message-ID: <9e4733910605251910k3bcd434aq5f7410c53fc8b17d@mail.gmail.com>
Date: Thu, 25 May 2006 22:10:35 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Cc: "Wu Fengguang" <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       mstone@mathom.us
In-Reply-To: <20060525084415.3a23e466.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <348469535.17438@ustc.edu.cn>
	 <20060525084415.3a23e466.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/06, Andrew Morton <akpm@osdl.org> wrote:
> These are nice-looking numbers, but one wonders.  If optimising readahead
> makes this much difference to postgresql performance then postgresql should
> be doing the readahead itself, rather than relying upon the kernel's
> ability to guess what the application will be doing in the future.  Because
> surely the database can do a better job of that than the kernel.
>
> That would involve using posix_fadvise(POSIX_FADV_RANDOM) to disable kernel
> readahead and then using posix_fadvise(POSIX_FADV_WILLNEED) to launch
> application-level readahead.

Users have also reported that this patch fixes performance problems
from web servers using sendfile(). In the case of lighttpd they
actually stopped using sendfile() for large transfers and wrote a user
space replacement where they could control readahead manually. With
this patch in place sendfile() went back to being faster than the user
space implementation.

-- 
Jon Smirl
jonsmirl@gmail.com
