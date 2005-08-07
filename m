Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbVHGLXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbVHGLXe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 07:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbVHGLXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 07:23:34 -0400
Received: from [81.2.110.250] ([81.2.110.250]:59792 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751568AbVHGLXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 07:23:33 -0400
Subject: Re: overcommit verses MAP_NORESERVE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas Miell <nmiell@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1123386755.26540.9.camel@localhost.localdomain>
References: <1123386755.26540.9.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 07 Aug 2005 12:49:41 +0100
Message-Id: <1123415381.9464.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-08-06 at 20:52 -0700, Nicholas Miell wrote:
> Why does overcommit in mode 2 (OVERCOMMIT_NEVER) explicitly force
> MAP_NORESERVE mappings to reserve memory?
> 
> My understanding is that MAP_NORESERVE is a way for apps to state that
> they are aware that the memory allocated may not exist and that they
> might get a SIGSEGV and that's OK with them.

Because a MAP_NORESERVE space that is filled with pages might cause
insufficient memory to be left available for another object that is not
MAP_NORESERVE.

You are right it could be improved but that would require someone
writing code that forcibly reclaimed MAP_NORESERVE objects when we were
close to out of memory.  At the moment nobody has done this, but nothing
is stopping someone having a go.

