Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbTLKTvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTLKTtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:49:09 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:27325 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265221AbTLKTsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:48:38 -0500
Date: Thu, 11 Dec 2003 20:48:15 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hua Zhong <hzhong@cisco.com>
Cc: "'Andy Isaacson'" <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031211194815.GA10029@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <017c01c3c01b$232bd130$d43147ab@amer.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 December 2003 11:15:28 -0800, Hua Zhong wrote:
> 
> > The abstract interface for make_hole() is simple, but it turns into a
> > pretty expensive filesystem operation, I think.  After many cycles of
> > free/allocate, your file would be badly fragmented across the
> > filesystem.  
> 
> Understood. Two filesystems we are using: tmpfs and ext3. For the
> former, fragmentation doesn't matter.
> 
> Hey, I think when I get some cycles I can try to implement this for
> tmpfs (since it's simpler) myself, and post a patch. :-) But before
> that, I want to make sure it's doable.

If you really do it, please don't add a syscall for it.  Simply check
each written page if it is completely filled with zero.  (This will be
a very quick check for most pages, as they will contain something
nonzero in the first couple of words)

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams?
