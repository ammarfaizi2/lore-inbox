Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTFIXKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTFIXKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:10:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8650 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262318AbTFIXKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:10:16 -0400
Date: Mon, 9 Jun 2003 16:25:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New system device API
In-Reply-To: <1055201047.2119.18.camel@laptop-linux>
Message-ID: <Pine.LNX.4.44.0306091623030.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Well, you need to suspend devices used to write the image, too, so you
> > have state to return to after resume. You only do not want disks to
> > spin down. Perhaps disk can just special-case it ("If I am going to
> > swsusp, I need to save state, but do not really need to spin down").
> 
> Mmm. Sounds ugly though. Would it be fair to say we want to S5 some
> devices and S3 others? Perhaps that sort of terminology might be
> helpful.

Those are not even valid states for devices. Device states are commonly 
D0-D3, though they are not represented the same way for all kinds of 
devices. 

Pavel is right, and we should be able to do that generically, though in a 
slightly different manner. We should have all devices save state, write 
the image, then power them down (including spinning down disks). 


	-pat

