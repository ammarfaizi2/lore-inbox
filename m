Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVAEBJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVAEBJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVAEBJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:09:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16823 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262180AbVAEBGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:06:38 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1104865198.8346.8.camel@krustophenia.net>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>  <87u0pxhvn0.fsf@sulphur.joq.us>
	 <1104865198.8346.8.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104878646.17166.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 00:01:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 18:59, Lee Revell wrote:
> We could do it the was OSX (our real competition) does if that would
> make people happy.  They just let any user run RT tasks.  Oh wait, but
> that's a "broken design", everyone knows that OSX is a joke, no one
> would use *that* OS to mix a CD or score a movie.  :-)

You can do that already, just make everyone root

The problem with uid/gid based hacks is that they get really ugly to
administer really fast. Especially once you have users who need realtime
and hugetlb, and users who need one only.

It would be far cleaner to split CAP_SYS_NICE capability down - which
should cover the real time OS functions nicely. Right now it gives a few
too many rights but that could be fixed easily.

