Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTDPVyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTDPVyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:54:23 -0400
Received: from rj.SGI.COM ([192.82.208.96]:16014 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263482AbTDPVyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:54:21 -0400
Date: Wed, 16 Apr 2003 15:02:21 -0700
From: richard offer <offer@sgi.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andreas Gruenbacher <ag@bestbits.at>,
       Linus Torvalds <torvalds@transmeta.com>,
       lsm <linux-security-module@wirex.com>, "Ted Ts'o" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>, Stephen Tweedie <sct@redhat.com>
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
Message-ID: <743940000.1050530541@changeling.engr.sgi.com>
In-Reply-To: <1050500841.2682.62.camel@moss-huskers.epoch.ncsc.mil>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
 <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil>
 <385390000.1050425884@changeling.engr.sgi.com>
 <1050500841.2682.62.camel@moss-huskers.epoch.ncsc.mil>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
X-HomePage: http://www.whitequeen.com/users/richard/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





* frm sds@epoch.ncsc.mil "04/16/03 09:47:22 -0400" | sed '1,$s/^/* /'
* 
* Thanks for your comments.  It occurred to me after I sent my initial
* reply that you might be thinking of a scenario where you have two
* different security modules for two different environments, and you
* switch back and forth between them depending on what environment you are
* working in.  

I'm not sure what I was thinking, I think I was thinking about smaller
modules, say capabilities and openwall or alternatively a reluctance to
remove things that "belong" to other people... 

If you attach a capability attribibute to a file under the capability
module, what happens when you use SELinux ? Under your scheme, you'd remove
the capability and write a combined attribute that included SELinux and and
if needed the capability. 

Under my scheme, the capability attribute would be left alone, SELinux
would add its own, and then as its the primary module would decide whether
to use the existing capability attribute or its own "combined" attribute.
The important thing is that if you ever decide to reboot a pure capability
system that you don't have to refigure all your attributes (although you
could/should).

Extended attributes are still relatively rare that people forget to record
them when replacing a file (I do that all the time under Trusted Irix),
under your scheme they would have to record every attribute on the system
before loading a module if they every wanted to return to its prior state.
If you forgot to do it just once the consequences could be nasty.

With separate attributes, its easy to write a tool to "de-dte" a system by
removing all the DTE attributes and know that nothing else will change. But
that would be a direct user action, not an unforseen side effect.

I can see your reasons for the single attribute (known quantity for
production systems), but think its better at this stage to experiment with
multiple attributes and see how people use them before forcing everyone to
a single standard. It allows small steps rather than force everyone to make
a single large one.

* Stephen Smalley <sds@epoch.ncsc.mil>
* National Security Agency

richard.

-- 
-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
_______________________________________________________________________

