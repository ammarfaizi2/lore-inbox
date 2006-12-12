Return-Path: <linux-kernel-owner+w=401wt.eu-S1750915AbWLLCRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWLLCRp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 21:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWLLCRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 21:17:45 -0500
Received: from isilmar.linta.de ([213.239.214.66]:41763 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750915AbWLLCRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 21:17:44 -0500
Date: Mon, 11 Dec 2006 21:17:42 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-ID: <20061212021742.GA2820@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Andrew MChuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org> <20061211093314.GC4587@ftp.linux.org.uk> <20061211014727.21c4ab25.akpm@osdl.org> <20061211100301.GD4587@ftp.linux.org.uk> <20061211021718.a6954106.akpm@osdl.org> <20061211022746.9ec80c03.akpm@osdl.org> <20061211104556.GF4587@ftp.linux.org.uk> <Pine.LNX.4.64.0612110748570.12500@woody.osdl.org> <20061211180822.5f7814d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211180822.5f7814d5.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 06:08:22PM -0800, Andrew Morton wrote:
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 5eb5d24..5a593a1 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -111,6 +111,7 @@ extern void setup_arch(char **);
> >  #define subsys_initcall_sync(fn)	__define_initcall("4s",fn,4s)
> >  #define fs_initcall(fn)			__define_initcall("5",fn,5)
> >  #define fs_initcall_sync(fn)		__define_initcall("5s",fn,5s)
> > +#define rootfs_initcall(fn)		__define_initcall("rootfs",fn,rootfs)
> >  #define device_initcall(fn)		__define_initcall("6",fn,6)
> >  #define device_initcall_sync(fn)	__define_initcall("6s",fn,6s)
> >  #define late_initcall(fn)		__define_initcall("7",fn,7)
> 
> Looks like this might break pcmcia which for some reason does firmware
> requesting at fs_initcall level (drivers/pcmcia/ds.c).

That codepath is not triggered before device_initcall()s occur. So it's a
non-issue for PCMCIA.

Thanks,
	Dominik
