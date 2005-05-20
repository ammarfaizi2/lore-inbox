Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVETRHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVETRHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVETRHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:07:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46772 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261512AbVETRHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:07:40 -0400
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context
	at mm/slab.c:2502
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
	 <1116502449.23972.207.camel@hades.cambridge.redhat.com>
	 <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
	 <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu>
	 <1116601195.29037.18.camel@localhost.localdomain>
	 <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil>
	 <1116603414.29037.36.camel@localhost.localdomain>
	 <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 20 May 2005 18:05:29 +0100
Message-Id: <1116608730.29037.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 12:40 -0400, Stephen Smalley wrote:
> @@ -728,6 +739,12 @@ static void audit_log_exit(struct audit_
>                         } /* case AUDIT_SOCKADDR */
>                         break;
>  
> +               case AUDIT_AVC: {
> +                       struct audit_aux_data_avc *axi = (void *)aux;
> +                       if (axi->dentry)
> +                               audit_log_d_path(ab, "path=", axi->dentry, axi->mnt);
> +                       } /* case AUDIT_AVC */
> +                       break;
>                 }
>                 audit_log_end(ab);

It gets freed at this point too, not just in audit_free_aux(). So you
have to do the mntput and dput here too.

-- 
dwmw2

