Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWJPIoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWJPIoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWJPIoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:44:46 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:27833 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161226AbWJPIop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:44:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VaIJgnLsI7C4pMQuDdW98F6pceWuCrRNJIODoRKy+FB0cmF0unOrrqrnvcH/6dPzPAl68j2GNG81fgiMhOCsjhWGNcxc801pYAebMpE5qCje3mTqJCPReDPW9fqdAxoAxv99T2mRta85AgYzYZV/+qSDxCSCTud5xnhQ2NX/Vx8=
Message-ID: <b0943d9e0610160144y2a432683s886c1a19b33a91ee@mail.gmail.com>
Date: Mon, 16 Oct 2006 09:44:11 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Mike Galbraith" <efault@gmx.de>
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>,
       "nmeyers@vestmark.com" <nmeyers@vestmark.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1160989710.17131.14.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013004918.GA8551@viviport.com>
	 <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
	 <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
	 <1160899154.5935.19.camel@Homer.simpson.net>
	 <1160976752.6477.3.camel@Homer.simpson.net>
	 <b0943d9e0610160107qff115d2r8adef99452560e16@mail.gmail.com>
	 <1160989710.17131.14.camel@Homer.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/06, Mike Galbraith <efault@gmx.de> wrote:
> On Mon, 2006-10-16 at 09:07 +0100, Catalin Marinas wrote:
> > Kmemleak introduces some overhead but shouldn't be that bad.
> > DEBUG_SLAB also introduces an overhead by erasing the data in the
> > allocated blocks.
>
> 2.6.18 with your rc6 patch booted normally with stack unwind enabled.

The only difference is that kmemleak now uses save_stack_trace() to
generate the call chain. In the previous versions I implemented a
simple stack backtrace myself, with the disadvantage that it only
worked on ARM and x86.

I think kmemleak should use the common stack trace API and investigate
why it is slower (either save_stack_trace is slower with stack unwind
enabled or kmemleak doesn't use these functions properly).

-- 
Catalin
