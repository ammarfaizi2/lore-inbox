Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWGKWnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWGKWnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWGKWnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:43:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932223AbWGKWnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:43:19 -0400
Date: Tue, 11 Jul 2006 15:39:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>,
       hch@infradead.org, dwmw2@infradead.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
In-Reply-To: <44B41FB1.7050704@zytor.com>
Message-ID: <Pine.LNX.4.64.0607111537080.5623@g5.osdl.org>
References: <20060711160639.GY13938@stusta.de> <1152635323.3373.211.camel@pmac.infradead.org>
 <20060711173301.GA27818@infradead.org> <20060711193423.GA9685@mars.ravnborg.org>
 <20060711194107.GA10733@mars.ravnborg.org> <20060711134106.18f6dd2e.rdunlap@xenotime.net>
 <20060711213733.GB21448@wohnheim.fh-wedel.de> <44B41FB1.7050704@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jul 2006, H. Peter Anvin wrote:
> 
> #1 I doubt the time taken to look at include files that are #ifndef'd in their
> entirety is significant (I think there is special code in gcc to handle this
> case fast.)

Correct. Don't worry about multiple includes.

HOWEVER. If you can avoid the include entirely, that can be an absolutely 
huge timesaver. Much of the compile time is from just parsing the things 
the first time around (rather than parsing it over and over), and if you 
don't strictly need a header, avoiding parsing it in the first place is a 
big big issue.

For example, if a header only needs a structure to be declared because it 
uses a pointer to it, then rather than including the header file that 
declares that structure fully, just doing a

	struct task_struct;

to say that "there is such a thing as a 'struct task_struct'" can be a 
huge time-saver.

Of course, anything that actually needs to look past the pointer will need 
to get the full declaration..

		Linus
