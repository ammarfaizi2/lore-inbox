Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTFIWqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTFIWqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 18:46:05 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:51467 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S262259AbTFIWqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 18:46:01 -0400
Date: Tue, 10 Jun 2003 00:59:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: wa@almesberger.net, <chas@cmf.nrl.navy.mil>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
In-Reply-To: <20030608.223501.71104915.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0306100011230.5042-100000@serv>
References: <Pine.LNX.4.44.0306071922350.12110-100000@serv>
 <20030607.235706.41641672.davem@redhat.com> <Pine.LNX.4.44.0306082228460.5042-100000@serv>
 <20030608.223501.71104915.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 8 Jun 2003, David S. Miller wrote:

> The transition is half complete.  Eventually even that
> "wait for refcount to hit zero" part will go away, and
> also we will add the logic to mark the device at "dead"
> and then teach all the sysfs/procfs routines to error out
> if they see the device they are examining is in this state.

This would be basically the same as moving the try_module_get/module_put 
calls from the open/close to the read/write functions.
You still need to synchronize with already running functions and if your 
that far it's probably easier to simply replace the ops pointer to get rid 
of the dead test.
This still leaves you with a very limited control of the module unloading 
process...

bye, Roman

