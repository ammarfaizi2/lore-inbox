Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVC3S7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVC3S7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVC3S5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:57:23 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:56334 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262397AbVC3Sze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:55:34 -0500
Date: Wed, 30 Mar 2005 20:55:31 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Do not misuse Coverity please
Message-ID: <20050330185531.GA6210@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <OofSaT76.1112169183.7124470.khali@localhost> <d2er4p$qp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2er4p$qp$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 10:29:43AM -0800, Shankar Unni wrote:
> Jean Delvare wrote:
> 
> >    v = p->field;
> >    if (!p) return;
> >
> >can be seen as equivalent to
> >
> >    if (!p) return;
> >    v = p->field;
> 
> Heck, no.
> 
> You're missing the side-effect of a null pointer dereference crash (for 
> p->field) (even though v is unused before the return). The optimizer is 
> not allowed to make exceptions go away as a result of the hoisting.

Actually it is.  Dereferencing a null pointer is either undefined or
implementation-dependant in the standard (don't remember which), and
as such the compiler can do whatever it wants, be it starting nethack
or not doing the dereference in the first place.

The principle of least surprise makes doing such an "optimisation" not
so smart in practice.  A compiler capable of detecting that situation
would be better off spitting a warning in red blinking letter.

  OG.

