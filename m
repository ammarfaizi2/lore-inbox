Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbTALMsE>; Sun, 12 Jan 2003 07:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbTALMsE>; Sun, 12 Jan 2003 07:48:04 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27923 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265222AbTALMsD>;
	Sun, 12 Jan 2003 07:48:03 -0500
Date: Sun, 12 Jan 2003 13:56:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Rolland <rol@witbe.net>
Cc: linux-kernel@vger.kernel.org, Perex@suze.cz, rol@as2917.net
Subject: Re: [PATCH 2.5.56] Sound core not compiling without /proc support
Message-ID: <20030112125645.GA996@mars.ravnborg.org>
Mail-Followup-To: Paul Rolland <rol@witbe.net>,
	linux-kernel@vger.kernel.org, Perex@suze.cz, rol@as2917.net
References: <008f01c2ba32$3aab6f40$2101a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008f01c2ba32$3aab6f40$2101a8c0@witbe>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 01:00:40PM +0100, Paul Rolland wrote:
> Hello,
> 
> Here is a quick patch to allow sound support to compile correctly
> when not using /proc support.

You are making all users of functions manipulating /proc condentional.
A simpler approach would be to make the functions that actually
minipulate /proc conditional.
For example snd_info_card_create() could be a noop if CONFIG_PROC_FS
is not defined.
Then you minimize the number of #ifdef's, and they are placed logically
where they belongs.

Furhtermore you make less code conditional which imply that the execution
path - and thus code getting more test - is more similar for the two cases.

	Sam
