Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTEMTnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTEMTnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:43:51 -0400
Received: from fmr04.intel.com ([143.183.121.6]:50148 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262356AbTEMTnu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:43:50 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCB064D@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Timothy Miller'" <miller@techsource.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: A way to shrink process impact on kernel memory usage?
Date: Tue, 13 May 2003 12:56:17 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Timothy Miller [mailto:miller@techsource.com]
> Perez-Gonzalez, Inaky wrote:
> 
> If you have some data which is common to a group of threads/processes,
> it could be stored in one (or more--redundantly) of the process stacks.
>   If the refcount is not zero and the process stack holding the data is
> to die, the data can be moved to another stack or otherwise stored
> somewhere else.

I don't think you need that redundancy - at the end of the day, it
is much simpler to just have the common task struct (could we say,
process?) with the shared stuff - replication is nice, but not in
this area.

> > Not really - the more bloated, the more cache misses you will have.
> > There are a lot of fields that don't use all the bits and a lot
> > of Booleans; it'd make sense to collapse all those into a single
> > word if possible.
> 
> Most assuredly.  Why are they not already? :)

Beats me ... maybe there are performance concerns I am not aware
of, or simply, it has not been tackled. This is something I have
on my list of "would be interesting to work on".

> > To solve that, you put the structures on the top of the area instead
> > of at the beginning. That way you are sure the stack cannot overflow
> > over your (very delicate) data structures, and makes it easier to add
> > an overflow guard page (as the stack end is at the beginning of a
> > page).
> 
> I believe I mentioned that idea.  Either the stack and data grow in
> opposite directions, with obvious advantages and risks, or the data is
> at the top of the area but therefore not growable.

Kill me ... my apologies; sometimes it seems that I don't master 
reading as much as I thought :]


Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
