Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbULIBq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbULIBq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbULIBq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:46:26 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:12037 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261430AbULIBqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:46:23 -0500
Date: Thu, 9 Dec 2004 01:46:22 +0000
From: John Levon <levon@movementarian.org>
To: Greg Banks <gnb@sgi.com>
Cc: Philippe Elie <phil.el@wanadoo.fr>, Akinobu Mita <amgta@yacht.ocn.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041209014622.GB48804@compsoc.man.ac.uk>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041208160055.GA82465@compsoc.man.ac.uk> <20041208223156.GB4239@sgi.com> <20041208235623.GA563@zaniah> <20041209003906.GE4239@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209003906.GE4239@sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CcDNu-000JhH-AB*ymXtApMqEbI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 11:39:06AM +1100, Greg Banks wrote:

> But for now I don't see any drama with leaving in the ->setup() and
> ->shutdown() methods when rewriting the ops structure.  Ditto for
> the ->create_files() methods.

Wouldn't this mean that we try to set up the NMI stuff regardless of
forcing the timer ? I can imagine a flaky system where somebody needs to
avoid going near that stuff.

timer_init() making sure to set all fields seems reasonable to me.  Or
oprofile_init() could grab ->backtrace, memset the structure, then
replace ->backtrace...

john
