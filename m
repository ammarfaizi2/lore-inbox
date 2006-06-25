Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWFYKma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWFYKma (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWFYKma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:42:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53217 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932328AbWFYKma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:42:30 -0400
Subject: Re: Badness in remove_proc_entry in wlan driver unregistration.
From: Arjan van de Ven <arjan@infradead.org>
To: Ram <vshrirama@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8bf247760606250217i5c0079f2o997be3518b22d7a6@mail.gmail.com>
References: <8bf247760606250217i5c0079f2o997be3518b22d7a6@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 12:42:27 +0200
Message-Id: <1151232147.4940.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 14:47 +0530, Ram wrote:
> Hi,
>  when i try to unload a wlan driver i get  the message:
> 
>  Badness in remove_proc_entry at fs/proc/generic.c:705
> 
> 
>   This comes from the statment in the driver:
> wlan_proc_remove("wlan");
> 
> 
>   How does one solve the problem.
> 
> 
>   This wlan driver was in 2.4. i ported it to 2.6. Is there any
> difference as far as wlan/networking unregistering is concerned for a
> wlan driver.


the driver is probably trying to remove a non-empty directory from proc,
which causes data corruption (both in 2.4 and 2.6)... 2.6 warns about it
though, 2.4 probably doesn't.

can you give a pointer to the driver source so that we can help fix it?

