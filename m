Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270409AbTGMV1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270411AbTGMV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:27:18 -0400
Received: from netrider.rowland.org ([192.131.102.5]:12817 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S270409AbTGMV1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:27:17 -0400
Date: Sun, 13 Jul 2003 17:42:03 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Style question: Should one check for NULL pointers? 
In-Reply-To: <200307121840.h6CIeKIj004212@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.44L0.0307131738230.8445-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Horst von Brand wrote:

> Alan Stern <stern@rowland.harvard.edu> said:
> 
> [...]
> 
> > But if you look very far through the kernel sources you will see many 
> > occurrences of code similar to this:
> > 
> > 	static void release(struct xxx *ptr)
> > 	{
> > 		if (!ptr)
> > 			return;
> > 	...
> > 
> > I can't see any reason for keeping something like that.
> 
> Just like free(3)

NO!  Not just like free().  The documentation for free() explicitly states 
that NULL pointers are valid input and result in no action.  A 
release()-type function, by contrast, is called back from core system code 
that guarantees it will always pass a pointer to the currently-registered 
owner of the corresponding resource.  If the owner were NULL, the 
release() function wouldn't have been called in the first place.

Alan Stern

