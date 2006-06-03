Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWFCML5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWFCML5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 08:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWFCML5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 08:11:57 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:33492 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750909AbWFCML5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 08:11:57 -0400
Subject: Re: [patch] Declare explicit, hardware based lock ranking in serio
From: Arjan van de Ven <arjan@linux.intel.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, arjanv@redhat.com, Linux Portal <linportal@gmail.com>
In-Reply-To: <200606030756.39861.dtor_core@ameritech.net>
References: <ceccffee0606020953q545d1f3aw211da426e5cfc768@mail.gmail.com>
	 <20060602161354.687168de.akpm@osdl.org>
	 <1149324621.3109.16.camel@laptopd505.fenrus.org>
	 <200606030756.39861.dtor_core@ameritech.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Jun 2006 14:11:17 +0200
Message-Id: <1149336677.3109.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 07:56 -0400, Dmitry Torokhov wrote:
> On Saturday 03 June 2006 04:50, Arjan van de Ven wrote:
> > > Thanks.
> > > 
> > > So we're taking ps2->cmd_mutex and then we're recurring back into
> > > ps2_command() and then taking ps2->serio->cmd_mutex.
> > > 
> > > I suspect that's all correct/natural/expected and needs another
> > > make-lockdep-shut-up patch.
> > 
> > 
> > The PS/2 code has a natural device order and there is a one level
> > recursion in this device order in terms of the cmd_mutex; annotate 
> > this explicit recursion as ok
> > 
> 
> It is not necessarily single depth - one could have 2 or more pass-through
> ports chained together, although currently in kernel we only have Synaptics
> pass-through. If we were ever to implement pass-through port for IBMs
> trackpoints then we'd have:
> 
> 	Synaptics<->pass-through<->TP<->pass-through<->some mouse

is there a bound to this? lockdep can deal with upto 8 or so
recursions....
