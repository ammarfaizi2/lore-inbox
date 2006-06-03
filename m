Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWFCQLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWFCQLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 12:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFCQLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 12:11:45 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:9890 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751195AbWFCQLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 12:11:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] Declare explicit, hardware based lock ranking in serio
Date: Sat, 3 Jun 2006 12:11:42 -0400
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Linux Portal <linportal@gmail.com>
References: <ceccffee0606020953q545d1f3aw211da426e5cfc768@mail.gmail.com> <200606030756.39861.dtor_core@ameritech.net> <1149336677.3109.34.camel@laptopd505.fenrus.org>
In-Reply-To: <1149336677.3109.34.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031211.42976.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 08:11, Arjan van de Ven wrote:
> On Sat, 2006-06-03 at 07:56 -0400, Dmitry Torokhov wrote:
> > On Saturday 03 June 2006 04:50, Arjan van de Ven wrote:
> > > > Thanks.
> > > > 
> > > > So we're taking ps2->cmd_mutex and then we're recurring back into
> > > > ps2_command() and then taking ps2->serio->cmd_mutex.
> > > > 
> > > > I suspect that's all correct/natural/expected and needs another
> > > > make-lockdep-shut-up patch.
> > > 
> > > 
> > > The PS/2 code has a natural device order and there is a one level
> > > recursion in this device order in terms of the cmd_mutex; annotate 
> > > this explicit recursion as ok
> > > 
> > 
> > It is not necessarily single depth - one could have 2 or more pass-through
> > ports chained together, although currently in kernel we only have Synaptics
> > pass-through. If we were ever to implement pass-through port for IBMs
> > trackpoints then we'd have:
> > 
> > 	Synaptics<->pass-through<->TP<->pass-through<->some mouse
> 
> is there a bound to this? lockdep can deal with upto 8 or so
> recursions....
> 
 
Theoretically - no, practically - 2 as shown above. At the moment the
only devices that are using/may be using pass-through ports are Synaptics
touchpad and IBM trackpoint.

-- 
Dmitry
