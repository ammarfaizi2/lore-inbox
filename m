Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266789AbUG1HLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266789AbUG1HLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266812AbUG1HLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:11:50 -0400
Received: from ozlabs.org ([203.10.76.45]:63881 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266789AbUG1HLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:46 -0400
Date: Wed, 28 Jul 2004 16:51:28 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [0/15] orinoco merge preliminaries
Message-ID: <20040728065128.GC16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41068E4B.2040507@pobox.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 01:18:03PM -0400, Jeff Garzik wrote:
> >I've started to have a look at the patches.  Unfortunately, they're
> >still not really as logically separated as they should be.  Which I
> >guess means I wasn't sufficiently disciplined putting them into CVS in
> >the first place.
> >
> >I've started working on my own series of logical patches, starting
> >with, as you say the "content free" ones first.  Initial set with
> >series file at
> >       http://www.ozlabs.org/people/dgibson/orinoco-patches
> >
> >Nothing there so far that should cause any functional change.
> 
> 
> Feel free to start emailing them, so I can queue them up.
> 
> One email per patch, please.

Ok, patchbombing commences.

Following are 15 patches which make a start on merging the current CVS
orinoco driver into the mainline tree.  This batch of patches is only
preliminaries - patches which cause no behavioural change, but which
should be easy to review and which will reduce meaningless noise in
the later functional patches.

They all represent essentially trivial changes, and with the exception
of the rearrange patch (which is large because it moves big chunks of
code around) they should be obvious.  This batch of patches is
supposed to represent all the trivial, non-behaviour-changing
differences between orinoco CVS and mainline, though the merge is so
large, inevitably I will have missed a few.

Summary of the patches:
	1/15 orinoco-squash-backwards-compat:
		Removes old unnecessary backwards compatibility code
	2/15 orinoco-rearrange:
		Rearrange code so function order matches new versions
	3/15 orinoco-netdev-priv:
		Use netdev_priv() instead of direct dev->priv access
	4/15 orinoco-ALIGN:
		Use standard ALIGN macro instead of local versions
	5/15 orinoco-ARRAY-SIZE:
		Use ARRAY_SIZE macro instead of local version
	6/15 orinoco-spam-stoppers:
		Anti-spam obfuscate email addresses in source
	7/15 orinoco-comments-whitespace-spelling
		Whitespace/spelling/capitalisation updates
	8/15 orinoco-BUG-ON:
		Use BUG_ON() instead of explicit if () BUG() logic
	9/15 orinoco-add-statics:
		Make some functions static that always should have been
	10/15 orinoco-trivial-cleanup:
		Tiny changes than don't belong with anything else
	11/15 orinoco-driver-name-version:
		Reduce duplication of the driver names/version
	12/15 orinoco-uneeded-includes:
		Remove unnecessary #includes
	13/15 orinoco-no-struct-typedef:
		Don't use typedefs on simple structues
	14/15 orinoco-more-hw-data:
		Extra hw related #defines and structures
	15/15 orinoco-update-authorship:
		Update MAINTAINERS, copyright banners, etc.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
