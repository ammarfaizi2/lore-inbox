Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUJGUPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUJGUPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJGUNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:13:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9906 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267976AbUJGULq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:11:46 -0400
Subject: Re: [Patch] new serial flow control
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, sebastien.hinderer@libertysurf.fr
In-Reply-To: <20041005172522.GA2264@bouh.is-a-geek.org>
References: <200410051249_MC3-1-8B8B-5504@compuserve.com>
	 <20041005172522.GA2264@bouh.is-a-geek.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097176130.31557.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 20:08:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-05 at 18:25, Samuel Thibault wrote:
> No: data actually pass _after_ CTS and RTS are lowered back: the flow control
> only indicate the beginning of one frame.

Ok I've pondered this somewhat. I don't think the hack proposed is the
right answer for this. I believe you should implement a simple line
discipline for this device so that it stays out of the general code.

Right now that poses a challenge but if drivers were to implement
ldisc->modem_change() or a similar callback for such events an ldisc
could then handle many of the grungy suprises and handle them once and
in one place.

Thoughts ?

Alan

