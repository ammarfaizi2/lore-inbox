Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270194AbTGUQjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270442AbTGUQjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:39:37 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:45836 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270194AbTGUQjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:39:36 -0400
Date: Mon, 21 Jul 2003 17:54:37 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Ludovic Drolez <ludovic.drolez@freealter.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: keep the linux logo displayed
In-Reply-To: <3F1C0CF6.4010302@freealter.com>
Message-ID: <Pine.LNX.4.44.0307211749400.6905-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi !
> 
> I wondered if anyone knows about a 2 lines patch, to keep the linux logo 
> always displayed in a 2.5.x / 2.6.x kernel ??
> I've tried to patch a few lines in fbcon.c, without success :-(

That wouldn't be easy to do. In struct vc_data (data about VC tty device) 
you have vc_top and vc_bottom. Normally vc_top is 0 and vc_bottom is that 
last row on your screen. For the logo we move vc_top down a little bit. 
The problem is after we start minigetty on the various /dev/ttyX as soon 
as you VC switch you reintialize the screen to the standard behavior of 
vc_top = 0 and vc_bottom is the last row. It would take hacks to the upper 
console layer to do that. 
	You can write a userland app to do this. There are esc sequence 
that change vc_top. You could even alter minigetty if you want.



