Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTIWVfk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTIWVfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:35:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22444 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263441AbTIWVfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:35:36 -0400
Date: Tue, 23 Sep 2003 22:35:33 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Deepak Saxena <dsaxena@mvista.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br
Subject: Re: [PATCH] Fix %x parsing in vsscanf()
Message-ID: <20030923213533.GN7665@parcelfarce.linux.theplanet.co.uk>
References: <20030923212207.GA25234@xanadu.az.mvista.com> <Pine.LNX.4.44.0309231421450.24527-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309231421450.24527-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 02:28:12PM -0700, Linus Torvalds wrote:
> 
> On Tue, 23 Sep 2003, Deepak Saxena wrote:
> > 
> > Another option is to put the check in simple_strtoul() and
> > simple_strtoull() if that is preferred. I like this better b/c
> > we only have the check once.
> 
> I'd much rather fix strtoul[l](). In fact, strtoul[l]()  _already_ accepts
> the "0x" prefix - but it only does so if the "base" parameter is 0.
> 
> Fixing strtoul[l] should fix vsscanf() automatically, no? So I don't see 
> the "have the check only once" argument.

C99 on behaviour of %x:

"Matches an optionally signed hexadecimal integer, whose format is the same as
expected for the subject sequence of the strtoul function with the value 16
for the base argument."

IOW, strtoul() is definitely the right place to fix that.
