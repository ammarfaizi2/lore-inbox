Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261221AbRELLTs>; Sat, 12 May 2001 07:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261222AbRELLTi>; Sat, 12 May 2001 07:19:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56592 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261221AbRELLTa>; Sat, 12 May 2001 07:19:30 -0400
Subject: Re: ENOIOCTLCMD?
To: jlundell@pobox.com (Jonathan Lundell)
Date: Sat, 12 May 2001 12:16:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p05100302b7226d91e632@[207.213.214.37]> from "Jonathan Lundell" at May 11, 2001 10:01:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yXNZ-000447-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can somebody explain the use of ENOIOCTLCMD? There are order of 170 
> uses in the kernel, but I don't see any guidelines for that use (nor 
> what prevents it from being seen by user programs).

It should never be seen by apps. If it can be then it is wrong code.
Basically you use it in things like



	int err = dev->ioctlfunc(dev, op, arg);
	if( err != -ENOIOCTLCMD)
		return err;

	/* Driver specific code does not support this ioctl */

	switch(op)
	{

			...
		default:
			return -ENOTTY;
	}

Its a way of passing back 'you handle it' 
