Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129238AbQKFQen>; Mon, 6 Nov 2000 11:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbQKFQeY>; Mon, 6 Nov 2000 11:34:24 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:32775 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129238AbQKFQeS>; Mon, 6 Nov 2000 11:34:18 -0500
Message-Id: <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Mon, 06 Nov 2000 15:34:54 -0000." <23007.973524894@redhat.com> 
Date: Mon, 06 Nov 2000 13:31:46 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> said:
> jas88@cam.ac.uk said:
> >  Irrelevant. The current mixer settings don't matter: what matters is
> > that the driver does not change them.

> It does matter. The sound driver needs to be able to _read_ the current 
> levels. Almost all mixer programs will start by doing this, to set the 
> slider to the correct place.

OK, how then using _2_ modules, data and worker:

- Data (containing the mixer levels or whatever other data you want to save)
  can only be unloaded after resetting to some default state. When loading
  it sets the default state.
- Worker does the work, and on loading loads the data one (if not yet
  resident) [This is automatic as the worker depends on symbols the data
  module exports].

No funny "persistent data" mechanisms or screwups when the worker gets
removed and reinserted. In many cases the data module could be shared among
several others, in other cases it would have to be able lo load several
times or manage several incarnations of its payload.

Sure, makes sense only if the worker module is largeish; if not, just let
it stay put (When reconfiguring anything, increment module use count;
decrement on reset. This should do the trick also for the data module
above).
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
