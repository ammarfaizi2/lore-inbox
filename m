Return-Path: <linux-kernel-owner+w=401wt.eu-S1751010AbXADTYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbXADTYJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbXADTYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:24:09 -0500
Received: from aun.it.uu.se ([130.238.12.36]:58956 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbXADTYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:24:08 -0500
Date: Thu, 4 Jan 2007 20:23:53 +0100 (MET)
Message-Id: <200701041923.l04JNrTi026871@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: akpm@osdl.org, sandeen@redhat.com
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops return values
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 11:51:10 -0600, Eric Sandeen wrote:
>Also - is it ok to alias a function with one signature to a function with
>another signature?

NO!

Specific cases of type mismatches may work on many machines
(say different pointer types as long as they aren't accessed),
but in general this won't work since types affect calling conventions.
Abusing aliasing like this is exactly like casting a function
pointer to a different type that it actually has, and then invoking
it at that type: all bets are off.

Don't do this. Ever.

/Mikael
