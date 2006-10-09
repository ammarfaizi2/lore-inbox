Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932982AbWJIREE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbWJIREE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932981AbWJIREE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:04:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4345 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932982AbWJIREB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:04:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PRO6GWz9xugbiceZJWha4zmmAZSzHNXiPzFTBn3YWtXTzcP+0K10e5KPTySm50jF3ixnCtzkDD96NFCAaumixLiBG2zfoWiQcQJUBsCzG9O3VaZ9RxwWnAB3y9PJbiMKCGRM5cCXXkrhQi07R1T478hn9+2POuh5luif2kFoTNE=
Date: Mon, 9 Oct 2006 19:03:57 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-git] Fix error handling in create_files()
Message-ID: <20061009170357.GA16816@dreamland.darkstar.lan>
References: <20061009164017.GA13698@dreamland.darkstar.lan> <20061009164820.GA22630@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009164820.GA22630@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Mon, Oct 09, 2006 at 09:48:20AM -0700, Greg KH ha scritto: 
> On Mon, Oct 09, 2006 at 06:40:17PM +0200, Luca Tettamanti wrote:
> > Hello,
> > current code in create_files() detects an error iff the last
> > sysfs_add_file fails:
> > 
> > for (attr = grp->attrs; *attr && !error; attr++) {
> >         error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
> > }
> > if (error)
> >         remove_files(dir,grp);
> > 
> > In order to do the proper cleanup upon failure 'error' must be checked on
> > every iteration.
> 
> But it is, look up there in the "!error" test, right?

Ah, right. I totally missed it.

While we are at it: is it safe to always call sysfs_remove_group even if
the preceding sysfs_create_group failed?

(I'm looking at this warning:

arch/i386/kernel/cpu/mcheck/therm_throt.c: In function 'thermal_throttle_add_dev':
arch/i386/kernel/cpu/mcheck/therm_throt.c:115: warning: ignoring return value of
        'sysfs_create_group', declared with attribute warn_unused_result
)

Luca
-- 
42
