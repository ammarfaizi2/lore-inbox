Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbUKEOyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbUKEOyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUKEOyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:54:35 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:14 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261643AbUKEOy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:54:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kuEKgH6geV+KENtL0rCG8N9myDqD/WIEBGU5+eelV9Ks2iRNqLjF0MOi8DsGmbm9eZ9502qCRQoyKJizdbdgrailDO9/83ZsAyvyhLZHAWzLKqyOrS9BXgrwkweqhTkedXXQcWH6QiNcmuD15ku759WRaDHCqmC4EaNXGc81Izc=
Message-ID: <d120d50004110506533688f8a7@mail.gmail.com>
Date: Fri, 5 Nov 2004 09:53:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.10-rc1 0/4] driver-model: manual device attach
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       rusty@rustcorp.com.au, mochel@osdl.org
In-Reply-To: <20041105063237.GA28308@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041104074330.GG25567@home-tj.org>
	 <20041104175318.GH16389@kroah.com>
	 <200411050002.57174.dtor_core@ameritech.net>
	 <20041105063237.GA28308@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004 15:32:37 +0900, Tejun Heo <tj@home-tj.org> wrote:
> On Fri, Nov 05, 2004 at 12:02:57AM -0500, Dmitry Torokhov wrote:
> 
> > Do we really need 2 or even 3 files ("attach", "detach" and "rescan")?
> > Given that you really can't (at least not yet) do all there operations
> > for all buses from the core that woudl require 3 per-bus callbacks.
> > I think reserving special values such as "none" or "detach" and "rescan"
> > shoudl work just fine and also willallow extending supported operations
> > on per-bus basis. For example serio bus supports "reconnect" option which
> > tries to re-initialize device if something happened to it. It does not
> > want to do rescan as that would generate new input devices while it is
> > much more convenient to re-use old ones.
> 
> How about making the command format "CMD ARGS" rather than
> "{CMD|DRIVERNAME}"  i.e.
> 
> not
> 
> # echo e100 > drvctl
> # echo detach > drvctl
> 
> but
> 
> # echo attach e100 > drvctl
> # echo detach > drvctl
> 
> But, I don't know.  It now just seems too much like a proc node.
>

Well, I was lazy and did not want to do any parsing at all, but I do
not have anything against "CMD ARG ARG ARG" form, especially
if integrate drvparm. 

-- 
Dmitry
