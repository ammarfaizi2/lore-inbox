Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269842AbUH0ANe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269842AbUH0ANe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269829AbUH0AIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:08:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36343 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269823AbUH0AIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:08:05 -0400
Date: Thu, 26 Aug 2004 11:06:38 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: anton@samba.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 PPC64:  Another log buffer length patch.
Message-ID: <20040826160638.GS14002@austin.ibm.com>
References: <20040825200138.GN14002@austin.ibm.com> <16685.18011.723499.446490@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16685.18011.723499.446490@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:09:31PM +1000, Paul Mackerras was heard to remark:
> 
> Linas,
> 
> > ===== arch/ppc64/kernel/ras.c 1.15 vs edited =====
> > --- 1.15/arch/ppc64/kernel/ras.c	Mon Aug  2 03:00:41 2004
> > +++ edited/arch/ppc64/kernel/ras.c	Wed Aug 25 14:46:33 2004
> > @@ -108,6 +108,7 @@
> >
> >  	ras_get_sensor_state_token = rtas_token("get-sensor-state");
> >  	ras_check_exception_token = rtas_token("check-exception");
> > +	rtas_get_error_log_max();
> 
> Why do we do this call, given that we don't use the result?  Is there
> something time-critical about some future call, such that we want to
> have fetched the value at this point?  If there is, it needs a comment
> here, if not, let's remove this call.

Clearly, I'm being too clever, and too conservative, belt-n-suspenders.  
I was actually expecting that there might be objections, cause the usage
isn't 'typical' :)

The call sets a global var.  I figured that it would be best to just go 
ahead and initialize it early, rather than hoping it all works at our
moment of 'dire need'.   Removing this call shouldn't affect operation,
except during some bizarro failure situation which can only be imagined
after some creative thinking.

--linas


