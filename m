Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSHPO7c>; Fri, 16 Aug 2002 10:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318435AbSHPO7b>; Fri, 16 Aug 2002 10:59:31 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:9222 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S318428AbSHPO7b>; Fri, 16 Aug 2002 10:59:31 -0400
Date: Sat, 17 Aug 2002 01:03:20 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: kuznet@ms2.inr.ac.ru
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
In-Reply-To: <200208161450.SAA29730@sex.inr.ac.ru>
Message-ID: <Mutt.LNX.4.44.0208170057420.1165-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002 kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > All existing paths which write to the pid/uid/euid fields are protected by
> > the BKL
> 
> euid? Are you about current->xxx? You jest, you read it, not write.
> 

I'm talking about writing f_owner fields, i.e:

  filp->f_owner.pid = current->pid;
  filp->f_owner.uid = current->uid;
  filp->f_owner.euid = current->euid;

> Ergo, never use BKL. :-)

Well, do you think it's worth adding a spinlock for just one fcntl handler
and the SIOCSPGRP/FIOSETOWN ioctls?


- James
-- 
James Morris
<jmorris@intercode.com.au>


