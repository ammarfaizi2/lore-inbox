Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbTEEMJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbTEEMJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:09:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44452
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262155AbTEEMJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:09:58 -0400
Subject: Re: illegal context for sleeping ... rmmod ide-cd + ide-scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dougg@torque.net
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <3EB65028.8080402@torque.net>
References: <3EB62347.8020109@torque.net>
	 <20030505020104.0abc66ba.akpm@digeo.com>  <3EB65028.8080402@torque.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052133832.28938.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 May 2003 12:23:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-05 at 12:51, Douglas Gilbert wrote:
> > ide_unregister_subdriver() does spin_lock_irqsave(&ide_lock), then
> > calls auto_remove_settings(), which does down(&ide_setting_sem);
> > 
> > A simple fix might be:
> 
> Andrew,
> Thanks. That patch clears the reported problem.

This is already fixed in 2.4.x btw. Just hadn't got pushed into 2.5 yet

The 2.5.x code has another problem as well there is a basically unfixable
deadlock in the proc and config stuff when flipping a device in and out of
scsi mode

