Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267873AbTAHUsd>; Wed, 8 Jan 2003 15:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTAHUsc>; Wed, 8 Jan 2003 15:48:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:10254 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267873AbTAHUsb>;
	Wed, 8 Jan 2003 15:48:31 -0500
Date: Wed, 8 Jan 2003 21:56:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Miles Bader <miles@gnu.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Embed __this_module in module itself.
Message-ID: <20030108205645.GA4037@mars.ravnborg.org>
Mail-Followup-To: Miles Bader <miles@gnu.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20021227104328.143DD2C05D@lists.samba.org> <buou1gma6bz.fsf@mcspd15.ucom.lsi.nec.co.jp> <buoadid1pxl.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoadid1pxl.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 02:36:54PM +0900, Miles Bader wrote:
> Miles Bader <miles@lsi.nec.co.jp> writes:
> > When I try to build modules using 2.5.54, the resulting .ko files lack
> > the .gnu.linkonce.* sections, which causes the kernel module loader to
> > fail on them -- those sections _are_ present in the .o files, but the
> > linker apparently removes them!
> 
> Ok, I found out why this is happening -- the v850 default linker
> scripts, for whatever reason, merge any section called `.gnu.linker.t*'
> with .text.
ld per default uses a default linker-scripts as you note.
Could another solution be to provide a fixed linker script, used for all
invocations of ld?

LDFLAGS += -T arch/v850/v850.lds

Not knowing much about v850, I wonder why you do not need to set the -m
option. Most other architectures do this.

	Sam
