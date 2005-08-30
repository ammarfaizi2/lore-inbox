Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVH3WGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVH3WGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVH3WGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:06:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932448AbVH3WGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:06:41 -0400
Date: Tue, 30 Aug 2005 14:55:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: LSM root_plug module questions
Message-ID: <20050830215518.GX7991@shell0.pdx.osdl.net>
References: <20050830213112.GA28997@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050830213112.GA28997@hardeman.nu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Härdeman (david@2gen.com) wrote:
> I'm currently playing around with the security/root_plug.c LSM module 
> and I have two questions:

you'll have better luck on the lsm list 

> 1) What's the recommended way of telling that someone is logging in to 
> the computer (via ssh, virtual console, serial console, X, whatever) 
> with LSM? Look for open() on /dev/pts?

logging in...this is really a userspace notion, so via PAM.  creating a
new process or changing credentials of a new process are the types of
things that lsm watches (and of course, opening of files).

> 2) root_plug currently scans the usb device tree looking for the 
> appropriate device each time it's needed. In the interest of making the 
> result of the lookup cached, it is possible for a module to register so 
> that it is notified when a usb device is added/removed?

I don't think that can be done in a race free manner.  Perhaps get the
device and check its state, but you'd have to ask usb folks.  ATM, it's
only checked during exec of root process.
