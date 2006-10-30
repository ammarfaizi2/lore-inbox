Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161478AbWJ3TLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161478AbWJ3TLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161477AbWJ3TLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:11:18 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:54471 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1161478AbWJ3TLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:11:17 -0500
Message-ID: <45464E67.7030004@cfl.rr.com>
Date: Mon, 30 Oct 2006 14:11:35 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Daniel Drake <ddrake@brontes3d.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: splice blocks indefinitely when len > 64k?
References: <1162226390.7280.18.camel@systems03.lan.brontes3d.com>
In-Reply-To: <1162226390.7280.18.camel@systems03.lan.brontes3d.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2006 19:11:29.0845 (UTC) FILETIME=[346B7650:01C6FC57]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14782.003
X-TM-AS-Result: No--13.655800-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While it should not simply hang, the splice size needs to be an even 
multiple of the page size.

Daniel Drake wrote:
> Hi,
> 
> I'm experimenting with splice and have run into some unusual behaviour.
> 
> I am using the utilities in git://brick.kernel.dk/data/git/splice.git
> 
> In splice.h, when changing SPLICE_SIZE from:
> 
> #define SPLICE_SIZE (64*1024)
> 
> to
> 
> #define SPLICE_SIZE ((64*1024)+1)
> 
> splice-cp hangs indefinitely when copying files sized 65537 bytes or
> more. It hangs on the first splice() call.
> 
> Is this a bug? I'd like to be able to copy much more than 64kb on a
> single splice call.
> 
> Thanks!
> Daniel

