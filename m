Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWACVrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWACVrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWACVrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:47:06 -0500
Received: from [81.2.110.250] ([81.2.110.250]:37578 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964952AbWACVrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:47:04 -0500
Subject: Re: ATA Write Error and Time-out Notification in User Space
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Treubig <jtreubig@hotmail.com>
Cc: raw@dslr.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <BAY101-F32BC19A49EC86F6FED361BDF2C0@phx.gbl>
References: <BAY101-F32BC19A49EC86F6FED361BDF2C0@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Jan 2006 21:48:04 +0000
Message-Id: <1136324884.22598.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-03 at 13:27 -0600, John Treubig wrote:
> I receive this as great news, only I don't know where the -mm tree is 
> located to see if I can get the patch or fix!  Can you give me a few 
> pointers?!

The -mm patches live on kernel.org in pub/linux/kernel/people/akpm/

The patch you want is the one to drivers/ide/ide-io.c although be aware
it will make non PCI ATA controllers crash on errors if applied. The
"right" fix for this is probably to have a hwif->flush_data() function
that defaults to try_to_flush_leftover_data() so that the knowledge
involved is not hacked into the ide core but kept in the driver.


Alan

