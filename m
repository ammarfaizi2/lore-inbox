Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWJXTxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWJXTxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWJXTxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:53:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62356 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161116AbWJXTxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:53:35 -0400
Subject: Re: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610242107.44115.arnd@arndb.de>
References: <20061024160140.452484000@arndb.de>
	 <20061024160406.923275000@arndb.de>
	 <84144f020610241142y2c86485dj898f555174803577@mail.gmail.com>
	 <200610242107.44115.arnd@arndb.de>
Content-Type: text/plain
Organization: IBM
Date: Tue, 24 Oct 2006 14:53:22 -0500
Message-Id: <1161719603.8946.84.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-24-10 at 21:07 +0200, Arnd Bergmann wrote:
> On Tuesday 24 October 2006 20:42, Pekka Enberg wrote:
> > On 10/24/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > >         spu_acquire(ctx);
> > > -       for (count = 0; count <= len; count += 4, udata++) {
> > > +       for (count = 0; (count + 4) <= len; count += 4, udata++) {
> >
> > Wouldn't this be more obvious as
> >
> >   for (count = 0, count < (len / 4); count++, udata++) {
> >
> > And then do count * 4 if you need the actual index somewhere. Hmm?
> 
> Count is the return value from a write() file operation. I find it
> more readable to update that every time I do one put_user(), to
> the exact value, than calculating the return code later.

Hey Arnd, 
   just curiosity..   What was the behavior before this patch?   just
leaving a few (0 - 3) characters behind?


> 
> 	Arnd <>< 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

