Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVCKTGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVCKTGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVCKTFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:05:48 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:52130 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261323AbVCKSzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:55:18 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
Date: Fri, 11 Mar 2005 19:54:33 +0100
User-Agent: KMail/1.7.2
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org> <200503101341.37346.rob@landley.net>
In-Reply-To: <200503101341.37346.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111954.33414.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2005 19:41, Rob Landley wrote:
> On Wednesday 09 March 2005 09:15 pm, Jeff Dike wrote:
> > This implements a hardware random number generator for UML which attaches
> > itself to the host's /dev/random.
>
> Direct use of /dev/random always makes me nervous.  I've had a recurring
> problem with /dev/random blocking,
The fd is set in non-blocking mode on opening, so when there is no data UML 
will not block but get -EAGAIN (which is then handled by waiting and 
retrying).
> and generally configure as much as 
> possible to use /dev/urandom instead.  It's really easy for a normal user
> to drain the /dev/random entropy pool on a server (at least one that
> doesn't have a sound card you can tell it to read white noise from).

> cat  /dev/random > /dev/null

> I like /dev/urandom because it'll feed you as much entropy as it's got,
Yes, and entropy will gradually degrade...
> but 
> won't block, and will presumably round-robin insert real entropy in the
> streams that multiple users get from /dev/urandom.  (I realize this may not
> be the best place to get gpg keys from.)

> Admittedly if UML used /dev/urandom instead of /dev/random, it wouldn't
> know how much "real" randomness it was getting and how much synthetic
> randomness, but this makes predicting the numbers it's producing easier

> how?
Don't ask us..., we just recycle the others knowledge... however in short when 
you say that "randomness" (or entropy) is not the maximum, you mean that 
there is some redundancy, i.e. some law to ease predicting subsequent 
numbers. For instance some character is more frequent than another... And 
this is also the same kind of things that is exploited during compression... 
the more compressed are your data, the less entropy they have before 
compression (I'm not an expert of Shannon information entropy theories, 
however, but this is what I grasped).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

