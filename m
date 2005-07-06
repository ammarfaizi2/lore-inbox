Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVGFQnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVGFQnW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVGFQnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:43:06 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:28360 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262230AbVGFMZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:25:50 -0400
Date: Wed, 6 Jul 2005 07:25:13 -0500
From: serge@hallyn.com
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@redhat.com>, Tony Jones <tonyj@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050706122513.GA13520@vino.hallyn.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com> <20050704155321.GA25153@vino.hallyn.com> <20050705060700.GA29650@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705060700.GA29650@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH (greg@kroah.com):
> Nice, glad to see this makes your code smaller and simpler.  Although I
> think it could be made even smaller if you use the default read and
> write file type functions in libfs (look at the debugfs wrappers of them
> for u8, u16, etc, for examples of how to use them.)

Hmm, I looked around at libfs and debugfs yesterday...  it seems that
the simple_attr_read as used by fops_u8 would have been great for
seclvl - except that -1 is a valid input for seclvl  :)

A more specialized per-type API in security/security.c in the line of
debugfs/file.c might be good,simple_attr_read as used by fops_u8 would
have been great for
seclvl - except that -1 is a valid input for seclvl  :)

The general type of API provided by debugfs/file.c might be useful in
security/security.c, though, provided that the securityfs_create_int()
and friends also took a function pointer to an update() or validate()
function.  I'll try to do something like that later today or tomorrow.

thanks,
-serge
