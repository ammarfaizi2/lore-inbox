Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267233AbUFZXjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267233AbUFZXjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUFZXjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:39:14 -0400
Received: from sphinx.mythic-beasts.com ([212.69.37.6]:62429 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S267233AbUFZXjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:39:13 -0400
Date: Sun, 27 Jun 2004 00:38:31 +0100 (BST)
From: chris@scary.beasts.org
X-X-Sender: cevans@sphinx.mythic-beasts.com
To: Joao Santos <jps@corah.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: setuid odd behaviour
In-Reply-To: <007b01c45bd2$9c0687f0$020010ac@local>
Message-ID: <Pine.LNX.4.58.0406270032190.24811@sphinx.mythic-beasts.com>
References: <007b01c45bd2$9c0687f0$020010ac@local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 27 Jun 2004, Joao Santos wrote:

> Hello everyone.
>
> I have been rewriting a private privilege system in the 2.6.7 kernel and
> while making the final tests, vsftpd did not work because it could not set
> capabilities after changing to UID 99 (which seemed correct to me).  Just to
> make sure I was doing the right thing, I booted up a vanilla kernel and
> traced vsftpd again to see how the kernel was reacting to that setcap()
> after setuid() and strangely the kernel let the setcap through and returned
> success.

Yep - vsftpd uses prctl(PR_SET_KEEPCAPS, 1) to achieve this.
It's necessary because there's little point in reducing your capability
set unless you also switch away from uid 0 (it owns files which could be
used to regain full capabilities).

Cheers
Chris
