Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283724AbRLEQPn>; Wed, 5 Dec 2001 11:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283755AbRLEQPe>; Wed, 5 Dec 2001 11:15:34 -0500
Received: from quark.didntduck.org ([216.43.55.190]:11276 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S283724AbRLEQPX>; Wed, 5 Dec 2001 11:15:23 -0500
Message-ID: <3C0E4803.3BBF045B@didntduck.org>
Date: Wed, 05 Dec 2001 11:14:59 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Removing an executable while it runs
In-Reply-To: <3C0E4487.6000704@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cyrille Beraud wrote:
> 
> Hello,
> I would like to remove an executable from the file-system while it is
> running and
> get all the blocks back immediately, not after the end of the program.
> Is this possible ?
>  From what I understand, the inode is not released until the program
> ends. Do all the
> file-systems behave the same way ?
> 
> Thank you for your help.

It is not possible to reclaim the disk space until the program exits. 
This is because of demand paging of executables.  The file must be kept
around to handle possible future page faults, otherwise the program
would crash if it called code that hadn't been loaded yet or was
discarded due to memory pressure.  This is true of all filesystems.

--

				Brian Gerst
