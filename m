Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUHJPkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUHJPkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUHJPkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:40:35 -0400
Received: from mail.appliedminds.com ([65.104.119.58]:48857 "EHLO
	appliedminds.com") by vger.kernel.org with ESMTP id S267250AbUHJPkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:40:14 -0400
Message-ID: <4118EBEA.10809@appliedminds.com>
Date: Tue, 10 Aug 2004 08:38:18 -0700
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040421)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sascha Wilde <wilde@sha-bang.de>
CC: "David N. Welton" <davidw@eidetix.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <auto-000000462036@appliedminds.com> <411735BD.3000303@eidetix.com> <20040810093734.GA1089@kenny.sha-bang.local>
In-Reply-To: <20040810093734.GA1089@kenny.sha-bang.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha Wilde wrote:
> On Mon, Aug 09, 2004 at 10:28:45AM +0200, David N. Welton wrote:
> 

> 
> Big question:  how was the initialisation of the PS/2 ports managed in
> 2.4.x?  Ther seems to be no similar code to i8042.c in it[0], and all I
> have found till now is a bunch ob obscure jump-rables in
> arch/i386/kernel/setup.c ...

Look at drivers/char/pc_keyb.c
That's where the 2.4.x initialization takes place it seems.
It's pretty generic, but it looks like some of the commands are similar 
in initialize_kbd() - constants are in include/linux/pc_keyb.h

Pretty much all PC hardware has a i8042-like controller, so I think that 
file is the generic PC keyboard startup for i8042-like devices.

Looks like 2.6.x abstracted this a little farther through the serio 
layer, so at initialization, the system tries to assign a particular 
driver to the serio ports it finds (there are drivers for AT, i8042 (and 
variants), etc..)

-- 
James Lamanna
