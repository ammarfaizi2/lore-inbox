Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSGLLhD>; Fri, 12 Jul 2002 07:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSGLLhC>; Fri, 12 Jul 2002 07:37:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4747 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315971AbSGLLhB>; Fri, 12 Jul 2002 07:37:01 -0400
Date: Fri, 12 Jul 2002 07:41:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: ioctl between user/kernel space
In-Reply-To: <03781128C7B74B4DBC27C55859C9D73809840659@es06snlnt>
Message-ID: <Pine.LNX.3.95.1020712072442.13174A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, Shipman, Jeffrey E wrote:

> Thanks for your answers. I do have a couple more questions,
> however:
> 
> 1) I'm not dealing with any hardware. Is it still ok to
> call some sort of register_xxxdev() function? If so, where can
> I find the definitions of these register functions and which
> one would you think be appropriate for a module which simply
> does packet manipulation via Netfilter?
> 

In that case, you want to look at ../ipv4/netfilter/ip_fw_compat.c and
../ipv4/netfilter/ip_chains_core.c.

You can see that these network things don't generally use ioctl(),
although a device driver can. Instead, you probably should use
setsockopt() from user-space and enable it in you driver with:
	nf_register_sockopt(struct nf_sock_ops *);

Your function address is put into the 6th member of nf_sock_ops. Just
check out existing code in netfilter. It's quite straight-forward. 

setsockopt(int s, int level, int name, void *val, int len);
The void *val can be a pointer to your table of parameters and
it's length is put into len.

> 2) What if my module is not in the kernel? Does ioctl()
> just return an error code?
> 

Well, if it's not in the kernel, you can do anything you want,
passing parameters using shared-memory to Morse-Code, and everything
in-between.

> Thanks again.
> 
> Jeff Shipman - CCD
> Sandia National Laboratories
> (505) 844-1158 / MS-1372



Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

