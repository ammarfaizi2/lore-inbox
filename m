Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbTLKT65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbTLKT65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:58:57 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:42085 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265504AbTLKT6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:58:55 -0500
Date: Thu, 11 Dec 2003 13:58:54 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031211135854.A29359@hexapodia.org>
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211194815.GA10029@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031211194815.GA10029@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Thu, Dec 11, 2003 at 08:48:15PM +0100
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 08:48:15PM +0100, Jörn Engel wrote:
> On Thu, 11 December 2003 11:15:28 -0800, Hua Zhong wrote:
> > Hey, I think when I get some cycles I can try to implement this for
> > tmpfs (since it's simpler) myself, and post a patch. :-) But before
> > that, I want to make sure it's doable.
> 
> If you really do it, please don't add a syscall for it.  Simply check
> each written page if it is completely filled with zero.  (This will be
> a very quick check for most pages, as they will contain something
> nonzero in the first couple of words)

Um, no.

That is a very bad idea.  Your suggestion would make it impossible to
actually write a block of all-zeros to the disk.  That makes it
impossible to pre-allocate disk space.

Another syscall is precisely the correct thing to do.  (I don't think
make_hole() is a special case of any extant syscall.)

-andy
