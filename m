Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266792AbSLJXCV>; Tue, 10 Dec 2002 18:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbSLJXCV>; Tue, 10 Dec 2002 18:02:21 -0500
Received: from AMarseille-201-1-4-202.abo.wanadoo.fr ([217.128.74.202]:39795
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266792AbSLJXCT>; Tue, 10 Dec 2002 18:02:19 -0500
Subject: Re: xxx_check_var
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <15862.27978.670448.901111@argo.ozlabs.ibm.com>
References: <15862.27978.670448.901111@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Dec 2002 00:13:48 +0100
Message-Id: <1039562028.3373.32.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 23:40, Paul Mackerras wrote:
> When I look at atyfb_check_var or aty128fb_check_var, I see that they
> will alter the contents of *info->par.  Isn't this a bad thing?  My

Yes, this wrong, and afaik, it's your original port to 2.5 that did that
;)

> understanding was that after calling check_var, you don't necessarily
> call set_par next (particularly if check_var returned an error).
> Also I notice that atyfb_set_par and aty128fb_set_par don't look at
> info->var, they simply set the hardware state based on the contents of
> *info->par.

Which is wrong too indeed

> Looking at skeletonfb.c, it seems that this is the wrong behaviour.  I
> had fixed the aty128fb.c driver in the linuxppc-2.5 tree.  James, if
> you let me know whether the current behaviour is wrong or not, I'll
> fix them and send you the patch.

I _think_ my radeonfb (in linuxppc-2.5) is right in this regard too.
Look at the initialization too, iirc, you had some non necessary stuff
in there (calling gen_set_disp, gen_set_var is plenty enough).

Ben.

 
> Paul.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

