Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVGLWpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVGLWpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVGLWne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:43:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262305AbVGLWla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:41:30 -0400
Date: Tue, 12 Jul 2005 15:38:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hal Rosenstock <halr@voltaire.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: [PATCH 0/29v2] InfiniBand core update
Message-Id: <20050712153859.7b757c4a.akpm@osdl.org>
In-Reply-To: <1121206549.4382.10.camel@hal.voltaire.com>
References: <1121110249.4389.4984.camel@hal.voltaire.com>
	<20050711170548.31605e23.akpm@osdl.org>
	<1121136330.4389.5093.camel@hal.voltaire.com>
	<20050711201117.72539977.akpm@osdl.org>
	<1121206549.4382.10.camel@hal.voltaire.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hal Rosenstock <halr@voltaire.com> wrote:
>
> On Mon, 2005-07-11 at 23:11, Andrew Morton wrote:
> > Well I was asking.  Do you guys think that this material is appropriate to
> > and safe enough for 2.6.13?
> 
> I used your versions of the patches (Tom's ucm one is needed and you
> added that). I also back ported the trailing whitespace elimination
> changes.
> 
> I just completed a regression test including uCM, CM, RMPP, OpenSM,
> IPoIB and it looks good to me.
> 

OK, well the timing of a merge is mainly up to you guys, especially as the
subsystem is pretty raw and you're the only people who use it ;)

Two things from a quick scan:

a) In many places the patch does

	if (p)
		kfree(p);

   But kfree(0) is permitted.  The cleanup police will be after you at
   some stage - it'd be best to fix those things up immediately.

b) The patch exports a ton of symbols to non-GPL modules:

+EXPORT_SYMBOL(ib_create_ah_from_wc);
+EXPORT_SYMBOL(ib_modify_mad);
+EXPORT_SYMBOL(ib_create_send_mad);
+EXPORT_SYMBOL(ib_free_send_mad);
+EXPORT_SYMBOL(ib_coalesce_recv_mad);
+EXPORT_SYMBOL(ib_sa_service_rec_query);
+EXPORT_SYMBOL(ib_create_cm_id);
+EXPORT_SYMBOL(ib_destroy_cm_id);
+EXPORT_SYMBOL(ib_cm_listen);
+EXPORT_SYMBOL(ib_send_cm_req);
+EXPORT_SYMBOL(ib_send_cm_rep);
+EXPORT_SYMBOL(ib_send_cm_rtu);
+EXPORT_SYMBOL(ib_send_cm_dreq);
+EXPORT_SYMBOL(ib_send_cm_drep);
+EXPORT_SYMBOL(ib_send_cm_rej);
+EXPORT_SYMBOL(ib_send_cm_mra);
+EXPORT_SYMBOL(ib_send_cm_lap);
+EXPORT_SYMBOL(ib_send_cm_apr);
+EXPORT_SYMBOL(ib_send_cm_sidr_req);
+EXPORT_SYMBOL(ib_send_cm_sidr_rep);
+EXPORT_SYMBOL(ib_cm_establish);
+EXPORT_SYMBOL(ib_cm_init_qp_attr);

   Why?
