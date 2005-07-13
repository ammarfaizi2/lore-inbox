Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVGMRzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVGMRzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVGMRxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:53:55 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:54697 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262155AbVGMRwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:52:03 -0400
Message-Id: <200507131751.j6DHpkBE016946@laptop11.inf.utfsm.cl>
To: Nicholas Hans Simmonds <nhstux@gmail.com>
cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Filesystem capabilities support 
In-Reply-To: Message from Nicholas Hans Simmonds <nhstux@gmail.com> 
   of "Wed, 13 Jul 2005 07:29:55 +0100." <20050713062955.GA1609@laptop> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 13 Jul 2005 13:51:46 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 13 Jul 2005 13:51:47 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Hans Simmonds <nhstux@gmail.com> wrote:
> Sorry, my earlier reply seems to have gotten lost somewhere. I've been
> pondering this issue for some time and am still not sure what's the best
> answer. I've attached a small patch which handles this by detecting byte
> swapping of the version code. I'm not convinced it's necessary but
> shouldn't hurt.
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -153,6 +153,15 @@ int cap_bprm_set_security (struct linux_
>  	down(&bprm_dentry->d_inode->i_sem);
>  	ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
>  	if(ret == sizeof(caps)) {
> +		if(caps.version = swab32(_LINUX_CAPABILITY_VERSION)) {
                                ^
				|
				+-- Surely wrong?!

> +			swab32s(&caps.version);
> +			swab32s(&caps.effective);
> +			swab32s(&caps.mask_effective);
> +			swab32s(&caps.permitted);
> +			swab32s(&caps.mask_permitted);
> +			swab32s(&caps.inheritable);
> +			swab32s(&caps.mask_inheritable);
> +		}
>  		if(caps.version == _LINUX_CAPABILITY_VERSION) {
>  			cap_t(bprm->cap_effective) &= caps.mask_effective;
>  			cap_t(bprm->cap_effective) |= caps.effective;
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
