Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWGFU3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWGFU3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWGFU3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:29:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:37722 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750735AbWGFU3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:29:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jv5QgPWE7fJ9DPApNql9cJgRWLmOuZoHG8XFiK75SBj+xX+ayFEbcuTisFP+/h+DUcjGlfuSDEfxZgZzYe/lVFgqdcIClmfWH+jxWOjmu+WnlP+Otft+J89yKJA2aqe2+BLNRQaQlu76gL2oylH4r2mmpirPvroj8XKhemSs6SY=
Message-ID: <d120d5000607061329t4868d265h6f8285c798a0e3b7@mail.gmail.com>
Date: Thu, 6 Jul 2006 16:29:35 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: lockdep input layer warnings.
Cc: "Dave Jones" <davej@redhat.com>, mingo@redhat.com,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1152212575.3084.88.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060706173411.GA2538@redhat.com>
	 <d120d5000607061137r605a08f9ie6cd45a389285c4a@mail.gmail.com>
	 <1152212575.3084.88.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 2006-07-06 at 14:37 -0400, Dmitry Torokhov wrote:
> > On 7/6/06, Dave Jones <davej@redhat.com> wrote:
> > > One of our Fedora-devel users picked up on this this morning
> > > in an 18rc1 based kernel.
> > >
> > >                Dave
> > >
> > >
> > >  Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
> > >  serio: Synaptics pass-through port at isa0060/serio1/input0
> > >  input: SynPS/2 Synaptics TouchPad as /class/input/input1
> > >  PM: Adding info for serio:serio2
> > >
> > >  =============================================
> > >  [ INFO: possible recursive locking detected ]
> > >  ---------------------------------------------
> >
> > False alarm, there was a lockdep annotating patch for it in -mm.
> not so sure; that patch is supposed to be in -rc1 already; investigating
>

Well, you are right, the patch is in -rc1 and I see mutex_lock_nested
in the backtrace but for some reason it is still not happy. Again,
this is with pass-through Synaptics port and we first taking mutex of
the child device and then (going through pass-through port) trying to
take mutex of the parent.

-- 
Dmitry
