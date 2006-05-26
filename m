Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWEZBTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWEZBTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 21:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWEZBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 21:19:43 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:1450 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751104AbWEZBTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 21:19:42 -0400
Message-ID: <348606378.23052@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 09:19:39 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Message-ID: <20060526011939.GA6220@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	mstone@mathom.us
References: <348469535.17438@ustc.edu.cn> <20060525084415.3a23e466.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525084415.3a23e466.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 08:44:15AM -0700, Andrew Morton wrote:
> These are nice-looking numbers, but one wonders.  If optimising readahead
> makes this much difference to postgresql performance then postgresql should
> be doing the readahead itself, rather than relying upon the kernel's
> ability to guess what the application will be doing in the future.  Because
> surely the database can do a better job of that than the kernel.
> 
> That would involve using posix_fadvise(POSIX_FADV_RANDOM) to disable kernel
> readahead and then using posix_fadvise(POSIX_FADV_WILLNEED) to launch
> application-level readahead.
> 
> Has this been considered or attempted?

There has been many lengthy debates in the postgresql mailing list,
and it seems that there has been _strong_ resistance to it.

IMHO, a best scheme would be
        - leave _obvious_ patterns to the kernel
                i.e. all kinds of (semi-)sequential reads
        - do fadvise() for _non-obvious_ patterns on _critical_ points
                i.e. the index scans

Wu
