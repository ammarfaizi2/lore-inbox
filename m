Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTJSTSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTJSTSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:18:12 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:18620 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262061AbTJSTSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:18:09 -0400
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot
References: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
	<20031018161439.484915f8.akpm@osdl.org>
	<87d6cuozm7.fsf@love-shack.home.digitalvampire.org>
	<20031018172140.4968e273.akpm@osdl.org>
	<878yniowgn.fsf@love-shack.home.digitalvampire.org>
	<Pine.LNX.4.56.0310190349090.7420@jju_lnx.backbone.dif.dk>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: 19 Oct 2003 12:17:23 -0700
In-Reply-To: <Pine.LNX.4.56.0310190349090.7420@jju_lnx.backbone.dif.dk>
Message-ID: <874qy5ox4s.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jesper Juhl <juhl-lkml@dif.dk> writes:

    > On Sun, 18 Oct 2003, Roland Dreier wrote:
    > 
    > > -	if (in_atomic() || irqs_disabled()) {
    > > +	/* Don't print warnings until system_running is set.  This avoids
    > > +	   spurious warnings during boot before local_irq_enable() and
    > > +	   init_idle(). */
    > > +	if (system_running && (in_atomic() || irqs_disabled())) {
    > 
    > Wouldn't this :
    > 
    > if ((in_atomic() || irqs_disabled()) && system_running)
    > 
    > be slightly more efficient?   The reason I say that is that I would assume
    > that the chance of (in_atomic() || irqs_disabled()) being false is greater
    > than the chance of !system_running - if that is so, then reordering the if
    > will allow it to break out early more often...

Yes, I think you're right about the efficiency.  However, I didn't
think this was a performance-critical code path (especially since it
is only turned on by a debugging config option), and the way I wrote
it matched the way I was thinking about the test ("If the system is
running, then check if we're in atomic or have irqs disabled").
But I don't think it matters much either way.

Thanks,
  Roland
