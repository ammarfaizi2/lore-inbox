Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSJPKCb>; Wed, 16 Oct 2002 06:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265007AbSJPKCb>; Wed, 16 Oct 2002 06:02:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7343 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262373AbSJPKCa>;
	Wed, 16 Oct 2002 06:02:30 -0400
Date: Wed, 16 Oct 2002 02:59:35 -0700 (PDT)
Message-Id: <20021016.025935.132073102.davem@redhat.com>
To: matti.aarnio@zmailer.org
Cc: zilvinas@gemtek.lt, linux-kernel@vger.kernel.org
Subject: Re: sendfile(2) behaviour has changed ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021016091046.GD9644@mea-ext.zmailer.org>
References: <20021016084908.GA770@gemtek.lt>
	<20021016091046.GD9644@mea-ext.zmailer.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matti Aarnio <matti.aarnio@zmailer.org>
   Date: Wed, 16 Oct 2002 12:10:46 +0300

   On Wed, Oct 16, 2002 at 10:49:08AM +0200, Zilvinas Valinskas wrote:
   > Is this expected behaviour ? that sendfile(2) on 2.5.4x linux kernel requires
   > socket as an output fd paramter ? 
   
     It has only been intended for output to a TCP stream socket.

To be honest, I'm not so sure about this.

For example, I definitely see us supporting this in the
opposite direction when commodity 10gbit hits the market.

Initially I thought "sys_receivefile()" but it makes no
sense when we have a system call that is perfectly capable
of describing the tcp_socket --> page_cache operation.

And I don't think the vfs copy operation using sendfile
is such a bad thing either.  It definitely opens the door
for some interesting optimizations.  For example, if the
source page is not mapped by a process it could be possible
to just unhash it, mark it dirty, then hash it into the
destination file.  Exactly 2 I/O operations and the cpu
doesn't touch the data at all.
