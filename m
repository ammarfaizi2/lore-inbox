Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUDOSzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUDOSxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:53:32 -0400
Received: from mtaw6.prodigy.net ([64.164.98.56]:16814 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261638AbUDOSxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:53:13 -0400
Message-ID: <407EDA4A.2070509@pacbell.net>
Date: Thu, 15 Apr 2004 11:54:02 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Colin Leroy <colin@colino.net>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.6-rc1: cdc-acm still (differently) broken
References: <20040415201117.11524f63@jack.colino.net>
In-Reply-To: <20040415201117.11524f63@jack.colino.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy wrote:
> Hi,
> 
> I gave 2.6.6-rc1 a try, and found that cdc-acm is now broken is a new way:
> ... usb_interface_claimed() returns true ... intf->dev.driver is already cdc-acm 

The interface being probed is by definition not going to be claimed
by any other driver ... it shouldn't check or claim that interface.

That test has always been buggy -- better to just remove it.  For
that matter, usb_interface_claimed() calls should all vanish ... it's
better to fail if claiming the interface fails (one step, not two).
Care to try an updated patch?

This started to matter because as of RC1, usbcore got rid of the last of
some pre-driver-model code for driver binding.  There might be a similar
bug in the ALSA usb audio driver, according to 'grep'.

- Dave



> 
> HTH,


