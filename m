Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbUKDBqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUKDBqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUKDBqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:46:51 -0500
Received: from ozlabs.org ([203.10.76.45]:46804 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262026AbUKDBqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:46:49 -0500
Date: Thu, 4 Nov 2004 11:36:42 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Roskin <proski@gnu.org>, orinoco-deve@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Another trivial orinoco update
Message-ID: <20041104003642.GA10969@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	Pavel Roskin <proski@gnu.org>, orinoco-deve@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20041103034433.GB5441@zax> <20041103211738.GA14377@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103211738.GA14377@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 10:17:38PM +0100, Francois Romieu wrote:
> David Gibson <hermes@gibson.dropbear.id.au> :
> [...]
> > This patch alters the convention with which orinoco_lock() is invoked
> > in the orinoco driver.  This should cause no behavioural change, but
> > reduces meaningless diffs between the mainline and CVS version of the
> > driver.  Another small step towards a merge.
> 
> Afaics orinico_lock returns a nice status code. Let alone the merge
> argument (which could be solved in the CVS tree as well), is there a
> technical reason for this patch ?

orinoco_lock() only ever returns either 0 or -EBUSY, so it's
essentially boolean.  There's no reason to expect it would ever return
anything else.  Using it in if statements directly removes a few lines
of code, removes the need for a few extra 'err' variables, and makes
things slightly neater in the case where just propagating the -EBUSY
up isn't the right thing to do.  It's no big deal, but we did make
this change in CVS for a reason.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
