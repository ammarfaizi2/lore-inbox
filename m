Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWJXTHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWJXTHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbWJXTHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:07:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:39878 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161184AbWJXTHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:07:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
Date: Tue, 24 Oct 2006 21:07:43 +0200
User-Agent: KMail/1.9.5
Cc: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>
References: <20061024160140.452484000@arndb.de> <20061024160406.923275000@arndb.de> <84144f020610241142y2c86485dj898f555174803577@mail.gmail.com>
In-Reply-To: <84144f020610241142y2c86485dj898f555174803577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610242107.44115.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 October 2006 20:42, Pekka Enberg wrote:
> On 10/24/06, Arnd Bergmann <arnd@arndb.de> wrote:
> >         spu_acquire(ctx);
> > -       for (count = 0; count <= len; count += 4, udata++) {
> > +       for (count = 0; (count + 4) <= len; count += 4, udata++) {
>
> Wouldn't this be more obvious as
>
>   for (count = 0, count < (len / 4); count++, udata++) {
>
> And then do count * 4 if you need the actual index somewhere. Hmm?

Count is the return value from a write() file operation. I find it
more readable to update that every time I do one put_user(), to
the exact value, than calculating the return code later.

	Arnd <>< 
