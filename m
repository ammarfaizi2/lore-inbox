Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280495AbRKJR6f>; Sat, 10 Nov 2001 12:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280547AbRKJR60>; Sat, 10 Nov 2001 12:58:26 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:9355
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S280495AbRKJR6K>; Sat, 10 Nov 2001 12:58:10 -0500
Date: Sat, 10 Nov 2001 17:56:53 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Numbers: ext2/ext3/reiser Performance (ext3 is slow)
Message-ID: <20011110175653.A24128@fenrus.demon.nl>
In-Reply-To: <E162ZQN-00069u-00@fenrus.demon.nl> <Pine.LNX.4.40.0111101831440.14552-100000@omega.hbh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0111101831440.14552-100000@omega.hbh.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 06:41:15PM +0100, Oktay Akbal wrote:

> The question is, when to use what mode. I would use data=journal on my
> CVS-Archive, and maybe writeback on a news-server.

sounds right; add to this that sync NFS mounts also are far better of with
data=journal.

> But what to use for an database like mysql ?

Well you used reiserfs before. data=writeback is equivalent to the
protection reiserfs offers. Big databases such as Oracle do their own
journalling and will make sure transactions are actually on disk before they
finalize the transaction to the requestor. mysql... I'm not sure about, and
it also depends on if it's a mostly-read-only database, a mostly-write
database or a "mixed" one. In the first cases, mounting "sync" with
full journalling will ensure full datasafety; the second case might just be
faster with full journalling (full journalling has IO clustering benefits
for lots of small, random, writes) but for the mixed case it's a matter of
reliablity versus performance.....

Greetings,
   Arjan van de Ven
