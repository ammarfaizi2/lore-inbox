Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVCJBec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVCJBec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVCJBUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:20:40 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:1746 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262572AbVCJAlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:41:21 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] make st seekable again
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 10 Mar 2005 01:43:57 +0100
References: <fa.i3f7d9s.30m8rg@ifi.uio.no> <fa.l4kuq52.e6001g@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1D9BmR-00026p-03@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-03-08 at 17:25, Linux Kernel Mailing List wrote:
>> ChangeSet 1.2030, 2005/03/08 09:25:05-08:00, kai.makisara@kolumbus.fi

>> [PATCH] make st seekable again
>> 
>> Apparently `tar' errors out if it cannot perform lseek() against a tape. 
>> Work around that in-kernel.
> 
> Unfortunately this isn't a good idea. Allowing tar to read the tape
> position makes sense, allowing it to zero the position might but you
> have to do major surgery on the driver first because
> 
> 1.    It doesn't use ppos
> 2.    It doesn't do locking on the ppos at all
> 
> Also allowing apps to randomly seek and report "ok" when they are
> backing up to tape and might really need to see the error is not what
> I'd call stable, professional or quality code.

Can the lseek be restricted to seek from 0 to 0 (or even * to 0 aka rewind)?
This would re-enable tar and probably other applications depending on this
API while not giving them false positives.

