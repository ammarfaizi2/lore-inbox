Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTEVBIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 21:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTEVBIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 21:08:42 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:5076 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S262430AbTEVBIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 21:08:42 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Nikita Danilov <Nikita@Namesys.COM>,
       Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: recursive spinlocks. Shoot.
Date: Thu, 22 May 2003 03:21:52 +0200
User-Agent: KMail/1.5.1
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
References: <200305181724.h4IHOHU24241@oboe.it.uc3m.es> <3EC8B1FC.9080106@aitel.hist.no> <16072.49680.630299.103453@laputa.namesys.com>
In-Reply-To: <16072.49680.630299.103453@laputa.namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305220321.52509.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 May 2003 13:37, Nikita Danilov wrote:
> There, however, are cases when recursive locking is needed. Take, for
> example, top-to-bottom insertion into balanced tree with per-node
> locking. Once modifications are done at the "leaf" level, parents should
> be locked and modified, but one cannot tell in advance whether different
> leaves have the same or different parents. Simplest (and, sometimes, the
> only) solution here is to lock parents of all children in turn, even if
> this may lock the same parent node several times---recursively.

Having locked the parent of one child you then check whether the parent of the 
second child is in fact the same, in which case you already hold the lock and 
must remember to unlock it only once, otherwise lock the second parent.  Do 
you see a hole in that?

Regards,

Daniel
