Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269215AbTCBBPy>; Sat, 1 Mar 2003 20:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269216AbTCBBPy>; Sat, 1 Mar 2003 20:15:54 -0500
Received: from kerberos.ncsl.nist.gov ([129.6.57.216]:6272 "EHLO
	kerberos.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S269215AbTCBBPx>; Sat, 1 Mar 2003 20:15:53 -0500
Date: Sat, 1 Mar 2003 20:26:17 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030301202617.A18142@kerberos.ncsl.nist.gov>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303020011.QAA13450@adam.yggdrasil.com>; from adam@yggdrasil.com on Sat, Mar 01, 2003 at 04:11:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 04:11:55PM -0800, Adam J. Richter wrote:
> 	Aegis, BitKeeper and probably other configuration management
> tools that use sccs or rcs basically share a common type of lower
> layer.  This lower layer converts a file-based revision control system
> such as sccs to an "uber-cvs", as someone called it in a slashdot
> discussion, that can:
> 
> 	    1. process a transaction against a group of files atomically,
> 	    2. associate a comment with such a transaction rather than
> 	       with just one file,
> 	    3. represent symbolic links, file protections
>             4. represent file renames (and perhaps copies?)

5. Represent merges.  That's what is making cvs branches unusable.

Frankly, if you want all of that you'd better design a repository
format that is actually adapted to it.  The RCS format is not very
good, the SCCS weave is a little better but not by much (it reminds me
of Hurd, looks cool but slow by design).  Larry did quite a feat
turning it into a distributed DAG of versions but I'm not convinced it
was that smart, technically.  In particular, everthing suddendly looks
much nicer when you have one file per DAG node plus a cache zone for
full versions.

But anyway, what made[1] Bitkeeper suck less is the real DAG
structure.  Neither arch nor subversion seem to have understood that
and, as a result, don't and won't provide the same level of semantics.
Zero hope for Linus to use them, ever.  They're needed for any
decently distributed development process.

Hell, arch is still at the update-before-commit level.  I'd have hoped
PRCS would have cured that particular sickness in SCM design ages ago.

Atomicity, symbolic links, file renames, splits (copy) and merges (the
different files suddendly ending up being the same one) are somewhat
important, but not the interesting part.  A good distributed DAG
structure and a quality 3-point version "merge" is what you actually
need to build bk-level SCMs.

  OG.

[1] 2.1.6-pre5, I don't know about current versions
