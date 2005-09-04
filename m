Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVIEQdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVIEQdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIEQdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:33:18 -0400
Received: from [81.2.110.250] ([81.2.110.250]:65173 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932335AbVIEQdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:33:16 -0400
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Phillips <phillips@istop.com>, Joel.Becker@oracle.com,
       linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20050903214653.1b8a8cb7.akpm@osdl.org>
References: <20050901104620.GA22482@redhat.com>
	 <20050903183241.1acca6c9.akpm@osdl.org>
	 <20050904030640.GL8684@ca-server1.us.oracle.com>
	 <200509040022.37102.phillips@istop.com>
	 <20050903214653.1b8a8cb7.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Sep 2005 09:37:15 +0100
Message-Id: <1125823035.23858.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-03 at 21:46 -0700, Andrew Morton wrote:
> Actually I think it's rather sick.  Taking O_NONBLOCK and making it a
> lock-manager trylock because they're kinda-sorta-similar-sounding?  Spare
> me.  O_NONBLOCK means "open this file in nonblocking mode", not "attempt to
> acquire a clustered filesystem lock".  Not even close.

The semantics of O_NONBLOCK on many other devices are "trylock"
semantics. OSS audio has those semantics for example, as do regular
files in the presence of SYS5 mandatory locks. While the latter is "try
lock , do operation and then drop lock" the drivers using O_NDELAY are
very definitely providing trylock semantics.

I am curious why a lock manager uses open to implement its locking
semantics rather than using the locking API (POSIX locks etc) however.

Alan

