Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWHUAOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWHUAOa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHUAOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:14:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52452 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932227AbWHUAO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:14:29 -0400
Date: Sun, 20 Aug 2006 21:16:29 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce CONFIG_BINFMT_ELF_AOUT
Message-ID: <20060821001628.GC2861@dmt>
References: <20060819232556.GA16617@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819232556.GA16617@openwall.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 03:25:56AM +0400, Solar Designer wrote:
> Willy,
> 
> I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> into 2.4.34-pre.  (2.6 kernels could benefit from the same change, too.)
> 
> The patch adds a new compile-time option to control the support for
> "ELF binaries with a.out format interpreters or a.out libraries".
> Without this patch, such support is enabled on every system that enables
> the support for ELF binaries - although 99% (100%?) of systems don't
> need this hybrid functionality.  Moreover, this functionality poses a
> security risk - as proven in practice:
> 
> 	http://www.isec.pl/vulnerabilities/isec-0021-uselib.txt
> 
> This uselib() vulnerability did not affect default kernel builds with
> the -ow patch specifically due to separation of the unneeded/risky code
> into CONFIG_BINFMT_ELF_AOUT and having this option disabled by default.
> (Yes, this change in -ow patches pre-dates the discovery of the uselib()
> vulnerability.)
> 
> The patch also changes CONFIG_BINFMT_AOUT to be disabled by default on
> archs that had it default to enabled.  The a.out support is similarly
> risky and not audited/hardened with the same scrutiny that the ELF
> support has received.

I dislike this change. "Make a.out configurable" is a:

- "Hide the problems" trick, making it less likely for any potential bug to
be really fixed.

- Change not suitable for v2.4 inclusion: its not fixing _any_ serious problem.

We had this discussion before, didnt we?
