Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbTFNRsM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 13:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbTFNRsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 13:48:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51645
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265696AbTFNRsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 13:48:11 -0400
Subject: Re: Linux 2.4.21-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EEAF192.4050102@myrealbox.com>
References: <200306141430.h5EEUuV31162@devserv.devel.redhat.com>
	 <3EEAF192.4050102@myrealbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055613583.8281.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 18:59:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-14 at 10:57, walt wrote:
> This is the offending line in serialmidi.c:
> 
> 	if (tty->count > 1) {
> 		snd_printk(KERN_ERR "tty %s is already used", serial->sdev);
> 
> The compilation will finish if I make this change:
> 
> 	if (atomic_read(&(tty->count)) > 1) {
> 
> Since I don't have a clue what I'm doing this is probably not the right fix :0)
> I suspect that changing the alsa code is starting at the wrong end of the
> problem anyway.

The tty code changed to atomic counters to fix a race. Your fix is
right.


