Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWF1AZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWF1AZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWF1AZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:25:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:29345 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932407AbWF1AZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:25:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NXOI7h/vQrlucDQgem/hM9v88RB+molu22Ofm0NCY8UCKx7WF2Nkys81lSHvM9nKAanpsL75SOtURmdK3ADMU0OPNszGa0/kEtwrrwpWwS0XyRHa/9vZwbxcH8NnDqucJK3U4Ug131VdWt4EHPFY4osEhrC5E/T44/0h4US5HDo=
Message-ID: <4807377b0606271725u678901a1h8d9d6776b82db3b4@mail.gmail.com>
Date: Tue, 27 Jun 2006 17:25:05 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: git head x86_64 build breakage
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20060627214306.GB372@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4807377b0606271310h41134de8t8c5f60436d73a988@mail.gmail.com>
	 <20060627214306.GB372@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Jun 27, 2006 at 01:10:02PM -0700, Jesse Brandeburg wrote:
> > using a fresh pull of Linus' git, I can't build a kernel right now
> > I get this:
> > make O=../2.6.18.obj/ all -j5
> >  GEN     /home/jbrandeb/2.6.18.obj/Makefile
> > scripts/kconfig/conf -s arch/x86_64/Kconfig
> > init/Kconfig:3: unknown option "option"
> > make[3]: *** [silentoldconfig] Error 1
> > make[2]: *** [silentoldconfig] Error 2
> > make[1]: *** [include/config/auto.conf] Error 2
> > make: *** [all] Error 2
> >
> > reverting to the v2.6.17 init/Kconfig fixes it.
> Look like you did not get kconfig rebuild.
> Try to delete scripts/kconfig/* in your ../2.6.18.obj/ directory and let
> me know if this fixes it.
> It this is a proper fix I need to look into why kconfig binaries was not
> rebuild.

Ah, that worked, I was definitely re-using a directory I had built in
before.  I guess maybe it didn't figure out the dependency somehow.

so to repro (this is pseudo-git, i couldn't figure out how to test
this without starting all over)
git checkout v2.6.17
make O=../foo.obj all
git checkout HEAD
make O=../foo.obj all
<boom>

Thanks!
 Jesse
