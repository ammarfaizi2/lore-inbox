Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUCXR1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUCXR1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:27:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:400 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263788AbUCXR1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:27:18 -0500
Date: Wed, 24 Mar 2004 12:24:54 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: davidm@hpl.hp.com
Cc: John Reiser <jreiser@BitWagon.com>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
Message-ID: <20040324172454.GP31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040324002149.GT4677@tpkurt.garloff.de> <16480.55450.730214.175997@napali.hpl.hp.com> <4060E24C.9000507@redhat.com> <16480.59229.808025.231875@napali.hpl.hp.com> <20040324070020.GI31589@devserv.devel.redhat.com> <16481.13780.673796.20976@napali.hpl.hp.com> <20040324072840.GK31589@devserv.devel.redhat.com> <16481.15493.591464.867776@napali.hpl.hp.com> <4061B764.5070008@BitWagon.com> <16481.49534.124281.434663@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16481.49534.124281.434663@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 09:12:30AM -0800, David Mosberger wrote:
>   David> That's why there is mprotect().
> 
>   John> But mprotect() costs enough (hundreds of cycles) to be a
>   John> significant burden in some cases.  Generating code to a stack
>   John> region that is inherently executable is inexpensive (even
>   John> allowing for restrictive alignment and avoiding I/D cache
>   John> conflicts), is thread safe, is async-signal safe, and takes
>   John> less work than other alternatives.  Yes, the "black hats" do
>   John> this; so do the "white hats."  Please do not increase the
>   John> minimum cost for applications that want generate-and-execute
>   John> on the stack at upredictable high frequency.
> 
> Huh?  Only one mprotect() call is needed to make the entire stack
> executable.

Nope.  Think about multithreaded apps.  Furthermore, getting the exact
extents of the particular stack is difficult to find for applications,
but e.g. the threading library has to know such things.

	Jakub
