Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWH2TE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWH2TE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWH2TE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:04:27 -0400
Received: from kanga.kvack.org ([66.96.29.28]:60138 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965127AbWH2TE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:04:27 -0400
Date: Tue, 29 Aug 2006 15:04:11 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Zach Brown <zab@zabbo.net>
Cc: Yi Yang <yang.y.yi@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linux-aio <linux-aio@kvack.org>
Subject: Re: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
Message-ID: <20060829190411.GK18092@kvack.org>
References: <44F43F46.1070702@gmail.com> <44F48825.4050408@zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F48825.4050408@zabbo.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 11:32:05AM -0700, Zach Brown wrote:
> Like it or not, the sys_io_submit() interface returns -EINVAL when the
> file descriptor doesn't support the requested command.  Changing the
> binary interface is a big deal and should not be done lightly.  What is
> the motivation for making this change?

-EOPNOTSUPP also gives the wrong error message, as it is a networking 
error.  Any program which knows that it is submitting a correctly filled 
in set of parameters can deduce the reason for the -EINVAL.  Changing it 
otherwise would result in behaviour outside of that specified in the man 
page (which lists reasons for the -EINVAL result).

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
