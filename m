Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268597AbRG3Nyl>; Mon, 30 Jul 2001 09:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268606AbRG3Nyc>; Mon, 30 Jul 2001 09:54:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44560 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268597AbRG3NyU>; Mon, 30 Jul 2001 09:54:20 -0400
Subject: Re: ext3-2.4-0.9.4
To: patl@cag.lcs.mit.edu (Patrick J. LoPresti)
Date: Mon, 30 Jul 2001 14:55:07 +0100 (BST)
Cc: mason@suse.com (Chris Mason), cw@f00f.org (Chris Wedgwood),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <s5gpuaiplwf.fsf@egghead.curl.com> from "Patrick J. LoPresti" at Jul 30, 2001 09:49:20 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15RDVj-0003oi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Chris Mason <mason@suse.com> writes:
> 
> > Correct, in the current 2.4.x code, its a quirk.  fsync(any object) ==
> > fsync(all pending metadata, including renames).
> 
> This does not help.  The MTAs are doing fsync() on the temporary file
> and then using the *subsequent* rename() as the committing operation.

Which is quaint, because as we've pointed out repeatedly to you rename
is not an atomic operation. Even on a simple BSD or ext2 style fs it can
be two directory block writes,  metadata block writes, a bitmap write
and a cylinder group write.

> It would be nice to have an option (on either the directory or the
> mountpoint) to cause all metadata updates to commit to the journal
> without causing all operations to be fully synchronous.  This would

You mean fsync() on the directory. 

Alan

