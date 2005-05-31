Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVEaOrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVEaOrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVEaOrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:47:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:16818 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261623AbVEaOpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:45:24 -0400
Subject: Re: [PATCH] Don't explode on swsusp failure to find swap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050531103623.GB1848@elf.ucw.cz>
References: <1117523585.5826.18.camel@gaston>
	 <20050531103623.GB1848@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 00:45:06 +1000
Message-Id: <1117550706.5826.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 12:36 +0200, Pavel Machek wrote:
> Hi!
> 
> > If we specify a swap device for swsusp using resume= kernel argument and
> > that device doesn't exist in the swap list, we end up calling
> > swsusp_free() before we have allocated pagedir_save. That causes us to
> > explode when trying to free it.
> > 
> > Pavel, does that look right ?
> 
> It looks like a workaround. We should not call swsusp_free in case
> device does not exists. Quick look did not reveal where the bug comes
> from, can you try to trace it?
> 								Pavel

Well, the bug comes from arch code calling swsusp_save() which fails,
then we call swsusp_free()

Ben.


