Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTHFNwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTHFNwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:52:06 -0400
Received: from chaos.sr.unh.edu ([132.177.249.105]:53189 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S262273AbTHFNwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:52:01 -0400
Date: Wed, 6 Aug 2003 09:51:49 -0400 (EDT)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Andy Winton <andreww@bemac.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple symbols same address in vmlinux map file? huh?
In-Reply-To: <1060177192.2866.11.camel@pussy.bemac.com>
Message-ID: <Pine.LNX.4.44.0308060949200.10203-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Aug 2003, Andy Winton wrote:

> c0305a78 d emergency_lock
> c0305a78 d emergency_pages
> 
> c0303100 d i8259A_irq_type
> c0303100 D i8259A_lock
> 
> c0386628 B jiffies
> c0386628 B jiffies_64

For most of those, the explanation would be that you have zero-sized 
symbols, for example a spinlock_t expands to an empty struct on an UP 
build.

jiffies / jiffies_64 is a special case used to access the same variable as 
a 32 vs 64 bit quantity. (see arch/*/vmlinux.lds*)

--Kai



