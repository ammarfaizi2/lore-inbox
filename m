Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUEQRqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUEQRqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUEQRqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:46:49 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:21163 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261920AbUEQRpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:45:08 -0400
Date: Mon, 17 May 2004 10:45:02 -0700
From: Andy Isaacson <adi@bitmover.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Christian Kujau <evil@g-house.de>, linux-kernel@vger.kernel.org
Subject: Re: [OT] "bk pull" does not update my sources...?
Message-ID: <20040517174501.GC8322@bitmover.com>
References: <40A51CFB.7000305@g-house.de> <c85lk9$96j$1@sea.gmane.org> <40A7A145.5020201@g-house.de> <20040516102936.0c0df511.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516102936.0c0df511.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 10:29:36AM -0700, Randy.Dunlap wrote:
> On Sun, 16 May 2004 19:13:41 +0200 Christian Kujau <evil@g-house.de> wrote:
> | walt schrieb:
> | |> evil@sheep:/usr/src/linux-2.6-BK$ head -n5 Makefile
> | |> VERSION = 2
> | |> PATCHLEVEL = 6
> | |> SUBLEVEL = 6
> | |> EXTRAVERSION =
> | |
> | | This is correct.  Linus does not include the 'bk' in the 'extraversion'
> | | field.
> | 
> | so, the Makefile from the -bk snapshots (e.g. patch-2.6.6-bk1.bz2) was
> | edited and will show an EXTRAVERSION of "-bk1", while the original
> | Makefile does not? this is insane!
> 
> Right.  The bk tree does not contain -bkN or anything in the
> EXTRAVERSION string.  The bk snapshots do add that string.
> 
> I don't find it hard to keep them separated, but, yeah, that's the
> way it is.

Perhaps a kernel built from BK sources should have the :UTC: or :MD5KEY:
in the version output.  "bk changes -r+ -d:UTC:" is the command to get
the current UTC string; that's an all-numeric representation of the date
of the current top cset.

The downside is that if you just do something like
BKEXTRAVERSION := `bk changes -r+ -d:UTC:`
then there is no way to distinguish "clean, everything corresponds to
BK" from "I edited some files, or applied a patch, and haven't created a
cset yet".  Of course you can do something like "bk -r diffs -u|wc -l"
to get an indication of diff size, but that's pretty hackish.

-andy
