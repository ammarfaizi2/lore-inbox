Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVF2HOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVF2HOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVF2HOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:14:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262464AbVF2HN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:13:56 -0400
Date: Wed, 29 Jun 2005 00:13:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zkambarov@coverity.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix Coverity braindamage in UDF
Message-Id: <20050629001317.019476d9.akpm@osdl.org>
In-Reply-To: <20050629070309.GA18901@lst.de>
References: <20050629070309.GA18901@lst.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
>  Andrew, please don't blindly apply Coverity patches.  While the checker
>  is smart at finding inconsistencies, that "obvious" fix is wrong most of
>  the item.  As in this unreviewed UDF patch that got in:
>  udf_find_entry can never be called with a NULL argument, so we shouldn't
>  check for it instead of adding more assignments behind the check.

I reviewed it.  The code as it stood was wrong and the patch corrected it.

Yes, I realised at the time that the test for null is probably redundant,
but that's a separate thing - we have many such redundant tests and perhaps
someone should do a cleanup sweep.  But I have no intention of doing that
and I don't want to be leaving obvious coding errors in there.

A similar argument applies to the patch "coverity: tty_ldisc_ref return
null check".
