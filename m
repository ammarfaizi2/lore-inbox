Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWILTct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWILTct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWILTct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:32:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:43652 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030371AbWILTct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:32:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Rzy4BhzhWP9v3zswFRjau6VWQ3xkOSH0IuJvP5dGSm85EsAtOa06Jps7OxeMEFnUakVKG2A71rVRcLjhhSHrk6EUZz8UT6kFQjnHN19jLzNnkn3ds3zLLuIS1xG3YJ9Cwh3ErZcdP1S0p50MaEdGVsmqTRaq5ffSxOG5zYw4Nmo=
Date: Tue, 12 Sep 2006 21:31:52 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk+kernel@arm.linux.org.uk
Subject: Re: [-mm patch] arm build fail: vfpsingle.c
Message-ID: <20060912213152.GA2579@slug>
References: <20060912000618.a2e2afc0.akpm@osdl.org> <20060912200522.GN3775@slug> <4506FC2D.2070109@oracle.com> <20060912210039.GB1539@slug> <45070577.9040100@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45070577.9040100@oracle.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 12:07:35PM -0700, Zach Brown wrote:
> 
> > Yes it does, but the intended use of 'func' (or so I understood) is to
> > print the calling function name, not the current function's, isn't it?
> 
> Dunno, I took it to mean the current function from the context of that
> patch.  I could be wrong, of course.
I've just checked, this are some of the callers of
vfp_single_normaliseround (last argument is 'func'):

in vfp_single_fuito: 
	vfp_single_normaliseround(sd, &vs, fpscr, 0, "fuito");
in vfp_single_fsito:
	vfp_single_normaliseround(sd, &vs, fpscr, 0, "fsito");
in vfp_single_fnmul:
	vfp_single_normaliseround(sd, &vsd, fpscr, exceptions, "fnmul");

It definitely looks like we want the calling function to be printed
here.

Regards,
Frederik

> 
> - z
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
