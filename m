Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTFOP2F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFOP2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:28:05 -0400
Received: from ns.suse.de ([213.95.15.193]:45580 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262298AbTFOP2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:28:03 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a  misalignment
References: <1055687753.10803.28.camel@mulgrave.suse.lists.linux.kernel>
	<20030615.073503.112613460.davem@redhat.com.suse.lists.linux.kernel>
	<1055690231.10803.54.camel@mulgrave.suse.lists.linux.kernel>
	<20030615.082355.08334189.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Jun 2003 17:41:53 +0200
In-Reply-To: <20030615.082355.08334189.davem@redhat.com.suse.lists.linux.kernel>
Message-ID: <p73n0gj4abi.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: James Bottomley <James.Bottomley@SteelEye.com>
>    Date: 15 Jun 2003 10:17:10 -0500
>    
>    It's not necessary and would, indeed, be detrimental to operation since
>    we'd generate alignment traps on almost every encapsulated protocol (at
>    several hundred instructions per trap).  If we do this, our network
>    performance will tank.
> 
> It doesn't happen for all the normal cases, but it does for
> things like IP in appletalk and stuff like that.

It can be remotely triggered in ordinary TCP. Just add an odd number of nops 
before a TCP timestamp to misalign it.

In short any linux parisc64 box on the net is very likely remotely 
panicable.

-Andi
