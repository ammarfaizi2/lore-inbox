Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRI0GlL>; Thu, 27 Sep 2001 02:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270645AbRI0GlC>; Thu, 27 Sep 2001 02:41:02 -0400
Received: from chiara.elte.hu ([157.181.150.200]:2829 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S270229AbRI0Gkv>;
	Thu, 27 Sep 2001 02:40:51 -0400
Date: Thu, 27 Sep 2001 08:38:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
        <netdev@oss.sgi.com>, Andreas Dilger <adilger@turbolabs.com>
Subject: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109270746150.1679-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Marcelo Tosatti wrote:

> Don't you think it would be useful to have some reserved memory for
> the netconsole use ?
> It would be nice to have a guarantee that messages are sent over
> network even if the system is under real OOM.

yep, that is very useful indeed.

i've implemented a private emergency pool of 32 packets that we try to
keep filled as much as possible, and which one we use only if GFP_ATOMIC
fails. The new patch can downloaded from:

   http://redhat.com/~mingo/netconsole-patches/netconsole-2.4.10-B1

the patch also includes Andrew Morton's suggestion to add the
HAVE_POLL_CONTROLLER define for easier network-driver integration. The
eepro100.c changes now use this define.

the new utilities-tarball is at:

   http://redhat.com/~mingo/netconsole-patches/netconsole-client-20010927.tar.gz

this includes Andreas Dilger's netconsole-server script. (i've done a
minor modification to the script, it insmods the netconsole module with
the parameters.)

there is one more thing we could do: we could also allocate the skb on
stack in extreme cases. This adds noticeable latency though, since the skb
xmit has to be polled for completion as well [this can be done with the
current ->poll_controller() method], but this way the netconsole could be
self-sufficient and would be completely independent of the VM.

reports, suggestions, comments welcome,

	Ingo

