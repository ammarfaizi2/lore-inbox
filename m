Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753101AbWKCEwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbWKCEwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbWKCEwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:52:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:17537 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1753101AbWKCEwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:52:40 -0500
Date: Thu, 2 Nov 2006 20:52:35 -0800
From: Greg KH <greg@kroah.com>
To: Aubrey <aubreylee@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to add a device file to sysfs?
Message-ID: <20061103045235.GA24467@kroah.com>
References: <6d6a94c50610302130u55fc3f59n7be157a73c50805e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6a94c50610302130u55fc3f59n7be157a73c50805e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 01:30:36PM +0800, Aubrey wrote:
> Hi all,
> 
> When a misc device file is registered, there are two files under my
> own class directory:
> 
> /sys --> class --> misc --> myprog --> dev
>                                                   --> uevent
>                                                   --> myprog_show (to be 
>                                                   added)
> 
> Now, my question is, is it possbile to add the third file
> "myprog_show" under "myprog" directory without modify any common code?

Yes.

> I've read the doc under linux-2.6.x/Documentation, I can add it to
> some other directory, but not found a way to add it to my own
> directory.

After misc_register() has been successfully called, the variable "class"
will be set in the miscdevice structure.  Use that pointer to call
class_device_create_file() to create your new file in this directory.

Hope this helps,

greg k-h
