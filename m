Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290675AbSARLim>; Fri, 18 Jan 2002 06:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290676AbSARLiW>; Fri, 18 Jan 2002 06:38:22 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:775 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290675AbSARLiQ>; Fri, 18 Jan 2002 06:38:16 -0500
Date: Fri, 18 Jan 2002 12:38:07 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Craig Christophel <merlin@transgeek.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: attr.c::notify_change() -- locking_change
In-Reply-To: <20020118043308.B9A75B581@smtp.transgeek.com>
Message-ID: <Pine.LNX.4.33.0201181226180.14369-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Jan 2002, Craig Christophel wrote:

> +		spin_lock(&inode_lock);
> +		if(inode->i_state & I_ATTR_LOCK) {
> +			spin_unlock(&inode_lock);
> +		}
> +		else {
> +			inode->i_state =| I_ATTR_LOCK;
> +			tflag = 1;
> +			spin_unlock(&inode_lock);
> +		}

There are other write accesses to i_state, so you either have to protect
them all with this lock or you could convert all accesses to use bitfield
instructions.

> +static inline void wait_on_inode(struct inode *inode, int flag);

Instead of the flag two separate functions wait_on_inode_lock,
wait_on_inode_attr_lock are IMO more readable and cleaner.

bye, Roman

