Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312315AbSCaSL0>; Sun, 31 Mar 2002 13:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312317AbSCaSLQ>; Sun, 31 Mar 2002 13:11:16 -0500
Received: from imladris.infradead.org ([194.205.184.45]:18185 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312315AbSCaSLF>; Sun, 31 Mar 2002 13:11:05 -0500
Date: Sun, 31 Mar 2002 19:10:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre5aa1 and splitted vm-33
Message-ID: <20020331191059.A16769@phoenix.infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020331164815.A1331@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 04:48:15PM +0200, Andrea Arcangeli wrote:
> Only in 2.4.19pre5aa1: 00_o_direct-open-check-1
> 
> 	Move the check for O_DIRECT support into the open(2) syscall. Make
> 	sense, also the xine folks asked for that feature to cleanup
> 	some userspace. Patch from Chuck Lever.

This breaks XFS O_DIRECT handling, which is not implemented through ->direct_IO.
For the open case putting the check into generic_file_open sounds good to me,
but I have no idea on how to handle the fcntl case - which btw already allocates
kiobufs even if XFS doesn't need them..

