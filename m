Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVLQUiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVLQUiy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVLQUir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:38:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964917AbVLQUib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:38:31 -0500
Date: Sat, 17 Dec 2005 12:38:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Fritzsch <fritzsch@cip.physik.uni-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slow sync of fat 32 hotplugged devices
Message-Id: <20051217123803.82b3d8d5.akpm@osdl.org>
In-Reply-To: <43A1B5B9.2040307@cip.physik.uni-muenchen.de>
References: <43A1B5B9.2040307@cip.physik.uni-muenchen.de>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Fritzsch <fritzsch@cip.physik.uni-muenchen.de> wrote:
>
> Wouldnt it be a nice behaviour, if you could mount a file in a new sync
> mode, where it isnt synchronized during writing a file, only when a
> close ioctl command was executed on a filehandle?
> sync writing to hotplugged devices would be a lot faster then.

Yeah, this was discussed recently: `mount -o flush'.  It'll sync each file
on the final close().  I forget who was doing that, but it's gone quiet
lately.

It's not completely trivial - some work in each fs will be needed to check
that we sync everything which should be sunc.  Such as the superblock...
