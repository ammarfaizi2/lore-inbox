Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUDOT6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUDOT6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:58:40 -0400
Received: from mtaw6.prodigy.net ([64.164.98.56]:20706 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262468AbUDOT6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:58:39 -0400
Message-ID: <407EE9A5.3020305@pacbell.net>
Date: Thu, 15 Apr 2004 12:59:33 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Colin Leroy <colin@colino.net>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.6-rc1: cdc-acm still (differently) broken
References: <20040415201117.11524f63@jack.colino.net>	<407EDA4A.2070509@pacbell.net> <20040415212334.4a568c5a@jack.colino.net>
In-Reply-To: <20040415212334.4a568c5a@jack.colino.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

>>That test has always been buggy -- better to just remove it.  For
>>that matter, usb_interface_claimed() calls should all vanish ... it's
>>better to fail if claiming the interface fails (one step, not two).
>>Care to try an updated patch?
> 
> 
> Like this one? It works. I'm a bit wondering, however, how comes 
> usb_interface_claimed() returns true, and the check in 
> usb_driver_claim_interface() passes?

Pretty much like that one, but not leaking the other urbs ... :)

There are two interfaces involved, for "control" and "data".
"Control" is being probed; and "data" is what gets claimed.

For more info, you could see how "usbnet" handles CDC Ethernet;
see how it parses the CDC Union descriptor (which is what the
FIXME refers to).  Or read the CDC spec, from www.usb.org as PDF.

- Dave



