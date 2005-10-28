Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVJ1NQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVJ1NQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 09:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbVJ1NQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 09:16:07 -0400
Received: from [213.8.54.133] ([213.8.54.133]:6288 "EHLO fw.netmor.com")
	by vger.kernel.org with ESMTP id S965225AbVJ1NQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 09:16:07 -0400
Message-ID: <4362248C.3060401@weizmann.ac.il>
Date: Fri, 28 Oct 2005 15:15:56 +0200
From: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en, ru, he
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
References: <4360C0A7.4050708@weizmann.ac.il> <200510271609.47309.rob@landley.net> <436211B0.1050509@weizmann.ac.il> <200510280726.56684.rob@landley.net>
In-Reply-To: <200510280726.56684.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> It looks like one bug to me.  The initial mount figures out that it's read 
> only, and the actual writes fail correctly, but remount isn't checking for 
> read only (and thus isn't failing).

Right, but even after remount seemingly succeeds, an attempt to write to 
  an unwritable media should return an error nevertheless, as the 
corresponding syscall should fail, obviously. And it indeed happens for 
e.g. CDROM or an NFS volume (if you repeat all the steps from my 
original post, "touch" will return an error). Yet for floppy, it 
doesn't. I suspect that a "readonly-ness" is defined at a different 
level for floppy (e.g. status of the device itself, not media). This is 
just a wild guess.

Regards,

Evgeny
