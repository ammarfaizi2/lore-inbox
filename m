Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbULIO4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbULIO4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbULIO4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:56:48 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:52241 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261525AbULIOzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:55:20 -0500
Date: Thu, 9 Dec 2004 14:55:19 +0000
From: John Levon <levon@movementarian.org>
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
Cc: Greg Banks <gnb@sgi.com>, Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041209145519.GA78695@compsoc.man.ac.uk>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041209015024.GG4239@sgi.com> <200412092322.27096.amgta@yacht.ocn.ne.jp> <200412092353.53634.amgta@yacht.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412092353.53634.amgta@yacht.ocn.ne.jp>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CcPhP-00067Q-Ii*GSqR1oYy5v6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 11:53:53PM +0900, Akinobu Mita wrote:

> Or, It may be better to revert the return type of oprofile_arch_init()
> from "void" to "int"  to get the result of initialization.
> Though I don't know when/why its interface was changed. and some
> architectures (ppc, sh64, m32r) remain to have old interfaces in -mm.

I've also lost track of why we don't return -ENODEV from the
arch_init().

We should set -ENODEV after setting ->backtrace as appropriate. Then the
code should do what it used to do:

    138         int err = oprofile_arch_init(&oprofile_ops);
    139
    140         if (err == -ENODEV || timer) {
    141                 timer_init(&oprofile_ops);
    142                 err = 0;
    143         } else if (err) {
    144                 goto out;
    145         }

john
