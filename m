Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265995AbUA1SLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUA1SLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:11:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:46561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265995AbUA1SKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:10:09 -0500
Date: Wed, 28 Jan 2004 10:10:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@osdl.org>,
       thockin@sun.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: NGROUPS 2.6.2rc2
In-Reply-To: <Pine.LNX.4.44.0401281757190.6213-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0401281007420.27790@home.osdl.org>
References: <Pine.LNX.4.44.0401281757190.6213-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Hugh Dickins wrote:
> 
> Sorry, I should have looked further.  info->ngroups is an "int", so
> if this check is needed, a check for negativity (or unsigned cast)
> would also be needed.

Nope - there's an implied cast by virtue of the right side being unsigned 
in the comparison already.

Although I do believe that it would be better written as

	#define MAXGROUPS (1000) /* Arbitrary, but we have to limit it somehere */

	if ((unsigned) info->ngroups > MAXGROUPS)
		return -ETOOEFFINGLARGE;

as I absolutely _despise_ code that tries to be too generic. 

What is it with CS classes that have removed "common sense" from the 
equation?

		Linus
