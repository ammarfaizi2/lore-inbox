Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267283AbSLKUTm>; Wed, 11 Dec 2002 15:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbSLKUTm>; Wed, 11 Dec 2002 15:19:42 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:16138 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267283AbSLKUTl>; Wed, 11 Dec 2002 15:19:41 -0500
Date: Wed, 11 Dec 2002 20:27:27 +0000
From: John Levon <levon@movementarian.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Notifier for significant events on i386
Message-ID: <20021211202727.GF20735@compsoc.man.ac.uk>
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net> <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com> <20021211171337.A17600@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211171337.A17600@in.ibm.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18MDS4-000Fc2-00*QxgaZiHgpu.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 05:13:37PM +0530, Vamsi Krishna S . wrote:

> Unless I am missing something, notifiers have always been racy. 
> No amount of locking you do in individual modules to prevent
> races will help as the notifier chain is walked inside 
> notifier_call_chain() in kernel/sys.c. One would need to
> add some form of locking there (*) so that users of notifier
> chains need not worry about races/locking at all.

There are notifiers being used that sleep inside the called notifiers.

You could easily make a __notifier_call_chain that is lockless and
another one that readlocks the notifier_lock ...

regards
john
-- 
"Anyone who says you can have a lot of widely dispersed people hack away on
 a complicated piece of code and avoid total anarchy has never managed a 
 software project."
	- Andy Tanenbaum
