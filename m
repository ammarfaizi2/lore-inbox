Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTENTte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbTENTte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:49:34 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:41693 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262714AbTENTtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:49:33 -0400
Date: Wed, 14 May 2003 21:03:07 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jonathan Bastien-Filiatrault <Intuxicated_kdev@yahoo.ca>
Cc: mec@shout.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.69 Change to i386 Makefile to distinguish athlons.
Message-ID: <20030514200307.GA31711@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jonathan Bastien-Filiatrault <Intuxicated_kdev@yahoo.ca>,
	mec@shout.net, Linux Kernel <linux-kernel@vger.kernel.org>
References: <3EC29191.5030700@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC29191.5030700@yahoo.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 02:57:21PM -0400, Jonathan Bastien-Filiatrault wrote:
 > It should succesfully set -march=athlon-<type> according to uname -p.

"Look, a new way to do something pointless!"

This is just as broken as the previous patch that was posted.
_READ_ the gcc sources. See what those flags do.

The only differences are the enabling of PTA_SSE on the later models.
"Cool, I have SSE, I want optimised SSE routines". Bad luck.
This flag makes damn all difference on integer code. FP code is not
allowed in kernel space, and in the few exceptions where we do use it
(see the memcpy routines), it's guarded by explicit kernel_fpu_begin()
kernel_fpu_end() pairs, something that gcc wouldn't be able to add for us.

		Dave

