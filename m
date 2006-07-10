Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWGJPxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWGJPxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWGJPxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:53:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422667AbWGJPxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:53:35 -0400
Subject: Re: lockdep input layer warnings.
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dave Jones <davej@redhat.com>, mingo@redhat.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000607100849k5af2ee78o2715d9a51b06c000@mail.gmail.com>
References: <20060706173411.GA2538@redhat.com>
	 <d120d5000607061137r605a08f9ie6cd45a389285c4a@mail.gmail.com>
	 <1152212575.3084.88.camel@laptopd505.fenrus.org>
	 <d120d5000607061329t4868d265h6f8285c798a0e3b7@mail.gmail.com>
	 <1152544371.4874.66.camel@laptopd505.fenrus.org>
	 <d120d5000607100849k5af2ee78o2715d9a51b06c000@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 17:53:32 +0200
Message-Id: <1152546812.4874.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 11:49 -0400, Dmitry Torokhov wrote:
> On 7/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Thu, 2006-07-06 at 16:29 -0400, Dmitry Torokhov wrote:
> > >
> > > Well, you are right, the patch is in -rc1 and I see mutex_lock_nested
> > > in the backtrace but for some reason it is still not happy. Again,
> > > this is with pass-through Synaptics port and we first taking mutex of
> > > the child device and then (going through pass-through port) trying to
> > > take mutex of the parent.
> >
> > Ok it seems more drastic measures are needed; and a split of the
> > cmd_mutex class on a per driver basis. The easiest way to do that is to
> > inline the lock initialization (patch below) but to be honest I think
> > the patch is a bit ugly; I considered inlining the entire function
> > instead, any opinions on that?
> >
> 
> It is ugly. Maybe we could have something like mutex_init_nolockdep()
> to annotate that lockdep is confused and make it ignore such locks?

nope but there is a function to make it unique, we could put that in the
wrapper instead of mutex_init if that makes it less ugly..

