Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbTGKVHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbTGKVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:07:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:1802 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S266831AbTGKVGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:06:50 -0400
Date: Fri, 11 Jul 2003 17:21:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Style question: Should one check for NULL pointers? 
In-Reply-To: <200307111932.h6BJWMr5004606@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.44L0.0307111714130.10595-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Horst von Brand wrote:

> My personal paranoia when reading code goes the other way: How can I be
> sure it won´t ever be NULL?  Maybe it can't be now (and to find that out an
> hour grepping around goes by), but the very next patch introduces the
> possibility.  Better have the function do an extra check, or make sure
> somehow the assumption won't _ever_ be violated. But that is a large (huge,
> even) cost, so...

Suppose something does change and your function is passed a NULL pointer 
after all.  What will you do about it then?  Clearly this represents a 
mistake on the part of the caller; are you simply going to return without 
doing anything and hope that nothing else will go wrong?  Or will you 
return an error code and hope that a caller careless enough to pass an 
invalid argument will also be careful enough to check the return code?
Quite a lot of places in the kernel do one of these (usually the first).

Neither of those options is attractive to me.  I would prefer something 
that leaves a clear indication that the problem exists.  A logged error 
message would help; a BUG_ON or segfault would be even better.  This is 
especially true in situations where the function in question is part of a 
relatively small subsystem where you _know_ that a NULL pointer is never 
valid.  (It may occur, but if it does it must represent an error.)

Alan Stern

