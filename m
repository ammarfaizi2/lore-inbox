Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTGHPst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTGHPss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:48:48 -0400
Received: from www.13thfloor.at ([212.16.59.250]:44678 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S264127AbTGHPsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:48:46 -0400
Date: Tue, 8 Jul 2003 18:03:29 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jarmo =?iso-8859-1?B?SuRydmVucOTk?= <Jarmo.Jarvenpaa@softers.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Max binds
Message-ID: <20030708160329.GB3233@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Jarmo =?iso-8859-1?B?SuRydmVucOTk?= <Jarmo.Jarvenpaa@softers.net>,
	linux-kernel@vger.kernel.org
References: <3F0A52F0.5BA389F9@softers.net> <20030708065804.GI150921@niksula.cs.hut.fi> <3F0A8841.5BC7DD39@softers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F0A8841.5BC7DD39@softers.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 12:00:49PM +0300, Jarmo Järvenpää wrote:
> Ville Herva wrote:
> > 
> > See
> > >http://groups.google.com/groups?dq=&hl=en&lr=&ie=UTF-8&threadm=linux.kernel.3AE307AD.821AB47C%40linuxjedi.org&rn
> 
> >um=1&prev=/groups%3Fq%3Dg:thl1557665770d%26dq%3D%26hl%3Den%26lr%3D%26ie%3DUTF-8%26selm%3Dlinux.kernel.3AE307AD.8>21AB47C%2540linuxjedi.org
> 
> Hmm, I read the thread and it contained mostly stats on memory usage on
> different scenarios. Also, bit outdated discussion (kernel v 2.4.4). No
> direct answer though. 

I'm no expert on the mount --bind stuff, but as far
as I understand it, this is simple (I guess Al Viro 
would agree *g*) VFS magic, so what happens seems to
be the following:

 - a new vfsmount entry is created by either
   copying the old tree or cloning the original
   mount (if it is a mountpoint)
 - the required dentries are added to the dcache

so the number of --bind mounts from another mount
point will be roughly limited by the number of
vfsmount structures possible, and the space available
to cache/store dentries ...

I guess there will be some tradeoff when the number
of --bind mounts becomes very high, but I guess it
is neglectible for normal use ...

I might be totaly wrong, so do not rely on it 8-)

HTH,
Herbert

> Jarmo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
