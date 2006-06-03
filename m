Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbWFCL4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWFCL4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 07:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWFCL4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 07:56:43 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:32437 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932621AbWFCL4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 07:56:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] Declare explicit, hardware based lock ranking in serio
Date: Sat, 3 Jun 2006 07:56:39 -0400
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, arjanv@redhat.com, Linux Portal <linportal@gmail.com>
References: <ceccffee0606020953q545d1f3aw211da426e5cfc768@mail.gmail.com> <20060602161354.687168de.akpm@osdl.org> <1149324621.3109.16.camel@laptopd505.fenrus.org>
In-Reply-To: <1149324621.3109.16.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606030756.39861.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 04:50, Arjan van de Ven wrote:
> > Thanks.
> > 
> > So we're taking ps2->cmd_mutex and then we're recurring back into
> > ps2_command() and then taking ps2->serio->cmd_mutex.
> > 
> > I suspect that's all correct/natural/expected and needs another
> > make-lockdep-shut-up patch.
> 
> 
> The PS/2 code has a natural device order and there is a one level
> recursion in this device order in terms of the cmd_mutex; annotate 
> this explicit recursion as ok
> 

It is not necessarily single depth - one could have 2 or more pass-through
ports chained together, although currently in kernel we only have Synaptics
pass-through. If we were ever to implement pass-through port for IBMs
trackpoints then we'd have:

	Synaptics<->pass-through<->TP<->pass-through<->some mouse

-- 
Dmitry
