Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbTEHTEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTEHTEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:04:54 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:64775 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262042AbTEHTEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:04:53 -0400
Date: Thu, 8 May 2003 20:17:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Terje Malmedal <terje.malmedal@usit.uio.no>, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, terje.eggestad@scali.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508201729.A19556@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Pollard <jesse@cats-chateau.net>,
	Terje Malmedal <terje.malmedal@usit.uio.no>,
	alan@lxorguk.ukuu.org.uk, terje.eggestad@scali.com,
	arjanv@redhat.com, linux-kernel@vger.kernel.org,
	D.A.Fedorov@inp.nsk.su
References: <E19DnLH-0002As-00@aqualene.uio.no> <03050813134901.09468@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <03050813134901.09468@tabby>; from jesse@cats-chateau.net on Thu, May 08, 2003 at 01:13:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 01:13:49PM -0500, Jesse Pollard wrote:
> Unless there is a LOCK on sys_call_table[SYS_fsync] another CPU could
> replace the pointer between lines 3 and 4. At that point line 4 would
> destroy the existing entry.. or destroy it when the original is restored,
> and would NOT be restoring the one insterted.

The the race in the replacement.  The second race is in actually
using these hooks.  As soon as you examine a user pointer/address
in there you're fundamentally racy vs. another thread manipulating
the user address space.  

