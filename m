Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbREXLe5>; Thu, 24 May 2001 07:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbREXLer>; Thu, 24 May 2001 07:34:47 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:2433 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261509AbREXLeh>; Thu, 24 May 2001 07:34:37 -0400
Message-ID: <3B0CF068.A6ADA562@uow.edu.au>
Date: Thu, 24 May 2001 21:28:40 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Manas Garg <mls@chakpak.net>, linux-kernel@vger.kernel.org
Subject: Re: O_TRUNC problem on a full filesystem
In-Reply-To: <20010523114318.A8336@cygsoft.com> <3B0B8924.F0B78288@uow.edu.au>,
		<3B0B8924.F0B78288@uow.edu.au>; from andrewm@uow.edu.au on Wed, May 23, 2001 at 07:55:48PM +1000 <20010524121634.O8080@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> On Wed, May 23, 2001 at 07:55:48PM +1000, Andrew Morton wrote:
> 
> > When you truncated your file, the blocks remained preallocated
> > on behalf of the file, and were hence considered "used".  For
> > some reason, a subsequent attempt to allocate blocks for the
> > same file failed to use that file's preallocated blocks.
> 
> Nope.  ext2_truncate() calls ext2_discard_prealloc() to fix this up.
> Both 2.2 and 2.4 do this correctly.

But the problem goes away when you disable EXT2_PREALLOCATE.
I tested it.
