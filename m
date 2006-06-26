Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWFZEUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWFZEUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 00:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWFZEUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 00:20:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46288 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964920AbWFZEUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 00:20:30 -0400
Date: Sun, 25 Jun 2006 21:20:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org
Subject: Re: remove __read_mostly?
In-Reply-To: <1151271890.4940.58.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0606252117440.27464@schroedinger.engr.sgi.com>
References: <20060625115736.d90e1241.akpm@osdl.org>
 <1151271890.4940.58.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006, Arjan van de Ven wrote:

> On Sun, 2006-06-25 at 11:57 -0700, Andrew Morton wrote:
> > I'm thinking we should remove __read_mostly.
> > 
> > Because if we use this everywhere where it's supposed to be used, we end up
> > with .bss and .data 100% populated with write-often variables, packed
> > closely together.  The cachelines will really flying around.
> 
> 
> one thing we could/should do is have a "written during boot only"
> section; which we then can mark read only as well :)

To replicate an IRIX idea:

We could have section with variables that can only be modified by special 
command. F.e.

enable_write_to_most_read_section()
<change variable>
disable_write_to_most_read_section()


This section could be a per cpu section that would be replicated
to all nodes on the system on disable_write_to_most_read_section().
That would mean that critical read only data would be node local.

