Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161597AbWAMAXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161597AbWAMAXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161601AbWAMAXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:23:46 -0500
Received: from [198.99.130.12] ([198.99.130.12]:902 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161597AbWAMAXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:23:45 -0500
Date: Thu, 12 Jan 2006 20:15:32 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: fix-processing-of-obsolete-style-setup-options breaks UML arg parsing
Message-ID: <20060113011532.GA2663@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has a bunch of parameters styled on the hd<n>= and ide<n>=
parameters which depend on matching a prefix of the command-line
argument.  This patch explicitly removes this prefix matching.

I know that this has "obsolete" written all over it, but I don't see
any more modern replacement which allows prefix matching.
module_param seems to be the more modern thing, but AFAICS, it is
matching entire command-line arguments.  Strangely, it will match when
the command-line argument is a prefix of the in-kernel parameter
string, which seems exactly backwards.

The hd<n>= and ide<n>= switches are still present, in ide_setup, using
the old mechanism, and they now seem to be broken as well.

				Jeff
