Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTELWB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbTELWBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:01:55 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:4563 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262834AbTELWAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:00:34 -0400
Date: Mon, 12 May 2003 15:13:12 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPPE in kernel?
Message-ID: <20030512151312.C30310@google.com>
References: <20030512045929.C29781@google.com> <16063.38221.73659.403481@argo.ozlabs.ibm.com> <20030512060210.C29881@google.com> <16063.40072.101121.244892@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16063.40072.101121.244892@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, May 12, 2003 at 11:07:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 11:07:20PM +1000, Paul Mackerras wrote:
> Frank Cusack writes:
> 
> > I have the compressor return a 3-valued return code (<0, 0, >0) instead of
> > two-valued (>0, other).  A negative value tells ppp_generic to drop the
> > packet.  0 means the same as it does now--the compressor failed for some
> > reason.  (All current compressors always return 0 or >0, so the negative
> > return is compatible.)
> > 
> > 0 could also mean that CCP isn't up yet, but pppd userland doesn't allow
> > NCP's to come up until CCP completes (iff trying to negotiate MPPE).
> 
> Hmmm, and are you sure that nothing can cause CCP to go down?  If it
> does then ppp_generic will send data uncompressed.  What would happen
> if an attacker managed to insert a CCP terminate-request into the
> receive stream somehow?

When (if) CCP goes down, pppd shuts down LCP if MPPE was running.  This
could move into the kernel if you think it's better that way, but I think
userland is ok.

static void
ccp_input(unit, p, len)
{
...
#ifdef MPPE
        if (ccp_gotoptions[unit].mppe) {
            error("MPPE disabled, closing LCP");
            lcp_close(unit, "MPPE disabled by peer");
        }
#endif
}

/fc
