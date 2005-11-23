Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbVKWKmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbVKWKmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 05:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbVKWKmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 05:42:53 -0500
Received: from [81.2.110.250] ([81.2.110.250]:21377 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030391AbVKWKmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 05:42:53 -0500
Subject: RE: termios VMIN and VTIME behavior
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Voytovich <mike@zermattsystems.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <64F9B87B6B770947A9F8391472E0321603A075B1@ehost011-8.exch011.intermedia.net>
References: <64F9B87B6B770947A9F8391472E0321603A075B1@ehost011-8.exch011.intermedia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 11:15:27 +0000
Message-Id: <1132744527.7268.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 20:32 -0800, Mike Voytovich wrote:
> Please disregard - the user app was reading less than VMIN in the read()
> call, so I suppose the current behavior in that case would be correct
> (returning immediately with the number of bytes passed into read()
> rather than waiting for VMIN or VTIME to be met before returning).
> 
> It doesn't appear that the behavior in this case is explicitly defined
> by POSIX, but it seems like a reasonable thing to do.

Its pretty well defined. It was designed to optimise block serial
operations (uucp and the like)

	VMIN	-	number of bytes you expect this packet
	VTIME   -	when to give up waiting

The form 0, VTIME also being used to do polling on old SYSV that lacked
select/poll

