Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTFDOWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTFDOWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:22:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34317 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263315AbTFDOWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:22:36 -0400
Date: Wed, 4 Jun 2003 07:35:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: "P. Benie" <pjb1008@eng.cam.ac.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <20030604065336.A7755@infradead.org>
Message-ID: <Pine.LNX.4.44.0306040732470.13753-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jun 2003, Christoph Hellwig wrote:
> 
> The else should be on the same line as the closing brace, else
> the patch looks fine.

No no no, it's wrong.

If you do something like this, then you also have to teach "select()" 
about this, otherwise you just get busy looping in applications.

In general, we shouldn't do this, unless somebody can show an application 
where it really matters. Taking internal kernel locking into account for 
"blockingness" easily gets quite complicated, and there is seldom any real 
point to it.

Remember: perfect is the enemy of good. I'll happily apply the patch (if 
it also updates the tty poll() functionality), _if_ there is some 
real-world situation where it matters.

		Linus

