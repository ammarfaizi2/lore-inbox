Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287699AbSBIVpZ>; Sat, 9 Feb 2002 16:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287840AbSBIVpP>; Sat, 9 Feb 2002 16:45:15 -0500
Received: from femail37.sdc1.sfba.home.com ([24.254.60.31]:29580 "EHLO
	femail37.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287699AbSBIVpD>; Sat, 9 Feb 2002 16:45:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry McVoy <lm@bitmover.com>, Stelian Pop <stelian.pop@fr.alcove.com>
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Date: Sat, 9 Feb 2002 16:45:58 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <20020209181213.GA32401@come.alcove-fr> <20020209201252.GD32401@come.alcove-fr> <20020209122649.E13735@work.bitmover.com>
In-Reply-To: <20020209122649.E13735@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020209214503.UJGI19279.femail37.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 February 2002 03:26 pm, Larry McVoy wrote:
> > > I also push it to my private version on bkbits.net, and it is supposed
> > > to be automatically then pushed onwards to the public one that is at
> > > http://linux.bkbits.net:8080/linux-2.5, but the infrastructure for that
> > > isn't yet working.
> >
> > Ok, understood. While waiting for a 'proper' infrastructure', maybe
> > a simple cron entry will do the job ? (since the bk pull from your
> > private tree on bkbits to the public tree on bkbits is not supposed
> > to ever fail or have merge errors...)
>
> This is my problem.  You could help if you could tell me what exactly
> are the magic wands to wave such that you can ssh in without typing
> a password.

You need three or four files in the .ssh directory of the account in 
question.  (This is assuming that ssh protocol 2 comes first in your 
ssh_config and sshd_config files.)

1) The file ~/.ssh/known_hosts2 lists the host keys.  If you just ssh to a 
box it'll prompt you if it should add an unknown key to the file.  (Just do 
this manually once in each direction and this file will be happy.  You can 
assemble it manually from /etc/ssh/ssh_host_key.pub if you want, but I doubt 
you need to.)

2) Generate a public/private pair of dsa encryption keys, with:

ssh-keygen -d -f ~/.ssh/id_dsa

Just press enter twice for the passphrase (you don't want one for 
passwordless sshing).

3) In the .ssh dir, copy "id_dsa.pub" to "authorized_keys2"

4) Copy the three files you just created (id_dsa, id_dsa.pub, and 
authorized_keys2) to the ~/.ssh directory on the other box.

This allows bidirectional passwordless sshing.  If you want to only ssh in 
one direction, keep the public keys (id_dsa.pub and authorized_keys2) but zap 
the private key on the appropriate box.

Now just try to ssh as the user in question.  (su username, then ssh 1.2.3.4)

If you're piping data from one box to another, you might want to use the -T 
option to tell it no controlling TTY.  (Largely a matter of personal 
taste...)  And sometimes -C "echo hello" works better than just having the 
commands explicitly on the end of the command line...

I have this working over here.  If I missed a step, email me.

Rob
