Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUCIAXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUCIAXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:23:41 -0500
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:9156 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S261411AbUCIAXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:23:39 -0500
Date: Mon, 8 Mar 2004 15:23:44 -0900 (AKST)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] fix BSD accounting (w/ long-term perspective ;-)
In-Reply-To: <Pine.LNX.4.53.0403082241200.16420@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.58.0403081443450.5917@bifrost.nevaeh-linux.org>
References: <Pine.LNX.4.53.0403082241200.16420@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Tim Schmielau wrote:

> Comments?

The glue for the GNU accounting tools are already on the way, should this be
the patch accepted for 2.6.  If you would, please provide a similar patch
against 2.4 (or I'll do it, which ever is more convenient).  Great job on your
patch, BTW, I should have snarfed those padding bytes myself, but I wasn't
giving as much thought as you did to backwards compatibility.

> Any other suggestions for incompatible changes to struct acct in 2.7?

Taking a note from the BSD camp, instead of fixing the field size in acct.h
why not cast ac_uid/ac_gid as uid_t/gid_t and let the kernel determine the
size to log in 2.7 onwards?  Yes, this will break binary compatibility for
those upgrading older systems with a new stable series kernel.  However, this
would obviate the need in the future to provide a migration path.  Outside of
a recompile it would be transparent to the userland tools.

For fields working within a well-defined range I don't think we should be
second-guessing the kernel, and just use what the kernel dictates.  Not doing
so means we are acknowledging that we don't care about logging incorrect data.

Being the whiny little bitch that I am I'm going to repeat my mantra:  we
should not be in the business of logging bad data, regardless of how rare we
think we might actually do it.

Besides which, with your great idea of putting a version field in the struct
we can now put some intelligence into the GNU utils to read the different
versions of the records in the same file.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
