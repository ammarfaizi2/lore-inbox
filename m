Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUCYQ6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUCYQ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:56:44 -0500
Received: from ida.rowland.org ([192.131.102.52]:7940 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263364AbUCYQ4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:56:34 -0500
Date: Thu, 25 Mar 2004 11:56:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Colin Leroy <colin@colino.net>
cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sf.net>
Subject: Re: [linux-usb-devel] Re: [OOPS] reproducible oops with 2.6.5-rc2-bk3
In-Reply-To: <13c901c41287$d29bb040$3cc8a8c0@epro.dom>
Message-ID: <Pine.LNX.4.44L0.0403251153110.1083-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Colin Leroy wrote:

> Additionally, there's still a reference to altsetting[0] in cdc-acm.c (in
> acm_ctrl_msg()), I don't know if it's intentional or should have been
> converted from
>     acm->control->altsetting[0].desc.bInterfaceNumber
> to
>     acm->control->cur_altsetting.desc.bInterfaceNumber
> ?

It's not as bad as it looks.  All the altsetting entries for an interface
are guaranteed to have the same value stored in desc.bInterfaceNumber, so
it really doesn't matter whether that value is retrieved from the first
entry in the altsetting array or the current entry -- provided of course
that cur_altsetting is a valid pointer!  It's mostly just a matter of 
taste.  I generally prefer to use cur_altsetting because that's the one 
currently installed in the device.

Alan Stern

