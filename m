Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbSLEOZj>; Thu, 5 Dec 2002 09:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbSLEOZj>; Thu, 5 Dec 2002 09:25:39 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:40401 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267329AbSLEOZj>;
	Thu, 5 Dec 2002 09:25:39 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15855.25512.31292.187557@harpo.it.uu.se>
Date: Thu, 5 Dec 2002 15:33:12 +0100
To: Shane Helms <shanehelms@eircom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is KERNEL developement finished, yet ???
In-Reply-To: <200212051224.50317.shanehelms@eircom.net>
References: <11E89240C407D311958800A0C9ACF7D1A33CD5@EXCHANGE>
	<200212051224.50317.shanehelms@eircom.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Helms writes:
 > But, if you're implying that we can start once again from bottom, and come up 
 > with something better that unix (which has been opensource, around for long 
 > while, tested and developed by many as well) I _HIGHLY_ doubt, and disagree. 
 >...
 > I doubt there be any such errors (mistakes) if ANY. but then, i'm not a kernel 
 > developer, and new to this whole mailing list !!

Signal delivery on the current stack as opposed to a process-global
or per-signal sigaltstack is broken as hell. It messes up user-space
code that uses customised stack management methods.

sigaction() with SA_ONSTACK is unreliable because in reality applications
have linked-in libraries, and those libraries have no standard way of
knowing whether the main application wants SA_ONSTACK or not.

LD_PRELOAD:ing your own sigaction() is also unreliable, because C libs
tend to have internal calls that bypass the external name and go directly
to the internal __libc_sigaction() or whatever it happens to be called.

/Mikael
