Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVALTVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVALTVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVALTUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:20:25 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:2243 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261314AbVALTNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:13:04 -0500
Date: Wed, 12 Jan 2005 20:13:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Brice.Goglin@ens-lyon.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc1
Message-ID: <20050112191313.GC2605@ucw.cz>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <41E4DEBB.90606@ens-lyon.fr> <Pine.LNX.4.58.0501120739130.2373@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501120739130.2373@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 07:50:13AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 12 Jan 2005, Brice Goglin wrote:
> > 
> > setkeycodes does not work anymore on my Compaq Evo N600c running a Debian testing.
> > 
> > puligny:~# setkeycodes e023 150 e01e 155 e01a 217 e01f 157
> > KDSETKEYCODE: No such device
> > failed to set scancode a3 to keycode 150
> 
> Interesting. Vojtech - does this ring any bells? 
> 
> Afaik, nothing has changed in KDESTKEYCODE, the thing that comes closest 
> is a change to some parameter calling in the vt layer by Christoph.
> 
> Input layer?
 
Yes, a bug in atkbd.c, sorry. This fix:

ChangeSet@1.1966.1.261, 2005-01-06 17:42:15+01:00,
dtor_core@ameritech.net
  Input: atkbd - fix keycode table size initialization that got broken
         by my changes that exported 'set' and other settings via sysfs.
         setkeycodes should work again now.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

now in my BK tree fixes it. Another fix from Dmitry for mouse naming is
in there too (and that's all that's there ATM).

Please pull from

	bk://bk://kernel.bkbits.net/vojtech/input

Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
