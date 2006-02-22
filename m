Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWBVVJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWBVVJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWBVVJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:09:35 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:32149 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751459AbWBVVJf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:09:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IdIvBha7Zl6Np+dQ/eoQ/JWeGyIgG5SgENTayhQ0dHZ250k9rF2lnYtKhfo5vM1fZNhi37H4z3XVnT3HvEGMeE+0wytMbFSnO7HlCSELrxBfoMJ1BGlcUEob2dy8/ntjV2t0DqidoTns0CXmOpm9M2ER4JrVk3O55v8Xj8QWNEQ=
Message-ID: <d120d5000602221309n58cad283q41a79e6fe013042d@mail.gmail.com>
Date: Wed, 22 Feb 2006 16:09:33 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Suppressing softrepeat
Cc: "Pete Zaitcev" <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
In-Reply-To: <20060222204024.GA7477@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221124308.5efd4889.zaitcev@redhat.com>
	 <20060221210800.GA12102@suse.cz>
	 <20060222120047.4fd9051e.zaitcev@redhat.com>
	 <20060222204024.GA7477@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Wed, Feb 22, 2006 at 12:00:47PM -0800, Pete Zaitcev wrote:
> > On Tue, 21 Feb 2006 22:08:00 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >
> > > A much simpler workaround for the DRAC3 is to set the softrepeat delay
> > > to at least 750ms, using kbdrate(8), which will call the proper console
> > > ioctl, resulting in updating the softrepeat parameters.
> > >
> > > I prefer workarounds for problematic hardware done outside the kernel,
> > > if possible.
> >
> > I agree with the sentiment when posed in the abstract way, but let me
> > tell you why this case is different.
> >
> > Firstly, there's nothing "problematic" about this. It's just how it is.
> > The only problematic thing here is our code. Currently, the situation is
> > assymetric. It is possible to force softrepeat on, but not possible to
> > force softrepeat off. Isn't it broken?
> >
> > Secondly, 750ms may be not enough. Stuart is being shy here and posting
> > explanations to Bugzilla for some reason.
> >
> > Lastly, it's such a PITA to add these things into the userland, that
> > it's completely impractical. Console is needed the most when things go
> > wrong. In such case, that echo(1) may not be reached before the single
> > user shell. And stuffing it into the initrd is for Linux weenies only,
> > unless automated by mkinitrd.
> >
> > I think you're being unreasonable here. I am not asking for NFS root
> > or IP autoconfiguration and sort of complicated process which ought to
> > be done in userland indeed.
>
> I'm definitely not intending to be unreasonable, and I understand your
> need to have the keyboard working all the way from the grub/lilo prompt.
>
> I just don't like adding more module options to one that already has so
> many it's hard to understand what they're used for.
>
> How about simply this patch instead?
>
> Setting autorepeat will not be possible on 'dumb' keyboards anymore by
> default, but since these usually are special forms of hardware anyway,
> like the DRAC3, this shouldn't be an issue for most users. Using
> 'softrepeat' on these keyboards will restore the behavior for users that
> need it.
>

I am not keen on changing the default behaviour... How many dumb
keybaords are out there? I'd rather turn atkbd.softrepeat into a
3-state switch...

--
Dmitry
