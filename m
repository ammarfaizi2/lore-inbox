Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVC2Q01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVC2Q01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVC2Q01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:26:27 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:57211 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261187AbVC2Q0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:26:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jS/HF7wOAus0Xwvi8rZ673gZVk7PlosY5CqPEe3JlmJ+/7Jf+XpnyTIVBEG0sUDxnBhFwhm0y6CpxjSErmFLpxJVYPsoKUiLZh77xYV4uyNvlrp3L1r/dZhkZtepy13vuoDPXhk5cVmiTpckBvSx+TGc2Q+CR8Xcm1HIdTSX5cU=
Message-ID: <d120d500050329082665855878@mail.gmail.com>
Date: Tue, 29 Mar 2005 11:26:17 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: klists and struct device semaphores
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0503291055560.1038-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.50.0503280856210.28120-100000@monsoon.he.net>
	 <Pine.LNX.4.44L0.0503291055560.1038-100000@ida.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 11:18:13 -0500 (EST), Alan Stern
<stern@rowland.harvard.edu> wrote:
> 
> With that change in place we can guarantee that every time a USB driver's
> probe() is called, both the interface and the parent device are locked.
> 
> I don't know how cleanly this can be implemented.  You probably don't want
> to lock dev->parent->sem every time, only when needed.  Maybe the simplest
> approach would be to add a flag in struct bus_type, which could be set for
> the USB bus_type and clear for everything else.
>

I think it is fine to lock parent unconditionally. After all
device/driver matching is not the most performance-critical part of
the kernel.

-- 
Dmitry
