Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSHGJzh>; Wed, 7 Aug 2002 05:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSHGJzh>; Wed, 7 Aug 2002 05:55:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5112 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316530AbSHGJzg>; Wed, 7 Aug 2002 05:55:36 -0400
Subject: Re: kernel thread exit race
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
In-Reply-To: <15696.59115.395706.489896@laputa.namesys.com>
References: <15696.59115.395706.489896@laputa.namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 12:18:31 +0100
Message-Id: <1028719111.18156.227.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2002-08-07 at 10:22, Nikita Danilov wrote:
> Hello,
> 
> what is the politically correct way to exit from a kernel thread daemon
> without module unload races?

You probably want to use completions. There is a function in the kernel
core "complete_and_exit" which does both the complete() and then the
exit() so that after complete finishes the task will not re-enter
modulespace and risk an unload race


