Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTEGPvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264081AbTEGPvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:51:55 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:17165 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264080AbTEGPvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:51:53 -0400
Date: Wed, 7 May 2003 17:04:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
Message-ID: <20030507170427.B29161@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB7DCF0.2070207@convergence.de> <20030506214918.A18262@infradead.org> <3EB8CFA2.5090405@convergence.de> <20030507102857.C14040@infradead.org> <3EB92CB1.7050400@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB92CB1.7050400@convergence.de>; from hunold@convergence.de on Wed, May 07, 2003 at 05:56:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 05:56:33PM +0200, Michael Hunold wrote:
> I won't insist on keeping code that I haven't written. My only point is 
> that we use the code in set-top-boxes, where every byte is valuable. But 
>   I suspect that there are numerous other places where we could safe 
> bytes... 8-)

This code will go away soon for both the devfs and non-devfs case..

> > Okay, you're right I should have read more of the code to get the global
> > picture.  You still wan't an owner field for at least struct dvb_device
> > device, though - but the try_module_get must go into dvb_generic_open
> > and maybe in more other places where you use the "backend" modules.
> 
> I don't get that, sorry. The backend modules have functional 
> dependencies and register/deregister upon loading/unloading. There is 
> never a call from the dvb-core to the backend modules. Do I really need 
> an owner field then?

It doesn't have to be a call.  Unless I completely misread the code
your dvb core references struct dvb_adapter in certain cases.  But
struct dvb_adapter is allocated in the actual drivers so these could be
unloaded and give you scrambled memory even when it's still in use.

So you need to acquire a reference on those backends whenever you
touch any object that logically belongs to them.

