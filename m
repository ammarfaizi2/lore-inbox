Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUI1OPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUI1OPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 10:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUI1OPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 10:15:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:47801 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267772AbUI1OMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 10:12:49 -0400
Date: Tue, 28 Sep 2004 07:12:43 -0700
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       germano.barreiro@cyclades.com
Subject: Re: [PATCH] cyclades.c sysfs statistics support
Message-ID: <20040928141242.GA27728@kroah.com>
References: <20040928120421.GB11779@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928120421.GB11779@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 09:04:21AM -0300, Marcelo Tosatti wrote:
> +    device_create_file(&(cy_card[info->card].pdev->dev), &_cydas[line]);            

Why the array of attributes?  As you only have one (which is wrong...)
you only need one attribute structure.

> +  show_sys_data - shows the data exported to sysfs/device, mostly the signals status involved in the
> +  serial communication such as CTS,RTS,DTS,etc

NO!  sysfs is 1 value per file.  Not a whole bunch of values per one
file.  Please change this to create a whole bunch of little files, not
one big one.

thanks,

greg k-h
