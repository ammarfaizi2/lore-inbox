Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUIUPnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUIUPnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUIUPnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:43:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:45704 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267767AbUIUPnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:43:05 -0400
Date: Tue, 21 Sep 2004 08:41:11 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Message-ID: <20040921154111.GA13028@kroah.com>
References: <414F111C.9030809@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414F111C.9030809@linuxtv.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 07:19:24PM +0200, Michael Hunold wrote:
>  
> +	/* a ioctl like command that can be used to perform specific functions
> +	 * with the adapter.
> +	 */
> +	int (*command)(struct i2c_adapter *adapter, unsigned int cmd, void *arg);

Ick ick ick.  We don't like ioctls for the very reason they aren't type
safe, and you can pretty much stick anything in there you want.  So
let's not try to add the same type of interface to another subsystem.

How about we add the exact explicit functionality that you want, one
function per "type" of operation, like all other subsystems have.

thanks,

greg k-h
