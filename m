Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278093AbRJPFQr>; Tue, 16 Oct 2001 01:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278092AbRJPFQh>; Tue, 16 Oct 2001 01:16:37 -0400
Received: from rj.sgi.com ([204.94.215.100]:15321 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278093AbRJPFQQ>;
	Tue, 16 Oct 2001 01:16:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] large /proc/mounts and friends 
In-Reply-To: Your message of "Mon, 15 Oct 2001 21:41:49 MST."
             <Pine.LNX.4.33.0110152132110.8730-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 15:16:40 +1000
Message-ID: <20357.1003209400@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 21:41:49 -0700 (PDT), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>	s_seek()
>	{
>		struct mod_sym *v = p;
>		int mod_nr = pos >> 32;
>		while (mod_nr && v->mod) {
>			mod_nr--;
>			v->mod = v->mod->next;
>		};
>	}

If a module is deleted between calls to s_seek() and that deletion is
before mod_nr then the caller has seen the deleted module but a later
module will transiently disappear.  I don't see how counting on a
linked list which is subject to deletion at any point can deliver
reliable results.  Seeing the old module is wrong but acceptable.  Not
seeing a module that still exists is wrong.

