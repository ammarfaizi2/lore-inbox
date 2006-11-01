Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946838AbWKAMSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946838AbWKAMSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946843AbWKAMSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:18:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45290 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946838AbWKAMSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:18:06 -0500
Date: Wed, 1 Nov 2006 13:17:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wright <chrisw@sous-sol.org>
Cc: akpm@osdl.org, ak@muc.de, Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: Re: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt kernels
Message-ID: <20061101121753.GA2205@elf.ucw.cz>
References: <20061029024504.760769000@sous-sol.org> <20061029024606.496399000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029024606.496399000@sous-sol.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-10-28 00:00:04, Chris Wright wrote:
> Allow selected bug checks to be skipped by paravirt kernels.  The two most
> important are the F00F workaround (which is either done by the hypervisor,
> or not required), and the 'hlt' instruction check, which can break under
> some hypervisors.

How can hlt check break? It is hlt;hlt;hlt, IIRC, that looks fairly
innocent to me.

> --- linux-2.6-pv.orig/arch/i386/kernel/cpu/intel.c
> +++ linux-2.6-pv/arch/i386/kernel/cpu/intel.c
> @@ -107,7 +107,7 @@ static void __cpuinit init_intel(struct 
>  	 * Note that the workaround only should be initialized once...
>  	 */
>  	c->f00f_bug = 0;
> -	if ( c->x86 == 5 ) {
> +	if (!paravirt_enabled() && c->x86 == 5) {

I'd do x86==5 check first... pentiums are not common any more.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
