Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293277AbSC0XAq>; Wed, 27 Mar 2002 18:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293306AbSC0XAg>; Wed, 27 Mar 2002 18:00:36 -0500
Received: from th09.opsion.fr ([195.219.20.19]:56840 "HELO th09.opsion.fr")
	by vger.kernel.org with SMTP id <S293277AbSC0XAY>;
	Wed, 27 Mar 2002 18:00:24 -0500
Date: Thu, 28 Mar 2002 00:12:47 +0000
From: S/ash <sl4sh@ifrance.com>
To: linux-kernel@vger.kernel.org
Subject: Re: d_path() truncating excessive long path name vulnerability
Message-Id: <20020328001247.1a6b1779.sl4sh@ifrance.com>
In-Reply-To: <Pine.LNX.4.44.0203261416290.27066-200000@isec.pl>
X-Mailer: Sylpheed version 0.6.6claws (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a copy of a mail i've sent to bugtraq, i'm not currently a subscriber of linux mailing list but i've thought it could interest you.

Welcome i've made a quick patch for 2.2.20 internationnal kernels. I think it should work also for standard 2.2.20 kernels.
It's just quick so i've not made a lot of test but it works.

you need to apply it to path-to-linux-source/fs/dcache.c

Say me if it doesn't work...
S/ash

*** dcache.c.old        Wed Mar 27 14:05:23 2002
--- dcache.c    Wed Mar 27 14:34:13 2002
***************
*** 795,801 ****
--- 795,804 ----
                namelen = dentry->d_name.len;
                buflen -= namelen + 1;
                if (buflen < 0)
+               {
+                       retval = buffer - 1;
                        break;
+               }
                end -= namelen;
                memcpy(end, dentry->d_name.name, namelen);
                *--end = '/';
 
______________________________________________________________________________
ifrance.com, l'email gratuit le plus complet de l'Internet !
vos emails depuis un navigateur, en POP3, sur Minitel, sur le WAP...
http://www.ifrance.com/_reloc/email.emailif


