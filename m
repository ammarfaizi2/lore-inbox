Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUF3Rvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUF3Rvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUF3Rv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:51:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9930 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266790AbUF3RvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:51:08 -0400
Date: Wed, 30 Jun 2004 12:50:27 -0500
From: linas@austin.ibm.com
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
Message-ID: <20040630125027.T21634@forte.austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com> <16610.41869.78636.349800@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16610.41869.78636.349800@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Jun 30, 2004 at 09:27:09PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 30, 2004 at 09:27:09PM +1000, Paul Mackerras wrote:
> Linas,
> 
> > This patch moves the location of a lock in order to protect
> > the contents of a buffer until it has been copied to its final
> > destination. Prior to this, a race existed whereby the buffer
> > could be filled even while it was being emptied.
> 
> Given that log_error() seems to be a no-op at the moment AFAICT, and

!!
Too many kernel trees.  Someone must have whacked the ameslab tree
by accident, or on purpose, because they got sick of seeing rtas 
messages.  I don't find the RTAS messages to be pleasent, but simply
whacking them is not the right solution.  The following diff is 
between an older tree and the current tree.  If you could re-add 
these lines, that would be great.

--linas


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chrp-setup.patch"

--- ameslab-2.6.7-25june/arch/ppc64/kernel/chrp_setup.c	2004-06-29 17:04:30.000000000 -0500
+++ linux-2.6.5-20040514/arch/ppc64/kernel/chrp_setup.c	2004-06-29 17:28:48.000000000 -0500
@@ -243,6 +243,12 @@ chrp_init(unsigned long r3, unsigned lon
 		ppc_md.get_irq        = xics_get_irq;
 	}
 
+#ifdef CONFIG_PPC_PSERIES
+	ppc_md.log_error = pSeries_log_error;
+#else
+	ppc_md.log_error = NULL;
+#endif
+
 	ppc_md.init           = chrp_init2;
 
 	ppc_md.pcibios_fixup  = pSeries_final_fixup;

--nOM8ykUjac0mNN89--
