Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTLJGmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 01:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTLJGmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 01:42:35 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:57844 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262101AbTLJGme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 01:42:34 -0500
From: dan carpenter <error27@email.com>
To: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi scheduling while atomic in linux-2.6.0-test11
Date: Tue, 9 Dec 2003 21:20:17 -0800
User-Agent: KMail/1.5.4
References: <3FD6AF84.5010805@samwel.tk>
In-Reply-To: <3FD6AF84.5010805@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092120.18367.error27@email.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 09:30 pm, Bart Samwel wrote:
> [1.] One line summary of the problem:
>
> ide-scsi scheduling while atomic in linux-2.6.0-test11
>

You don't need ide-cd to burn cds in 2.6 so the easiest fix is to just stop 
using ide-cd.  Anyway,  here is the buggy code that causes the problem:

drivers/scsi/ide-scsi.c
895:         spin_lock_irqsave(&ide_lock, flags);
896:         while (HWGROUP(drive)->handler) {
897:                 HWGROUP(drive)->handler = NULL;
898:                 schedule_timeout(1);
899:         }

The fix is quite complicated and I don't know how to do it correctly.  :/

regards,
dan carpenter


