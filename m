Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263136AbVCKDY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbVCKDY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVCKDY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:24:57 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63627
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263136AbVCKDUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:20:19 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
Date: Thu, 10 Mar 2005 13:41:37 -0500
User-Agent: KMail/1.6.2
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
In-Reply-To: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503101341.37346.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 09:15 pm, Jeff Dike wrote:
> This implements a hardware random number generator for UML which attaches
> itself to the host's /dev/random.

Direct use of /dev/random always makes me nervous.  I've had a recurring 
problem with /dev/random blocking, and generally configure as much as 
possible to use /dev/urandom instead.  It's really easy for a normal user to 
drain the /dev/random entropy pool on a server (at least one that doesn't 
have a sound card you can tell it to read white noise from).  cat /dev/random 
> /dev/null

I like /dev/urandom because it'll feed you as much entropy as it's got, but 
won't block, and will presumably round-robin insert real entropy in the 
streams that multiple users get from /dev/urandom.  (I realize this may not 
be the best place to get gpg keys from.)

I'm just thinking about those UML hosting farms, with several UML instances 
per machine, on machines which haven't got a keyboard attached constantly 
feeding entropy into the pool.  If just ONE of them is serving ssl 
connections from its own /dev/urandom, that would drain the /dev/random 
entropy pool on the host machine almost immediately...

Admittedly if UML used /dev/urandom instead of /dev/random, it wouldn't know 
how much "real" randomness it was getting and how much synthetic randomness, 
but this makes predicting the numbers it's producing easier how?

Rob
