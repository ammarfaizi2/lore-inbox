Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVC2OV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVC2OV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 09:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVC2OV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 09:21:57 -0500
Received: from nevyn.them.org ([66.93.172.17]:12977 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262295AbVC2OV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 09:21:56 -0500
Date: Tue, 29 Mar 2005 09:22:49 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a check after use)
Message-ID: <20050329142248.GA32455@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jean Delvare <khali@linux-fr.org>, bunk@stusta.de,
	linux-kernel@vger.kernel.org
References: <20050327205014.GD4285@stusta.de> <20050327232158.46146243.khali@linux-fr.org> <20050328222348.4c05e85c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328222348.4c05e85c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 10:23:48PM -0800, Andrew Morton wrote:
> >  > -	int old=card->amplifier;
> >  > +	int old;
> >  >  	if(!card)
> >  >  	{
> >  >  		CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO 
> >  >  			"cs46xx: amp_hercules() called before initialized.\n"));
> >  >  		return;
> >  >  	}
> >  > +	old = card->amplifier;

> No, there is a third case: the pointer can be NULL, but the compiler
> happened to move the dereference down to after the check.
> 
> If the optimiser is later changed, or if someone tries to compile the code
> with -O0, it will oops.

The thing GCC is most likely to do with this code is discard the NULL
check entirely and leave only the oops; the "if (!card)" can not be
reached without passing through "card->amplifier", and a pointer which
is dereferenced can not be NULL in a valid program.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
