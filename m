Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273343AbRINIrH>; Fri, 14 Sep 2001 04:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273346AbRINIq6>; Fri, 14 Sep 2001 04:46:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42770 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273343AbRINIqt>; Fri, 14 Sep 2001 04:46:49 -0400
Date: Fri, 14 Sep 2001 10:46:57 +0200
From: Jan Kara <jack@ucw.cz>
To: Paul Menage <pmenage@ensim.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.2.20: Avoid buffer overrun in quota warning
Message-ID: <20010914104657.E31478@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E15hi7F-0004jm-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E15hi7F-0004jm-00@pmenage-dt.ensim.com>; from pmenage@ensim.com on Thu, Sep 13, 2001 at 06:50:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> The quota code in several places does an sprintf() to a fixed (75 char) 
> buffer, where one of the format arguments is a directory name. If your 
> mountpoints have long enough names, this can easily overflow and 
> corrupt data following the buffer.
> 
> This has been fixed in 2.4, but not in 2.2.20pre. There are three ways 
> to fix it:
> 
> a) backport the delayed warning code from 2.4, which doesn't use sprintf
> 
> b) increase the buffer size
> 
> c) limit the %s directives in the sprintf() format string.
> 
> Given that 2.2.20 is about to be frozen, this patch takes option b, 
> increasing the buffer size to be equal to the maximum directory name 
> length passed to mount() (PAGE_SIZE) plus some slop for the rest of the 
> string to be printed. Maybe for 2.2.21 it might be worth backporting 
> the delayed warning code.
  Actually that delayed printing of quota messages isn't even in regular
2.4 - it's just in ac-patches. Regular 2.4 has just print_warning()
function which works rather the same way as printing in 2.2.
  Currently I think that just increasing the buffer size is enough. If
someone really wanted the port from 2.4 I can make it but I'm really not sure
it's 2.2 thing and I'm not sure it's worth the work...

								Honza

