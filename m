Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTLWD31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 22:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTLWD31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 22:29:27 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:4540 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264933AbTLWD3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 22:29:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource dealloocation problems
Date: Mon, 22 Dec 2003 22:29:17 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Manuel Estrada Sainz <ranty@debian.org>,
       Patrick Mochel <mochel@osdl.org>
References: <200312210137.41343.dtor_core@ameritech.net> <20031222093759.GB30235@kroah.com>
In-Reply-To: <20031222093759.GB30235@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312222229.17991.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 December 2003 04:37 am, Greg KH wrote:
> On Sun, Dec 21, 2003 at 01:37:39AM -0500, Dmitry Torokhov wrote:
> > Hi,
> >
> > It seems that implementation of the firmware loader is racy as it
> > relies on kobject hotplug handler. Unfortunately that handler runs
> > too early, before firmware class attributes controlling the loading
> > process, are created. This causes firmware loading fail at least half
> > of the times on my laptop.
>
> Um, why not have your script wait until the files are present?  That
> will remove any race conditions you will have.
>

How long should the userspace wait? One second as Manuel suggested?
Indefinitely? Or should the firmware agent have some timeout? If userspace
uses a timeout how should it correlate with the timeout on the kernel side?

I am sorry but I have to disagree with you. Kernel should not call user
space until it has all infrastructure in place and is ready. Anything
else is just a sloppy practice.

Dmitry
