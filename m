Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753513AbWKHUQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbWKHUQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbWKHUQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:16:38 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:65172 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753513AbWKHUQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:16:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j0pXY8pljEb2PRi4K6KJad0Y0LkL4GRrc9UpXVUEcdgMg0Rk4iVv4kaxjCuJj66GXI5dxpWxI/DPmPYmSHoSD4Pa/SWW/TUKS5ev1I8AfieZUGPHxmq3mqBTSyGPViP3O3aYqyGQRsiMDXtfyIm0X2JvzCbzBcLN3EjPrSDUXoM=
Message-ID: <653402b90611081216o640b1499u8c758775c1cceb51@mail.gmail.com>
Date: Wed, 8 Nov 2006 20:16:35 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: How to compile module params into kernel?
Cc: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490611081209s37e5bfa7m2ddb49a23288ffbd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490611081105j5ca1d24ahd49c6d9ea7d980d3@mail.gmail.com>
	 <02fd01c70370$d9af6700$020120ac@Jocke>
	 <9a8748490611081209s37e5bfa7m2ddb49a23288ffbd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > -----Original Message-----
> > > From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> > >
> > > On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > > Instead of passing a module param on the cmdline I want to
> > > compile that
> > > > into
> > > > the kernel, but I can't figure out how.
> > > >
> > > > The module param I want compile into kernel is
> > > > rtc-ds1307.force=0,0x68
> > > >
> > > > This is for an embeddet target that doesn't have loadable module
> > > > support.
> > > >
> > > You could edit the module source and hardcode default values.
> > >
> >
> > Yes, but I don't want to do that since it makes maintance
> > harder.
> >
> Well, as far as I know, there's no way to specify default module
> options at compile time. The defaults are set in the module source and
> are modifiable at module load time or by setting options on the kernel
> command line at boot tiem. So, if that's no good for you I don't see
> any other way except modifying the source to hardcode new defaults.
>

You can add parameter values at Kconfig using "int", "hex"... instead
of tristate, and then do something like:

static unsigned int foo = CONFIG_foo;
module_param(foo, uint, S_IRUGO);
MODULE_PARM_DESC(foo, "foo value (uint)");
