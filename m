Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758681AbWK1O7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758681AbWK1O7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 09:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758682AbWK1O7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 09:59:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1234 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758681AbWK1O7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 09:59:48 -0500
Date: Tue, 28 Nov 2006 09:59:13 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] work around gcc4 issue with -Os in Dwarf2 stack unwind code
Message-ID: <20061128145913.GE6570@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <456C51D8.76E4.0078.0@novell.com> <20061128143214.GD6570@devserv.devel.redhat.com> <456C5A3F.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456C5A3F.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 02:48:15PM +0000, Jan Beulich wrote:
> I disagree - the standard says there's a sequence point at a function
> call after evaluating all function arguments. To me this means that any

That's true, that sequence point makes sure e.g. all side effects such as
pre-{dec,inc}rement on the arguments happen before the call.
But as I said, no sequence point demands any particular ordering of
evaluation of the LHS and RHS of +=.

> (parts of an) expression the function call is contained in must be
> evaluated after the function call. Otherwise it would be illegal to e.g.
> modify a variable in both operands of && or ||.

That's different, there is a sequence point at the end of the first operand
of &&, ||, ?: and , operators (second bullet in ISO C99 Annex C).

	Jakub
