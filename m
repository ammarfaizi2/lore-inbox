Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbSKUAce>; Wed, 20 Nov 2002 19:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbSKUAce>; Wed, 20 Nov 2002 19:32:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6335 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266228AbSKUAcc>;
	Wed, 20 Nov 2002 19:32:32 -0500
Date: Wed, 20 Nov 2002 19:39:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: kill i_dev
In-Reply-To: <UTC200211210007.gAL07Pa07926.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0211201936200.6440-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Nov 2002 Andries.Brouwer@cwi.nl wrote:

> One disadvantage of enlarging the size of dev_t is
> that struct inode grows. Bad.
> We used to have i_dev and i_rdev; today i_rdev has split into
> i_rdev, i_bdev and i_cdev. Bad.
> 
> It looks like these four fields can be replaced by a single one,
> making struct inode smaller. Not bad.

No, they can't.  We _can_ put i_bdev/i_cdev into union and we can
kill i_dev.  However, rdev and [cb]dev will have to remain separate.

BTW, watch out for socket.c use of ->i_dev.

