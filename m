Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbUATAyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbUATAyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:54:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:61378 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265445AbUATAxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:53:44 -0500
Date: Mon, 19 Jan 2004 16:53:39 -0800
From: Greg KH <greg@kroah.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobj_to_dev ?
Message-ID: <20040120005338.GA5954@kroah.com>
References: <3FC7B008-487C-11D8-AED9-000A95A0560C@us.ibm.com> <20040117001739.GB3840@kroah.com> <400C3D87.3010502@us.ibm.com> <20040120000405.GA5656@kroah.com> <1DFA0D5A-4ADF-11D8-B557-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1DFA0D5A-4ADF-11D8-B557-000A95A0560C@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 06:25:14PM -0600, Hollis Blanchard wrote:
> 
> On Jan 19, 2004, at 6:04 PM, Greg KH wrote:
> 
> >On Mon, Jan 19, 2004 at 02:26:47PM -0600, Hollis Blanchard wrote:
> >>Greg KH wrote:
> >>>
> >>>How about just adding a find_device() function to the driver core, 
> >>>where
> >>>you pass in a name and a type, so that others can use it?
> >>
> >>Something like this?
> >
> >Very nice, yes.  But I'll rename it to device_find() to keep the
> >namespace sane.  Sound ok?
> 
> Sure. I'm having a problem inside kset_find_obj() when actually using 
> it though, and I'm not sure if it's my fault or not. It seems there are 
> kobjects present for which kobject_name() returns NULL.

Hm, we should probably fix that oops up too.  I'll go do that.

> kset_find_obj:
> 	list_for_each(entry,&kset->list) {
> 		struct kobject * k = to_kobj(entry);
> 		if (!strcmp(kobject_name(k),name)) {
> 			ret = k;
> 			break;
> 		}
> 	}
> 
> where "kset" above is "&my_bus_type.devices". strcmp doesn't like NULL 
> and panics. I've registered 11 devices in my_bus_type, and all of them 
> have names (device_add() makes sure of that).
> 
> Does this sound like my fault?

I don't know.  If you enable debugging for kobjects (in kobject.c) do
you see any kobjects getting added to your bus with no name?

thanks,

greg k-h
