Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVEKOqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVEKOqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVEKOoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:44:22 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:51611 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261978AbVEKOjL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:39:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yw+4FVGlTGbUB9yNVnSH5UfgtuEvNU7NDS7gQZ8VjlOpBq4tWotrKCsdRDJck4n+5RBLi4pDPgQ9tUMvsRdSVIKvQ+x3f4OcglS+OXrVGcMbYmKEC6HOLt3OgYtX1j2MfBybTt+FdVvKX4BqcFR/yWfA9aZw1GCpHLNwSTEAWs0=
Message-ID: <2cd57c9005051107397bef53a7@mail.gmail.com>
Date: Wed, 11 May 2005 22:39:07 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: kexec?
Cc: maneesh@in.ibm.com, Vivek Goyal <vgoyal@in.ibm.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200505111351.42266.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050508202050.GB13789@charite.de>
	 <2cd57c9005051006117d0c343@mail.gmail.com>
	 <20050511060434.GA8856@in.ibm.com>
	 <200505111351.42266.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, Borislav Petkov <petkov@uni-muenster.de> wrote:
> On Wednesday 11 May 2005 08:04, Maneesh Soni wrote:
> <snip>
> > > > [root@zmei]: kexec -p vmlinux --args-linux --append="root=/dev/hda1
> > > > maxcpus=1 init 1"
> > >
> > >  kexec-tools-1.101 loads for me, but if cmdline is used, it hangs up
> > > after "Starting new kernel"
> >
> > Thanks for trying this out. As Vivek mentioned can you please try with
> > bulding second or dump capture kernel with CONFIG_SMP=N and _without_
> > maxcpus= option. Basically the second kernel's job is just to save the dump
> > and it doesnot need to be a SMP kernel. There are some issues with booting
> > SMP kernel as dump capture kernel.
> 
> Hm, without 'maxcpus' seems to work. However, when booting into the new
> kernel, the rootfs had to be fsck'ed due to "/ was not cleanly unmounted,
> check forced." and then was forced to reboot linux due to inconsistency in
> the fs. I simply did kexec -l <vmlinux> --args-linux --append="root=/dev/hda1
> init 1" and then kexec -e to execute the loaded image. It seems that the
> filesystems are not unmounted properly before loading the second kernel, (or
> I am missing something..., which is more likely :))

kexec is like a bare reboot. 
Add kexec -l and -e just above the reboot line in your
/etc/init.d/reboot script,
or umount manually( sysrq+s sysrq+u ).

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
