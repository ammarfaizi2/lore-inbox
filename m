Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbUK3DFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbUK3DFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUK3DFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:05:25 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:3969 "EHLO
	musoma.fsmlabs.com") by vger.kernel.org with ESMTP id S261923AbUK3DFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:05:19 -0500
Date: Thu, 25 Nov 2004 09:45:57 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Any reason why we don't initialize all members of struct
 Xgt_desc_struct in doublefault.c ?
In-Reply-To: <Pine.LNX.4.61.0411250011160.3447@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0411250944150.6452@musoma.fsmlabs.com>
References: <Pine.LNX.4.61.0411250011160.3447@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2004, Jesper Juhl wrote:

> Yes, this is nitpicking, but I just can't leave small corners like this 
> unpolished ;)
> 
> in arch/i386/kernel/doublefault.c you will find this (line 20) :
> 
> struct Xgt_desc_struct gdt_desc = {0, 0};
> 
> but, struct Xgt_desc_struct has 3 members, 
> 
> struct Xgt_desc_struct {
>         unsigned short size;
>         unsigned long address __attribute__((packed));
>         unsigned short pad;
> } __attribute__ ((packed));
> 
> so why only initialize two of them explicitly?
> 
> 
> Wouldn't this be nicer? :

I can't see what the point is, it's a machine defined struct which only 
uses the first 6bytes. It'll never bother with the pad variable.
